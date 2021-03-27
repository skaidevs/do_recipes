import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'ingredient_database.g.dart';

class DownloadRecipeIngredient extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get code => text()();

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
      p.join(dbFolder.path, 'db.ingredient'),
    );
    return VmDatabase(file);
  });
}

@UseMoor(tables: [DownloadRecipeIngredient], daos: [RecipeIngredientDao])
class AppDatabaseIngredient extends _$AppDatabaseIngredient {
  AppDatabaseIngredient() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [DownloadRecipeIngredient])
class RecipeIngredientDao extends DatabaseAccessor<AppDatabaseIngredient>
    with _$RecipeIngredientDaoMixin {
  final AppDatabaseIngredient db;

  RecipeIngredientDao(this.db) : super(db);

  Future<List<DownloadRecipeIngredientData>> get allDownloadRecipes =>
      select(downloadRecipeIngredient).get();

  Stream<List<DownloadRecipeIngredientData>> watchDownloadRecipes() {
    return (select(db.downloadRecipeIngredient)
          ..orderBy([
            (table) => OrderingTerm(
                  expression: table.id,
                  mode: OrderingMode.desc,
                )
          ]))
        .watch();
  }

  Future insertIngredient(
    Insertable<DownloadRecipeIngredientData> downloadRecipe,
  ) =>
      into(db.downloadRecipeIngredient).insert(downloadRecipe);

  Future deleteDownloadRecipe(String code) =>
      (delete(db.downloadRecipeIngredient)
            ..where(
              (recipe) => recipe.code.equals(code),
            ))
          .go();

  Future deleteAllDownloadIng() {
    return delete(db.downloadRecipeIngredient).go();
  }

  Stream<bool> isDownloaded(String code) {
    return (select(db.downloadRecipeIngredient)
          ..where(
            (download) => download.code.equals(code),
          ))
        .watch()
        .map((downloadList) => downloadList.length >= 1);
  }
}
