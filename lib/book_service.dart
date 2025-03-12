import 'package:library_crud/book.dart';

class Book_service {
  List<Book> bookList = [];

  Book createBookAuto(String? name, String? author, String? description, int? yearPublished) {
    int newId = bookList.length + 1;
    Book book = Book(newId, name, author, description, yearPublished);
    bookList.add(book);
    return book;
  }
}