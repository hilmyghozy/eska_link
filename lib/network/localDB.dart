import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  LocalDB();

  Future<Database?> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    var cek = await databaseExists('user.db');
    final Future<Database> database;
    if (!cek) {
      database = openDatabase(
        join(await getDatabasesPath(), ' user.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY, nik TEXT, nama TEXT,umur INTEGER, kota TEXT)',
          );
        },
        version: 1,
      );
      log('table created');
      return database;
    }
    log('table not created');
    return null;
  }

  Future<void> insertUser(User user) async {
    final db = await main();
    await db!.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> users() async {
    final db = await main();

    final List<Map<String, dynamic>> maps = await db!.query('users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        nik: maps[i]['nik'],
        nama: maps[i]['nama'],
        umur: maps[i]['umur'],
        kota: maps[i]['kota'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    final db = await main();
    await db!.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await main();
    await db!.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class User {
  final int id;
  final String nik;
  final String nama;
  final int umur;
  final String kota;

  const User({
    required this.id,
    required this.nik,
    required this.nama,
    required this.umur,
    required this.kota,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'nama': nama,
      'umur': umur,
      'kota': kota,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, nik: $nik, nama: $nama, umur: $umur, kota: $kota}';
  }
}
