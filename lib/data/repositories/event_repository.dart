import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisgeri24/data/error/multiple_element_error.dart';
import 'package:kisgeri24/data/models/event.dart';
import 'package:kisgeri24/logging.dart';

import 'crud_repository.dart';

class EventRepository extends CrudRepository<Event> {
  final FirebaseFirestore firestore;

  EventRepository(this.firestore);

  @override
  Future<List<Event>> fetchAll() {
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> fetchAllByYear(String year) async {
    logger.i(
        "Collecting events from database that are designated for the following year (ID): $year");
    QuerySnapshot<Map<String, dynamic>> eventSnapshot = await firestore
        .collection('events')
        .where('yearId', isEqualTo: year)
        .get();

    List<Event> events = eventSnapshot.docs.map((eventDoc) {
      return Event.createWithExtraIdField(eventDoc.data(), eventDoc.id);
    }).toList();

    logger.i('The following events got collected from the database: $events');
    return events;
  }

  @override
  Future<void> update(Event event) async {
    logger.d("Event update operation requested for event: $event");
    CollectionReference eventsCollection = firestore.collection('events');
    Map<String, dynamic> eventMap = event.toJson();
    await eventsCollection.add(eventMap);
    logger.i("Event successfully updated in database!");
  }

  @override
  Future<void> save(Event entity) async {
    logger.d("Event save operation requested for event: $entity");
    CollectionReference eventsCollection = firestore.collection('events');
    Map<String, dynamic> eventMap = entity.toJson();
    await eventsCollection.add(eventMap);
    logger.i("Event successfully created in database!");
  }

  @override
  Future<void> delete(String id) async {
    logger.i("About to try to delete event with ID: $id");
    await firestore.collection('events').doc(id).delete();
    logger.d('Event with id [$id] deleted successfully');
  }

  @override
  Future<Event?> getById(String id) async {
    QuerySnapshot<Map<String, dynamic>> yearsSnapshot =
        await firestore.collection('years').where('id', isEqualTo: id).get();
    if (yearsSnapshot.size > 0) {
      List<Event> yearList = yearsSnapshot.docs.map((yearDoc) {
        Map<String, dynamic> data = yearDoc.data();
        data.putIfAbsent('id', () => yearDoc.id);
        return Event.fromJson(data);
      }).toList();
      if (yearList.length > 1) {
        throw MultipleElementError("Multiple Event found with id: $id");
      }
      return yearList.first;
    }
    return null;
  }
}
