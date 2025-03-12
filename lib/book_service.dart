
class Book_service {
  String deleteBookById(int id) {
    int initialLength = bookList.length;
    bookList.removeWhere((book) => book.id == id);

    if(bookList.length < initialLength){
      return "Book deleted.";
    }else{
      return "Book not deleted.";
    }
  }
}