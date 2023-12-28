import 'package:kisgeri24/data/repositories/event_repository.dart';
import 'package:kisgeri24/logging.dart';
import 'package:kisgeri24/data/models/event.dart';

class EventService {
  final EventRepository repository;

  EventService(this.repository);

  Future<List<Event>> collectEventsForYearOrdered(String yearId) async {
    logger.i(
        "Collecting events that are designated for the following year (ID): $yearId");
    List<Event> events = await repository.fetchAllByYear(yearId);

    events.sort((a, b) => a.startTime.compareTo(b.startTime));

    logger.i('The following events got collected: $events');
    return events;
  }

  Future<void> saveOrUpdateEvent(Event event) async {
    logger.d("Event save/update operation requested for event: $event");
    try {
      if (event.id.isEmpty) {
        logger.i("About to attempt to save event: $event");
        repository.save(event);
        logger.i("Event successfully created in database!");
      } else {
        logger.d("Updating event: $event");
        repository.update(event);
        logger.d("Event successfully updated");
      }
    } catch (error) {
      String msg = "Event cannot be created/updated due to: $error";
      logger.w(msg);
    }
  }

  Future<void> deleteEvent(Event event) async {
    repository.delete(event.id);
  }
}
