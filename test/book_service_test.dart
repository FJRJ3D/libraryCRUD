import 'package:flutter_test/flutter_test.dart';
import 'package:library_crud/book.dart';
import 'package:library_crud/book_service.dart';

void main() {
  group('BookService tests', () {
    late Book_service bookService;

    setUp(() {
      bookService = Book_service();
    });

    test('createBookAuto should create a book with auto-incremented id', () {
      final book1 = bookService.createBookAuto('Book1', 'Author1', 'Description1', 2001);
      expect(book1.id, equals(1));
      expect(bookService.bookList.length, equals(1));

      final book2 = bookService.createBookAuto('Book2', 'Author2', 'Description2', 2002);
      expect(book2.id, equals(2));
      expect(bookService.bookList.length, equals(2));
    });

    test('getBookById should throw an exception if the book is not found', () {
      expect(() => bookService.getBookById(999), throwsException);
    });

    test('getBookById should return an object', () {
      bookService.createBookAuto('Book1', 'Author1', 'Description1', 2001);
      Book? book = bookService.getBookById(1);
      expect(book?.id, equals(1));
      expect(book?.name, equals("Book1"));
      expect(book?.author, equals("Author1"));
      expect(book?.description, equals("Description1"));
      expect(book?.yearPublished, equals(2001));
    });
  });
}
