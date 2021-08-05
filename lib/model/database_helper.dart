import 'dart:io';
import 'package:flutter_task/model/category_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'category.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE category(
          id INTEGER PRIMARY KEY,
          name TEXT,
          picture TEXT 
      )
      ''');
  }

  Future<List<Category>> getCategory() async {
    Database db = await instance.database;
    var category = await db.query('category', orderBy: 'name');
    List<Category> categoryList = category.isNotEmpty
        ? category.map((c) => Category.fromMap(c)).toList()
        : [];
    return categoryList;
  }

  Future<int> add(Category category) async {
    Database db = await instance.database;
    return await db.insert('category', category.toMap());
  }
}
