import "dart:convert";

import "package:kisgeri24/data/dto/activity_result_dto.dart";
import "package:kisgeri24/data/models/activity_result.dart";

class ActivityResultToActivityResultDtoConverter
    extends Converter<ActivityResult, ActivityResultDto> {
  @override
  ActivityResultDto convert(ActivityResult input) {
    return ActivityResultDto(
      input.activityId,
      input.points,
      input.resultTitle,
    );
  }
}
