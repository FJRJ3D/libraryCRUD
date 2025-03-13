import 'package:flutter/material.dart';
import 'package:library_crud/book_service.dart';
import 'package:library_crud/book.dart';
import 'package:library_crud/inputs.dart';

class BookListScreen extends StatelessWidget {
  final Book_service bookService;
  const BookListScreen({Key? key, required this.bookService}) : super(key: key);

  void _updateBook(BuildContext context, int bookId) {
    final bookToUpdate = bookService.getBookById(bookId);
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
          bookService: bookService,
          existingBook: bookToUpdate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books list"),
      ),
      body: bookService.bookList.isEmpty
          ? const Center(child: Text("The list of books is empty"))
          : ListView.builder(
        itemCount: bookService.bookList.length,
        itemBuilder: (context, index) {
          final book = bookService.bookList[index];
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
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _updateBook(context, book.id!),
              ),
            ),
          );
        },
      ),
    );
  }
}
