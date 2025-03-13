import 'package:flutter/material.dart';
import 'package:library_crud/book_service.dart';
import 'package:library_crud/book.dart';
import 'package:library_crud/inputs.dart';

class BookListScreen extends StatefulWidget {
  final Book_service bookService;

  const BookListScreen({Key? key, required this.bookService}) : super(key: key);

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  void _updateBook(BuildContext context, int bookId) {
    final bookToUpdate = widget.bookService.getBookById(bookId);
    if (bookToUpdate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Book not found')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookInputList(
          bookService: widget.bookService,
          existingBook: bookToUpdate,
        ),
      ),
    ).then((_) {
      setState(() {}); // Оновлюємо список після повернення
    });
  }

  void _deleteBook(int bookId) {
    setState(() {
      String result = widget.bookService.deleteBookById(bookId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books list"),
      ),
      body: widget.bookService.bookList.isEmpty
          ? const Center(child: Text("The list of books is empty"))
          : ListView.builder(
        itemCount: widget.bookService.bookList.length,
        itemBuilder: (context, index) {
          final book = widget.bookService.bookList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    icon: Icon(Icons.edit),
                    onPressed: () => _updateBook(context, book.id!),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteBook(book.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
