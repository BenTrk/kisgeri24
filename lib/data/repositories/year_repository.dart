import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisgeri24/data/error/multiple_element_error.dart';
import 'package:kisgeri24/data/models/year.dart';
import 'package:kisgeri24/data/repositories/crud_repository.dart';
import 'package:kisgeri24/logging.dart';

class YearRepository extends CrudRepository<Year> {
  final FirebaseFirestore firestore;

  YearRepository(this.firestore);

  @override
  Future<void> delete(String id) {
    throw UnsupportedError("Deleting year is not supported for clients.");
  }

  @override
  Future<List<Year>> fetchAll() async {
    logger.d('About to fetch and list years');
    QuerySnapshot<Map<String, dynamic>> yearsSnapshot =
        await firestore.collection('years').get();
    List<Year> yearList = yearsSnapshot.docs.map((yearDoc) {
      Map<String, dynamic> data = yearDoc.data();
      data.putIfAbsent('id', () => yearDoc.id);
      return Year.fromJson(data);
    }).toList();
    logger.d('The following years are present: ${yearList.map((e) => e.year)}');
    return yearList;
  }

  @override
  Future<List<Year>> fetchAllByYear(String year) {
    throw UnimplementedError();
  }

  @override
  Future<void> save(Year entity) {
    throw UnsupportedError("Saving year is not supported for clients.");
  }

  @override
  Future<void> update(Year entity) {
    throw UnsupportedError("Updating year is not supported for clients.");
  }

  @override
  Future<Year?> getById(String id) async {
    QuerySnapshot<Map<String, dynamic>> yearsSnapshot =
        await firestore.collection('years').where('id', isEqualTo: id).get();
    if (yearsSnapshot.size > 0) {
      List<Year> yearList = yearsSnapshot.docs.map((yearDoc) {
        Map<String, dynamic> data = yearDoc.data();
        data.putIfAbsent('id', () => yearDoc.id);
        return Year.fromJson(data);
      }).toList();
      if (yearList.length > 1) {
        throw MultipleElementError("Multiple Year found with id: $id");
      }
      return yearList.first;
    }
    return null;
  }
}
