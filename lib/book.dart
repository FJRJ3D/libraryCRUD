
import 'dart:ffi';

class Book {
  int? _id;
  String? _name;
  String? _author;
  String? _description;
  int? _yearPublished;

  Book(this._id, this._name, this._author, this._description, this._yearPublished);

  int? get yearPublished => _yearPublished;

  set yearPublished(int? value) {
    _yearPublished = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
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