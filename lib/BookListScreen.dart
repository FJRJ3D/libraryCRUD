import 'package:flutter/material.dart';
import 'package:library_crud/book_service.dart';

class BookListScreen extends StatefulWidget {
  final Book_service bookService;

  const BookListScreen({Key? key, required this.bookService}) : super(key: key);

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books list"),
      ),
      body: widget.bookService.bookList.isEmpty
          ? const Center(child: Text("The list of book is empty"))
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
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        String result = widget.bookService.deleteBookById(book.id!);
                        print(result);
                      });
                    },
                    child: const Text("Delete"),
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
