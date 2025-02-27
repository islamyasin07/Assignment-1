import 'package:flutter/material.dart';
import '../widgets/book_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, Map<String, dynamic>> booksData = {}; 
  TextEditingController searchText = TextEditingController();
  String genreFilter = "";

  void addNewBook({required String bookName, required String bookAuthor, required int bookYear, required String bookGenre}) {
    setState(() {
      booksData[bookName] = {
        'author': bookAuthor,
        'year': bookYear,
        'genre': bookGenre
      };
    });
  }

  void deleteBook(String bookName) {
    setState(() {
      booksData.remove(bookName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], 
        title: const Text('Books Library'),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.88,
            child: Image.network(
              'https://img.freepik.com/free-photo/international-day-education-cartoon-style_23-2151007424.jpg?semt=ais_hybrid',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: searchText,
                  onChanged: (text) => setState(() {}),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search for a book...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<String>(
                  value: genreFilter,
                  hint: const Text("Filter by Genre"),
                  onChanged: (String? newGenre) {
                    setState(() {
                      genreFilter = newGenre ?? "";
                    });
                  },
                  items: ["", "Fantasy", "Horror", "History"]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: booksData.isEmpty
                    ? const Center(
                        child: Text(
                          "No books to show",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: booksData.length,
                        itemBuilder: (context, index) {
                          String bookName = booksData.keys.elementAt(index);
                          var bookDetails = booksData[bookName]!;
                          bool matchesSearch = bookName.toLowerCase().contains(searchText.text.toLowerCase());
                          bool matchesGenre = genreFilter.isEmpty || bookDetails['genre'] == genreFilter;

                          if (matchesSearch && matchesGenre) {
                            return BookCard(
                              bookTitle: bookName,
                              bookAuthor: bookDetails['author'],
                              bookYear: bookDetails['year'],
                              bookGenre: bookDetails['genre'],
                              onRemove: () => deleteBook(bookName),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => showAddBookDialog(context, addNewBook),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String bookTitle;
  final String bookAuthor;
  final int bookYear;
  final String bookGenre;
  final VoidCallback onRemove;

  const BookCard({
    super.key,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookYear,
    required this.bookGenre,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          bookTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "$bookAuthor - $bookYear",
          style: const TextStyle(color: Colors.black87),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
