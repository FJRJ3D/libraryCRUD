import 'package:flutter_test/flutter_test.dart';
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

    test('deleteBookById should delete a book if it exists', () {
      bookService.createBookAuto('Book1', 'Author1', 'Description1', 2001);
      bookService.createBookAuto('Book2', 'Author2', 'Description2', 2002);

      final result = bookService.deleteBookById(1);
      expect(result, equals("Book deleted."));
      expect(bookService.bookList.length, equals(1));
      expect(bookService.bookList.first.id, equals(2));
    });

    test('deleteBookById should return "Book not deleted." if the book is not found', () {
      bookService.createBookAuto('Book1', 'Author1', 'Description1', 2001);

      final result = bookService.deleteBookById(99);
      expect(result, equals("Book not deleted."));
      expect(bookService.bookList.length, equals(1));
    });
  });
}
