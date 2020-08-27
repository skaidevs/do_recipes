import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'recipe_database.g.dart';

class DownloadRecipes extends Table {
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
}
