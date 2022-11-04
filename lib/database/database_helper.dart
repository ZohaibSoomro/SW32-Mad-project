import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sw32_mad_project/model/task.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();
  static const _tasksTable = 'Tasks';
  static Database? _database;
  TasksDatabase._init();
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('Tasks.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    final db = await instance.database;
    await db!.execute('''
    CREATE TABLE $_tasksTable(id INTEGER PRIMARY KEY,title TEXT NOT NULL)
    ''');
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final maps = await db!.query(_tasksTable, orderBy: 'id ASC');
    final tasks = maps.map((json) => Task.fromJSON(json)).toList();
    return tasks.isNotEmpty ? tasks : [];
  }

  Future<int> addTask(Task task) async {
    final db = await instance.database;
    return await db!.insert(
      _tasksTable,
      task.toJSON(),
    );
  }

  Future<int> removeTask(int taskId) async {
    final db = await instance.database;
    return await db!.delete(
      _tasksTable,
      where: 'id=?',
      whereArgs: [taskId],
    );
  }

  Future<void> deleteDB() async {
    final db = await instance.database;
    await deleteDatabase(db!.path);
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return await db!.update(
      _tasksTable,
      task.toJSON(),
      where: 'id=?',
      whereArgs: [task.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
