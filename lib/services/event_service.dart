import 'dart:convert';

import 'package:kisgeri24/data/dto/event_dto.dart';
import 'package:kisgeri24/data/repositories/event_repository.dart';
import 'package:kisgeri24/logging.dart';
import 'package:kisgeri24/data/models/event.dart';

class EventService {
  final EventRepository repository;
  final Converter<Event, EventDto> eventConverter;

  EventService(this.repository, this.eventConverter);

  Future<List<EventDto>> collectEventsForYearOrdered(String yearId) async {
    logger.i(
        "Collecting events that are designated for the following year (ID): $yearId");
    List<Event> entities = await repository.fetchAllByYear(yearId);
    List<EventDto> eventDtos = [];
    for (Event event in entities) {
      eventDtos.add(eventConverter.convert(event));
    }

    eventDtos.sort((a, b) => a.startTime.compareTo(b.startTime));

    logger.i('The following events got collected: $eventDtos');
    return eventDtos;
  }
}
