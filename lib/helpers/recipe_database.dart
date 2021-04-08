import 'package:dorecipes/models/recipe.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<sql.Database> database() async {
    final _dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(_dbPath, 'do_recipe.db'),
      onCreate: (db, version) => _createDb(db),
      version: 1,
    );
  }

  static void _createDb(sql.Database db) {
    db.execute(
      'CREATE TABLE do_recipe(_id TEXT PRIMARY KEY, title TEXT, image TEXT, imageUrl TEXT, publishedAt TEXT, category TEXT, calories TEXT, duration TEXT, difficulty TEXT, method TEXT, preparation TEXT, ingredients BLOB, isIngredientSaved INTEGER)',
    );

    db.execute(
      'CREATE TABLE do_recipe_ing(_id TEXT PRIMARY KEY, title TEXT, duration TEXT, ingredients BLOB)',
    );
  }

  static Future<void> insertRecipe({Data data}) async {
    final db = await DBHelper.database();
    db.insert(
      'do_recipe',
      data.toMapForDb(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  //Raw query to check if it's bookedMarked
  static Future<int> queryForFav(String checkId) async {
    final db = await DBHelper.database();
    int noOfRows = 0;
    try {
      noOfRows = Sqflite.firstIntValue(await db.rawQuery(
          'SELECT COUNT(*) FROM do_recipe WHERE _id = ?', ['$checkId']));
    } catch (e) {
      print(e);
    }
    return noOfRows;
  }

  static Future<List<Map<String, dynamic>>> fetchRecipeData() async {
    final db = await DBHelper.database();
    return db.query('do_recipe');
  }

  static Future<int> deleteRecipe(String id) async {
    final db = await DBHelper.database();
    print("delete called for table");
    return db.delete('do_recipe', where: '_id = ?', whereArgs: [id]);
  }

  //INGREDIENTS DB

  static Future<void> insertIngredients({
    Data data,
  }) async {
    final db = await DBHelper.database();
    //print('Inserting ${recipe.isIngredientSaved}');
    Data ingredients = Data(
      id: data.id,
      title: data.title,
      duration: data.duration,
      ingredients: data.ingredients,
    );

    db.insert(
      'do_recipe_ing',
      ingredients.toMapForDbIng(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetchIngredientData() async {
    final db = await DBHelper.database();
    return db.query('do_recipe_ing');
  }

  static Future<int> deleteIngredient(String id) async {
    final db = await DBHelper.database();
    print("delete called for do_recipe_ing table");
    return db.delete('do_recipe_ing', where: '_id = ?', whereArgs: [id]);
  }
}
