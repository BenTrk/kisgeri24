import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisgeri24/data/models/sector.dart';
import 'package:kisgeri24/data/repositories/crud_repository.dart';
import 'package:kisgeri24/logging.dart';
import 'package:kisgeri24/utils/log_utils.dart';

class SectorRepository extends CrudRepository<Sector> {
  final FirebaseFirestore firestore;

  SectorRepository(this.firestore);

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
      var routes = await firestore.collection('routes').get();
      logger.d('Fetching data from Routes table is done');
      for (var element in routes.docs) {
        final Sector place = Sector.fromSnapshot(element.id, element.data());
        placesList.add(place);
      }
    } catch (error) {
      logger.w('Error happened during Sector fetch: ${error.toString()}');
    }
    LogUtils.logEnd(start, prefixMsg: 'Fetching Sectors from DB');
    logger.d('Fetched Sectors from DB: $placesList');
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
