import 'package:firebase_database/firebase_database.dart';
import 'package:kisgeri24/data/models/sector.dart';
import 'package:kisgeri24/data/repositories/crud_repository.dart';
import 'package:kisgeri24/logging.dart';
import 'package:kisgeri24/utils/log_utils.dart';

class SectorRepository extends CrudRepository<Sector> {
  final FirebaseDatabase database;

  SectorRepository(this.database);

  @override
  Future<void> delete(String id) {
    throw UnsupportedError('Deleting routes is not supported by clients.');
  }

  @override
  Future<List<Sector>> fetchAll() async {
    int start = LogUtils.logStart(prefixMsg: 'Fetching Sectors from DB');
    List<Sector> placesList = [];
    try {
      logger.d('Trying to fetch data from Routes table');
      DatabaseEvent event = await database.ref('Routes').once();
      DataSnapshot snapshot = event.snapshot;
      final Map data = snapshot.value as Map<dynamic, dynamic>;
      logger.d('Fetching data from Routes table is done');
      data.forEach((key, value) {
        final Sector place = Sector.fromSnapshot(key as String, value);
        placesList.add(place);
      });
    } catch (error) {
      logger.w('Error happened during Sector fetch: ${error.toString()}');
    }
    LogUtils.logEnd(start, prefixMsg: 'Fetching Sectors from DB');
    return placesList;
  }

  @override
  Future<List<Sector>> fetchAllByYear(String year) {
    throw UnsupportedError(
        'Routes are year-independent thus this functionality is not supported for this entity');
  }

  @override
  Future<Sector?> getById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> save(Sector entity) {
    throw UnsupportedError('Saving routes is not supported by clients.');
  }

  @override
  Future<void> update(Sector entity) {
    throw UnsupportedError('Updating routes is not supported by clients.');
  }
}
