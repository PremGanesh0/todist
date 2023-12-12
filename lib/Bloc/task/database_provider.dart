import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todist/model/task_model.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasklistdatabase.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        date INTEGER,
        priority TEXT,
        label TEXT,
        remember INTEGER
      )
    ''');
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date']),
        priority: maps[i]['priority'],
        label: maps[i]['label'],
        remember: maps[i]['remember'] == 1,
      );
    });
  }
}
