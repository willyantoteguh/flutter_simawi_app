import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_simawi_app/data/model/patient.dart';
import 'package:flutter_simawi_app/data/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  final String databaseName = "SIMRS_Test.db";
  final int databaseVersion = 4;

  final String tableName = 'user';
  final String id = 'id';
  final String name = 'name';
  final String email = 'email';
  final String password = 'password';
  final String role = 'role';
  // final String total = 'total';
  final String createdAt = 'createdAt';
  final String updatedAt = 'updatedAt';

  final String table2Name = "patient";
  final String idPatient = 'idPatient';
  final String recordNumber = 'recordNumber';
  final String namePatient = 'namePatient';
  final String birth = 'birth';
  final String age = 'age'; // Field tidak ada di ERD
  final String nik = "nik";
  final String gender = 'gender'; // Improve
  final String phone = 'phone';
  final String address = 'address';
  final String bloodType = 'bloodType';
  final String weight = 'weight';
  final String height = 'height';
  final String createdAtPatient = 'createdAtPatient';
  final String updatedAtPatient = 'updatedAtPatient';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databaseDirectory = await getDatabasesPath();
    String path = join(databaseDirectory, databaseName);
    debugPrint('database init');
    return openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $name TEXT NULL, $email TEXT NULL, $password TEXT NULL, $role INTEGER, $createdAt TEXT NULL, $updatedAt TEXT NULL)');
    await db
        .execute('''CREATE TABLE $table2Name ($idPatient INTEGER PRIMARY KEY, 
        $recordNumber INTEGER, 
        $namePatient TEXT NULL, 
        $birth TEXT NULL, 
        $age VARCHAR NOT NULL, 
        $nik TEXT NULL, 
        $gender INTEGER, 
        $phone TEXT NULL, 
        $address TEXT NULL, 
        $bloodType INTEGER,
        $weight VARCHAR NULL,
        $height VARCHAR NULL, 
        $createdAtPatient TEXT NULL,  
        $updatedAtPatient TEXT NULL)''');
  }

  Future<List<User>> getAll() async {
    final data = await _database!.query(tableName);
    List<User> result = data.map((e) => User.fromMap(e)).toList();
    return result;
  }

  Future<List<Map<String, Object?>>> getAllPatient() async {
    final data = await _database!.query(table2Name);
    debugPrint("getAllPatient data nih: ${data.first}");
    // List<Patient> result = data.map((e) => Patient.fromMap(e)).toList();
    return data;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(tableName, row);
    return query;
  }

  Future<int> insertPatient(Map<String, dynamic> row) async {
    final query = await _database!.insert(table2Name, row);
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

  Future<List<Map<String, dynamic>>> getAllDoctor() async {
    final query =
        await _database!.rawQuery("SELECT name FROM $tableName WHERE role = 2");
    return query;
  }

  Future<int> hapus(idUser) async {
    final query = await _database!
        .delete(tableName, where: '$id = ?', whereArgs: [idUser]);

    return query;
  }

  Future<int> hapusPatient(idPatient) async {
    final query = await _database!
        .delete(table2Name, where: '$idPatient = ?', whereArgs: [idPatient]);

    return query;
  }

  Future<int> update(int idUser, Map<String, dynamic> row) async {
    final query = await _database!
        .update(tableName, row, where: '$id = ?', whereArgs: [idUser]);
    return query;
  }

  Future<int> updatePatient(int idUser, Map<String, dynamic> row) async {
    final query = await _database!
        .update(table2Name, row, where: '$idPatient = ?', whereArgs: [idUser]);
    return query;
  }
}
