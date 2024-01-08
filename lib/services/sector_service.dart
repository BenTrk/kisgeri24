import 'package:kisgeri24/data/models/sector.dart';
import 'package:kisgeri24/data/repositories/sector_repository.dart';
import 'package:kisgeri24/logging.dart';

class SectorService {
  final SectorRepository repository;

  SectorService(this.repository);

  Future<List<String>> getSectorNames() async {
    logger.i('Collecting sector names');
    List<String> sectorNames = [];
    List<Sector> sectors = await getSectorsWithRoutes();
    for (Sector sector in sectors) {
      sectorNames.add(sector.name);
    }
    logger.i('${sectorNames.length} sector name got collected');
    return sectorNames;
  }

  Future<List<Sector>> getSectorsWithRoutes() async {
    logger.i('Collecting Sectors with their route info.');
    List<Sector> sectors = await repository.fetchAll();
    logger.i('${sectors.length} sector(s) got collected.');
    return sectors;
  }
}
