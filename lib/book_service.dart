import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_crud/book.dart';

class Book_service {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _booksCollection = FirebaseFirestore.instance.collection('books');

  Future<Book> createBookAuto(String? name, String? author, String? description, int? yearPublished) async {
    DocumentReference docRef = await _booksCollection.add({
      'name': name,
      'author': author,
      'description': description,
      'yearPublished': yearPublished,
    });

    return Book(
      id: docRef.id,
      name: name,
      author: author,
      description: description,
      yearPublished: yearPublished,
    );
  }

  Future<Book?> getBookById(String id) async {
    try {
      DocumentSnapshot doc = await _booksCollection.doc(id).get();
      if (doc.exists) {
        return Book.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener el libro: $e');
      return null;
    }
  }

  Future<void> updateBook(String id, Book updatedBook) async {
    try {
      await _booksCollection.doc(id).update(updatedBook.toMap());
      print('Libro actualizado correctamente');
    } catch (e) {
      print('Error al actualizar el libro: $e');
    }
  }

  Future<String> deleteBookById(String id) async {
    try {
      await _booksCollection.doc(id).delete();
      return "Libro eliminado.";
    } catch (e) {
      return "Error al eliminar el libro: $e";
    }
  }

  Future<List<Book>> getAllBooks() async {
    try {
      QuerySnapshot querySnapshot = await _booksCollection.get();
      return querySnapshot.docs
          .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>, id: doc.id))
          .toList();
    } catch (e) {
      print('Error al obtener los libros: $e');
      return [];
    }
  }
}
