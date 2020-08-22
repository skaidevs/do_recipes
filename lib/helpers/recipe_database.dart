import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'recipe_database.g.dart';

class DownloadRecipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
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

@UseMoor(tables: [DownloadRecipes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  Future<List<DownloadRecipe>> get allDownloadRecipes =>
      select(downloadRecipes).get();

  DownloadRecipe findAlbumById({String code}) {
    return  .firstWhere((id) => id.id == code);
  }

  Stream<List<DownloadRecipe>> get watchDownloadRecipes =>
      select(downloadRecipes).watch();

  Future insertDownloadRecipe(DownloadRecipe downloadRecipe) =>
      into(downloadRecipes).insert(downloadRecipe);

  Future updateDownloadRecipe(DownloadRecipe downloadRecipe) =>
      update(downloadRecipes).replace(downloadRecipe);
  Future deleteDownloadRecipe(DownloadRecipe downloadRecipe) =>
      delete(downloadRecipes).delete(downloadRecipe);
}
