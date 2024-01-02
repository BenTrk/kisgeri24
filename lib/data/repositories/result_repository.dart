import "package:firebase_database/firebase_database.dart";
import "package:kisgeri24/data/models/result.dart";
import "package:kisgeri24/data/models/route_result.dart";
import "package:kisgeri24/data/models/team_result.dart";
import "package:kisgeri24/data/repositories/crud_repository.dart";
import "package:kisgeri24/logging.dart";

class ResultRepository extends CrudRepository<TeamResult> {
  final FirebaseDatabase _database;

  ResultRepository(this._database);

  @override
  Future<void> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<TeamResult>> fetchAll() {
    throw UnsupportedError("This operation is not supported for clients");
  }

  @override
  Future<List<TeamResult>> fetchAllByYear(String year) {
    throw UnsupportedError("This operation is not supported for clients");
  }

  @override
  Future<TeamResult?> getById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> save(TeamResult entity) async {
    logger.d("Saving result: $entity");
    logger.d(entity.toJson());
    entity.results.forEach((competitorName, result) async {
      await _database.ref("Results").child(entity.teamId).child(competitorName)
          .set(result.toJson());
    });
  }

  @override
  Future<void> update(TeamResult entity) async {
    logger.d("Updating result: $entity");
    await _database.ref("Results").child(entity.teamId).update(entity.toJson());
  }

  Future<void> updateRouteResult(
    String teamId,
    String routeId,
    String competitorName,
    RouteResult result,
  ) async {
    await _database
        .ref("Results")
        .child(teamId)
        .child(competitorName)
        .child("routes")
        .child(routeId)
        .set(result.toJson());
  }

  Future<TeamResult?> getResultsByTeamId(String teamId) async {
    final DataSnapshot snapshot = await _database.ref("Results/$teamId").get();
    if (snapshot.exists) {
      final map = Map<String, dynamic>.from(snapshot.value! as Map);
      logger.d("$map");
      final mapToPass = map.map((key, value) {
        return MapEntry(
          key,
          Result.fromJson(Map<String, dynamic>.from(value)),
        );
      });
      return TeamResult.fromJson(
        snapshot.key!,
        mapToPass,
      );
    }
    return Future.value();
  }
}
