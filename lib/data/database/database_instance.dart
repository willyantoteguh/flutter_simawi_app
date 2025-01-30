import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_simawi_app/data/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  final String databaseName = "management.db";
  final int databaseVersion = 1;

  final String tableName = 'user';
  final String id = 'id';
  final String name = 'name';
  final String email = 'email';
  final String password = 'password';
  final String role = 'role';
  // final String total = 'total';
  final String createdAt = 'createdAt';
  final String updatedAt = 'updatedAt';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, databaseName);
    debugPrint('database init');
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $name TEXT NULL, $email TEXT NULL, $password TEXT NULL, $role INTEGER, $createdAt TEXT NULL, $updatedAt TEXT NULL)');
  }

  Future<List<User>> getAll() async {
    final data = await _database!.query(tableName);
    List<User> result = data.map((e) => User.fromMap(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(tableName, row);
    return query;
  }

  Future<int> totalAdmin() async {
    final query =
        await _database!.rawQuery("SELECT role FROM $tableName WHERE role = 1");
    return int.parse(query.length.toString());
  }

  Future<int> totalDoctor() async {
    final query =
        await _database!.rawQuery("SELECT role FROM $tableName WHERE role = 2");
    return int.parse(query.length.toString());
  }

  Future<int> hapus(idUser) async {
    final query = await _database!
        .delete(tableName, where: '$id = ?', whereArgs: [idUser]);

    return query;
  }

  Future<int> update(int idUser, Map<String, dynamic> row) async {
    final query = await _database!
        .update(tableName, row, where: '$id = ?', whereArgs: [idUser]);
    return query;
  }
}
