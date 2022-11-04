import 'dart:core';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sw32_mad_project/components/task/model/task.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();
  static Database? _database;
  TasksDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('Tasks.db');

    return _database;
  }

  Future<Database?> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<int> getLastTaskId() async {
    List<Task> tasks = await readAllTasks();
    return _getMaxId(tasks);
  }

  int _getMaxId(List<Task> tasks) {
    int maxID = 0;
    for (Task task in tasks) {
      if (task.id > maxID) maxID = task.id;
    }
    return maxID;
  }

  Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'Tasks.db');
    await deleteDatabase(path);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const integerType = 'INTEGER NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT';
    await db.execute('''
      CREATE TABLE $tableTasks(
        ${TaskFields.id} $idType,
        ${TaskFields.taskTitle} $textType,
        ${TaskFields.taskDescription} $textType,
        ${TaskFields.isFavourite} $boolType,
        ${TaskFields.taskStartTime} $textType,
        ${TaskFields.taskDate} $textType,
        ${TaskFields.taskDuration} $integerType
      )
    ''');
  }

  Future<Task> insertTask(Task task) async {
    final db = await instance.database;
    final json = task.toJSON();
    await db!.insert(tableTasks, json);
    return task;
    // final columns =
    //     '${TaskFields.id},${TaskFields.taskTitle},${TaskFields.taskDescription},${TaskFields.isFavourite},${TaskFields.taskDate},${TaskFields.taskStartTime},${TaskFields.taskDuration}';
    // final values =
    //     '${json[TaskFields.id]},${json[TaskFields.taskTitle]},${json[TaskFields.taskDescription]},${json[TaskFields.isFavourite]},${json[TaskFields.taskDate]},${json[TaskFields.taskStartTime]},${json[TaskFields.taskDuration]}';
    // final id = await db!
    //     .rawInsert('INSERT INTO $tableTasks ($columns) VALUES ($values)');

    //returns unique key that is generted automatically
    // final id = await db!.insert(tableTasks, task.toJSON());
  }

  Future<int> insertAllTasks(List<Task> tasks) async {
    final db = await instance.database;
    for (Task task in tasks) {
      final json = task.toJSON();
      await db!.insert(tableTasks, json);
    }
    return tasks.length;
  }

  Future<Task?> getTask(int id) async {
    final db = await instance.database;

    //returns list of json maps and each map represents a specfic item(task)
    final maps = await db!.query(
      tableTasks,
      columns: TaskFields.values,
      where: '${TaskFields.id}=?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Task.fromJSON(maps.first);
    }
    return null;
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return db!.update(tableTasks, task.toJSON(),
        where: '${TaskFields.id} = ?', whereArgs: [task.id]);

    //db.rawUpdate(String sqlQuery); is used when we want to add something manually using sql query
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db!
        .delete(tableTasks, where: '${TaskFields.id}= ?', whereArgs: [id]);
    //db.rawDelete(String sqlQuery); is used when we want to add something manually using sql query
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;
    const orderBy =
        '${TaskFields.taskDate} ASC,${TaskFields.taskStartTime} ASC,${TaskFields.taskTitle} ASC ';
    //this results in list of tasks(i.e maps i.e  in json format)
    final result = await db!.query(tableTasks, orderBy: orderBy);
    //db.rawQuery(String sqlQuery); is used when we want to add something manually using e.g
    //db.rawQuery('INSERT INTO $tableTasks(taskTitle,taskDuration) VALUES('A',120)');

    return result.map((json) => Task.fromJSON(json)).toList();
  }

  Future<List<Task>> readOnlyFvr8Tasks() async {
    final db = await instance.database;
    const orderBy =
        '${TaskFields.taskDate} ASC,${TaskFields.taskStartTime} ASC,${TaskFields.taskTitle} ASC ';
    final result = await db!.query(tableTasks, orderBy: orderBy);
    List<Task> tasks = result.map((json) => Task.fromJSON(json)).toList();
    for (int i = 0; i < tasks.length; i++) {
      if (!tasks[i].isFavourite) tasks.removeAt(i);
    }
    return tasks;
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
