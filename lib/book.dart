
class Book {
  String? _name;
  String? _author;
  String? _description;
  int? _yearPublished;

  Book(this._name, this._author, this._description, this._yearPublished);

  int? get yearPublished => _yearPublished;

  set yearPublished(int? value) {
    _yearPublished = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  String? get author => _author;

  set author(String? value) {
    _author = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }
}