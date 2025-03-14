import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_crud/auth_service.dart';
import 'package:library_crud/book.dart';

class Book_service {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _booksCollection = FirebaseFirestore.instance.collection('books');
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // Future<String> reserveBook(String id) async {
  //   //String? userUID = _auth.currentUser?.uid; Tenemos que testearlo
  //   Map<String, String?> user = await AuthService().getUserFromLocalStorage();
  //   Book? book = await getBookById(id);
  //
  //   if (book != null) {
  //     book.userUID = user['uid'];
  //
  //     await updateBook(id, book);
  //
  //     return "Reserva realizada con éxito.";
  //   } else {
  //     return "El libro no existe.";
  //   }
  // }

  Future<String> reserveBook(String id) async {
    String? userUID = _auth.currentUser?.uid;

    if (userUID == null) {
      return "El usuario no está autenticado.";
    }

    Book? book = await getBookById(id);

    if (book != null) {
      if(book.userUID == null){
        book.userUID = userUID;
      }else{
        book.userUID = null;
      }
      await updateBook(id, book);

      return "Reserva realizada con éxito.";
    } else {
      return "El libro no existe.";
    }
  }

  Future<List<Book>> getBooksByUserUID() async {
    String? userUID = _auth.currentUser?.uid;

    if (userUID == null) {
      return [];
    }

    try {
      QuerySnapshot querySnapshot = await _booksCollection.where('userUID', isEqualTo: userUID).get();

      List<Book> books = querySnapshot.docs
          .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>, id: doc.id))
          .toList();

      return books;
    } catch (e) {
      print('Error al obtener los libros del usuario: $e');
      return [];
    }
  }

  Future<String> returnBook(String id) async {
    String? userUID = _auth.currentUser?.uid;

    if (userUID == null) {
      return "El usuario no está autenticado.";
    }

    Book? book = await getBookById(id);

    if (book != null) {
      book.userUID = null;
      await updateBook(id, book);

      return "Reserva realizada con éxito.";
    } else {
      return "El libro no existe.";
    }
  }
}
