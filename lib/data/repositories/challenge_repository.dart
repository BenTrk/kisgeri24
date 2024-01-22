import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisgeri24/data/models/challenge.dart';
import 'package:kisgeri24/data/repositories/crud_repository.dart';
import 'package:kisgeri24/logging.dart';

class ChallengeRepository extends CrudRepository<Challenge> {
  final FirebaseFirestore firestore;

  ChallengeRepository(this.firestore);

  @override
  Future<void> delete(String id) {
    throw UnsupportedError("Deleting challenge(s) is not supported by client.");
  }

  @override
  Future<List<Challenge>> fetchAll() {
    throw UnsupportedError(
        "Fetching all the challenges is not supported by client. Please use the year filter.");
  }

  @override
  Future<List<Challenge>> fetchAllByYear(String year) async {
    logger.i(
        "Collecting challenges from database that are designated for the following year (ID): $year");
    QuerySnapshot<Map<String, dynamic>> eventSnapshot = await firestore
        .collection('challenge')
        .where('yearId', isEqualTo: year)
        .get();

    List<Challenge> events = eventSnapshot.docs.map((eventDoc) {
      return Challenge.createWithExtraIdField(eventDoc.data(), eventDoc.id);
    }).toList();

    logger.i(
        'The following challenges got collected from the database: ${events.map((challenge) => challenge.toString())}');
    return events;
  }

  @override
  Future<Challenge?> getById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> save(Challenge entity) {
    // TODO: implement save
    throw UnsupportedError("Saving challenge(s) is not supported by client.");
  }

  @override
  Future<void> update(Challenge entity) {
    throw UnsupportedError("Updating challenge(s) is not supported by client.");
  }
}
