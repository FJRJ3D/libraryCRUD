import 'book.dart';
class Book_service {
  final List<Book> _books = [];

  List<Book> getAllBooks() {
    return _books;
  }

  Book? getBookById(int id) {
    return _books.firstWhere(
          (book) => book.id == id,
      orElse: () => throw Exception("Book with id $id not found"),
    );
  }

  void updateBook(int id, Book updatedBook) {
    int index = _books.indexWhere((book) => book.id == id);
    _books[index] = updatedBook;
  }
}