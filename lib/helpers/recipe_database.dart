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
      'CREATE TABLE do_recipe_ing(_id TEXT PRIMARY KEY, title TEXT, ingredients BLOB)',
    );
  }

  static Future<void> insertRecipe({Data data}) async {
    final db = await DBHelper.database();
    /*Data recipe = Data(
      id: data.id,
      image: data.image,
      imageUrl: data.imageUrl,
      ingredients: data.ingredients,
      method: data.method,
      preparation: data.preparation,
      publishedAt: data.publishedAt,
      title: data.title,
      calories: data.calories,
      category: data.category,
      difficulty: data.difficulty,
      duration: data.duration,
      // isIngredientSaved: data.isIngredientSaved,
    );*/
    //print('Inserting ${data.toMapForDb().entries}');
    //print('Inserting ${recipe.isIngredientSaved}');
    db.insert(
      'do_recipe',
      data.toMapForDb(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  //Raw query to check if it is in the favourites
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

  static Future<void> insertIngredients({
    Data data,
  }) async {
    final db = await DBHelper.database();
    //print('Inserting ${recipe.isIngredientSaved}');
    Data ingredients = Data(
      id: data.id,
      title: data.title,
      ingredients: data.ingredients,
    );

    db.insert(
      'do_recipe_ing',
      ingredients.toMapForDbIng(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<Data> isInDataBase(String id) async {
    final db = await DBHelper.database();
    List<Map> results = await db.query("do_recipe",
        //columns: ["id", "first_name", "last_name", "email"],
        where: '_id = ?',
        whereArgs: [id]);

    if (results.length > 0) {
      return Data.fromDb(results.first);
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>> fetchRecipeData() async {
    final db = await DBHelper.database();
    return db.query('do_recipe');
  }

  static Future<List<Map<String, dynamic>>> fetchIngredientData() async {
    final db = await DBHelper.database();
    return db.query('do_recipe_ing');
  }

  static Future<int> deleteRecipe(String id) async {
    final db = await DBHelper.database();
    print("delete called for table");
    return db.delete('do_recipe', where: '_id = ?', whereArgs: [id]);
  }

  static Future<int> deleteIngredient(String id) async {
    final db = await DBHelper.database();
    print("delete called for do_recipe_ing table");
    return db.delete('do_recipe_ing', where: '_id = ?', whereArgs: [id]);
  }
}
/*Future<NewsItem> fetchNewsItem(int id) async {
  final maps = await db.query(
    'NewsItems',
    columns: null,
    where: 'id = ?',
    whereArgs: [id],
  );
  if (maps.length > 0) {
    return NewsItem.fromDb(maps.first);
  }
  return null;
}*/

/*class DownloadRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get code => text()();
  TextColumn get imageUri => text()();
  TextColumn get calories => text()();
  TextColumn get duration => text()();
  TextColumn get difficulty => text()();
  TextColumn get method => text()();
  TextColumn get preparation => text()();
  TextColumn get ingredients => text()();

  DateTimeColumn get dueData => dateTime().nullable()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.wildStream here, into the documents folder
    // for the app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(
      p.join(dbFolder.path, 'db.recipe'),
    );
    return VmDatabase(file);
  });
}

@UseMoor(tables: [DownloadRecipes], daos: [RecipeDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [DownloadRecipes])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  final AppDatabase db;

  RecipeDao(this.db) : super(db);

  Future<List<DownloadRecipe>> get allDownloadRecipes =>
      select(downloadRecipes).get();

  Stream<List<DownloadRecipe>> watchDownloadRecipes() {
    return (select(db.downloadRecipes)
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.id,
                  mode: OrderingMode.desc,
                )
          ]))
        .watch();
  }

  Future insertDownloadRecipe(
    Insertable<DownloadRecipe> downloadRecipe,
  ) =>
      into(db.downloadRecipes).insert(downloadRecipe);

  Future insertIngredient(
    Insertable<DownloadRecipe> downloadRecipe,
  ) =>
      into(db.downloadRecipes).insert(downloadRecipe);

  Future deleteDownloadRecipe(String code) => (delete(db.downloadRecipes)
        ..where(
          (recipe) => recipe.code.equals(code),
        ))
      .go();

  Future deleteAllDownloadRecipe() {
    return delete(db.downloadRecipes).go();
  }

  Stream<bool> isDownloaded(String code) {
    return (select(db.downloadRecipes)
          ..where(
            (download) => download.code.equals(code),
          ))
        .watch()
        .map((downloadList) => downloadList.length >= 1);
  }

  Future updateDownloadRecipe(Insertable<DownloadRecipe> downloadRecipe) =>
      update(downloadRecipes).replace(downloadRecipe);
}*/
