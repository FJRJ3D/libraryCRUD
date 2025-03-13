import 'package:flutter/material.dart';
import 'package:library_crud/book.dart';
import 'package:library_crud/book_service.dart';

class BookInputList extends StatefulWidget {
  final Book_service bookService;
  final Book? existingBook;

  const BookInputList({Key? key, required this.bookService, this.existingBook}) : super(key: key);

  @override
  _BookInputListState createState() => _BookInputListState();
}

class _BookInputListState extends State<BookInputList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingBook != null) {
      _nameController.text = widget.existingBook!.name ?? '';
      _authorController.text = widget.existingBook!.author ?? '';
      _descriptionController.text = widget.existingBook!.description ?? '';
      _yearController.text = widget.existingBook!.yearPublished?.toString() ?? '';
    }
  }

  void _createOrUpdateBook() {
    final String name = _nameController.text.trim();
    final String author = _authorController.text.trim();
    final String description = _descriptionController.text.trim();
    final int? yearPublished = int.tryParse(_yearController.text.trim());

    if (name.isEmpty || author.isEmpty || description.isEmpty || yearPublished == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please, fill in all fields')),
      );
      return;
    }

    if (widget.existingBook != null) {
      final updatedBook = Book(
        widget.existingBook!.id,
        name,
        author,
        description,
        yearPublished,
      );

      widget.bookService.updateBook(widget.existingBook!.id!, updatedBook);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book updated: ${updatedBook.name}')),
      );
    } else {
      final newBook = widget.bookService.createBookAuto(name, author, description, yearPublished);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book created: ${newBook.name}')),
      );

      _nameController.clear();
      _authorController.clear();
      _descriptionController.clear();
      _yearController.clear();
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingBook != null ? 'Update Book' : 'Add Book'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                onPressed: _createOrUpdateBook,
                child: Text(widget.existingBook != null ? 'Update Book' : 'Create Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
