import 'package:library_crud/book.dart';

class Book_service {
  List<Book> bookList = [];

  Book createBookAuto(String? name, String? author, String? description, int? yearPublished) {
    int newId = bookList.length + 1;
    Book book = Book(newId, name, author, description, yearPublished);
    bookList.add(book);
    return book;
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