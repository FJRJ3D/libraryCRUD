// book_input_list.dart
import 'package:flutter/material.dart';
import 'package:library_crud/book.dart';
import 'package:library_crud/book_service.dart';

class BookInputList extends StatefulWidget {
  final Book_service bookService;

  const BookInputList({Key? key, required this.bookService}) : super(key: key);

  @override
  _BookInputListState createState() => _BookInputListState();
}

class _BookInputListState extends State<BookInputList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  void _createBook() {
    final String name = _nameController.text;
    final String author = _authorController.text;
    final String description = _descriptionController.text;
    final int? yearPublished = int.tryParse(_yearController.text);

    if (name.isNotEmpty && author.isNotEmpty && description.isNotEmpty && yearPublished != null) {
      final newBook = widget.bookService.createBookAuto(name, author, description, yearPublished);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('book created: ${newBook.name}')),
      );
      _nameController.clear();
      _authorController.clear();
      _descriptionController.clear();
      _yearController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please, fill in good conditions')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Форма вводу книги
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Book name'),
                ),
                TextField(
                  controller: _authorController,
                  decoration: InputDecoration(labelText: 'Author'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Published year'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _createBook,
                  child: Text('Create book'),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.bookService.bookList.isEmpty
                ? Text("List is empty")
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.bookService.bookList.length,
              itemBuilder: (context, index) {
                final book = widget.bookService.bookList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(book.name ?? "Book name"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Author: ${book.author ?? "?"}"),
                        Text("Year: ${book.yearPublished?.toString() ?? "?"}"),
                        Text("Description: ${book.description ?? ""}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}