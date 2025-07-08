import 'package:albani/data/models/categories_model.dart';

class AudioCategories {
  static const books = CategoryModel(id: 1, name: 'Books');
  static const tafsir = CategoryModel(id: 2, name: 'Tafsir');
  static const lecture = CategoryModel(id: 3, name: 'Lectures');
  static const sermon = CategoryModel(id: 4, name: 'Sermon');

  static const all = [books, tafsir, lecture, sermon];

  static CategoryModel getById(int id) {
    return all.firstWhere((category) => category.id == id, orElse: () => books);
  }
}
