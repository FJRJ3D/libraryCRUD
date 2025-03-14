import 'package:flutter/material.dart';
import 'package:library_crud/book_service.dart';
import 'package:library_crud/book.dart';
import 'package:library_crud/inputs.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookListScreen extends StatefulWidget {
  final Book_service bookService;

  const BookListScreen({Key? key, required this.bookService}) : super(key: key);

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _updateBook(BuildContext context, String bookId) async {
    Book? bookToUpdate = await widget.bookService.getBookById(bookId);
    if (bookToUpdate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Book not found')),
      );
      return;
    }
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookInputList(
          bookService: widget.bookService,
          existingBook: bookToUpdate,
        ),
      ),
    );
    setState(() {});
  }

  Future<void> _deleteBook(String bookId) async {
    String result = await widget.bookService.deleteBookById(bookId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
    setState(() {});
  }

  Future<void> _reserveBook(String bookId) async {
    String result = await widget.bookService.reserveBook(bookId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
    setState(() {});
  }

  Future<String?> _getUserUID() async {
    User? user = _auth.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books list"),
      ),
      body: FutureBuilder<List<Book>>(
        future: widget.bookService.getAllBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          List<Book>? books = snapshot.data;
          if (books == null || books.isEmpty) {
            return const Center(child: Text("The list of books is empty"));
          }

          return FutureBuilder<String?>(
            future: _getUserUID(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              String? userUID = userSnapshot.data;

              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  bool isUserBook = book.userUID == userUID;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: isUserBook ? Colors.white54 : Colors.white30,
                    child: ListTile(
                      title: Text(book.name ?? "?"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Author: ${book.author ?? "?"}"),
                          Text("Publication year: ${book.yearPublished?.toString() ?? "?"}"),
                          Text("Description: ${book.description ?? "?"}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _updateBook(context, book.id!),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteBook(book.id!),
                          ),
                          IconButton(
                            icon: const Icon(Icons.read_more, color: Colors.amber),
                            onPressed: () => _reserveBook(book.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
