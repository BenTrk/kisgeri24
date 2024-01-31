import "dart:convert";

import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/models/sector.dart";
import "package:kisgeri24/data/repositories/sector_repository.dart";
import "package:kisgeri24/logging.dart";

class SectorService {
  final SectorRepository repository;
  final Converter<Sector, SectorDto> sectorConverter;

  SectorService(this.repository, this.sectorConverter);

  Future<List<String>> getSectorNames() async {
    logger.i("Collecting sector names");
    List<String> sectorNames = [];
    List<SectorDto> sectors = await getSectorsWithRoutes();
    for (SectorDto sector in sectors) {
      sectorNames.add(sector.name);
    }
    logger.i("${sectorNames.length} sector name got collected");
    return sectorNames;
  }

  Future<List<SectorDto>> getSectorsWithRoutes() async {
    logger.i("Collecting Sectors with their route info.");
    List<Sector> sectorsFromDb = await repository.fetchAll();
    logger.i("${sectorsFromDb.length} sector(s) got collected.");
    if (sectorsFromDb.isNotEmpty) {
      logger.i("Converting ${sectorsFromDb.length} Sector(s) to Sector DTO(s)");
      List<SectorDto> sectors = [];
      for (Sector sector in sectorsFromDb) {
        sectors.add(sectorConverter.convert(sector));
      }
      return sectors;
    } else {
      logger.i("No sector found in DB");
      return [];
    }
  }
}
