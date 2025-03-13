class Book {
  String? id;
  String? name;
  String? author;
  String? description;
  int? yearPublished;

  Book({this.id, this.name, this.author, this.description, this.yearPublished});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'author': author,
      'description': description,
      'yearPublished': yearPublished,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map, {String? id}) {
    return Book(
      id: id,
      name: map['name'],
      author: map['author'],
      description: map['description'],
      yearPublished: map['yearPublished'],
    );
  }
}
