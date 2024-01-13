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
}
