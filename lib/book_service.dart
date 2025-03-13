import 'package:library_crud/book.dart';

class Book_service {
  List<Book> bookList = [];

  Book createBookAuto(String? name, String? author, String? description, int? yearPublished) {
    int newId = bookList.isEmpty ? 1 : bookList.last.id! + 1;
    Book book = Book(newId, name, author, description, yearPublished);
    bookList.add(book);
    return book;
  }

  Book? getBookById(int id) {
    try {
      return bookList.firstWhere(
            (book) => book.id == id,
        orElse: () => throw Exception("Book not found"),
      );
    } catch (e) {
      return null;
    }
  }

  void updateBook(int id, Book updatedBook) {
    int index = bookList.indexWhere((book) => book.id == id);
    if (index != -1) {
      bookList[index] = updatedBook;
    }
  }

  String deleteBookById(int id) {
    int initialLength = bookList.length;
    bookList.removeWhere((book) => book.id == id);
    return bookList.length < initialLength ? "Book deleted." : "Book not deleted.";
  }
}
