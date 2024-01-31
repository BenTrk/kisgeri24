import "package:kisgeri24/data/converter/event_event_dto_converter.dart";
import "package:kisgeri24/data/dto/event_dto.dart";
import "package:kisgeri24/data/models/event.dart";
import "package:test/test.dart";

late EventToEventDtoConverter underTest;

void main() {
  testConvert();
}

void testConvert() {
  test('Convert', () {
    underTest = EventToEventDtoConverter();
    Event entity = new Event(
      'testId',
      'testYearId',
      'testName',
      123,
      456,
      'testDetails',
    );
    EventDto expected = new EventDto.all(
      entity.id,
      entity.yearId,
      entity.name,
      entity.startTime,
      entity.endTime,
      entity.details,
    );

    expect(underTest.convert(entity), expected);
  });
}
