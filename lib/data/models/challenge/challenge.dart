import 'package:kisgeri24/data/models/challenge/tier.dart';
import 'package:kisgeri24/data/models/entity.dart';
import 'package:kisgeri24/data/models/init_values.dart';
import 'package:kisgeri24/logging.dart';

class Challenge extends Entity {
  String id;

  String yearId;

  String name;

  Set<Tier> tiers;

  Challenge(this.id, this.yearId, this.name, this.tiers);

  factory Challenge.fromJson(Map<String, dynamic> parsedJson) {
    logger.d('Creating Event instance based on the input JSON: $parsedJson');
    var tiers = parsedJson['tiers'];
    if (tiers != null) {

    }
    return Challenge(
      parsedJson['id'] ?? unsetString,
      parsedJson['yearId'] ?? unsetString,
      parsedJson['name'] ?? unsetString,
      {},
    );
  }
}
