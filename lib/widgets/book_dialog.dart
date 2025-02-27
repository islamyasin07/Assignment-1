import 'package:flutter/material.dart';

void showAddBookDialog(
  BuildContext context, 
  Function({required String bookName, required String bookAuthor, required int bookYear, required String bookGenre}) addBook
) {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Add New Book"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: "Author"),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(labelText: "Year"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: genreController,
              decoration: const InputDecoration(labelText: "Genre"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              String bookName = titleController.text.trim();
              String bookAuthor = authorController.text.trim();
              int? bookYear = int.tryParse(yearController.text.trim());
              String bookGenre = genreController.text.trim();

              if (bookName.isNotEmpty && bookAuthor.isNotEmpty && bookYear != null && bookGenre.isNotEmpty) {
                addBook(
                  bookName: bookName,
                  bookAuthor: bookAuthor,
                  bookYear: bookYear,
                  bookGenre: bookGenre
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
