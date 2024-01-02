import "dart:convert";

import "package:kisgeri24/data/dto/activity_result_dto.dart";
import "package:kisgeri24/data/models/activity_result.dart";

class ActivityResultDtoToActivityResultConverter
    extends Converter<ActivityResultDto, ActivityResult> {
  @override
  ActivityResult convert(ActivityResultDto input) {
    return ActivityResult(
      input.activityId,
      input.points,
      input.resultTitle,
    );
  }
}
