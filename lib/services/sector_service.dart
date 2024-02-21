import "dart:convert";

import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/models/sector.dart";
import "package:kisgeri24/data/repositories/sector_repository.dart";
import "package:kisgeri24/logging.dart";

class SectorService {
  final SectorRepository repository;
  final Converter<Sector, SectorDto> sectorConverter;

  SectorService(this.repository, this.sectorConverter);

  Future<List<String>> getSectorNames({bool ordered = false}) async {
    logger.i("Collecting sector names");
    final List<String> sectorNames = [];
    final List<SectorDto> sectors =
        await getSectorsWithRoutes(ordered: ordered);
    for (final SectorDto sector in sectors) {
      sectorNames.add(sector.name);
    }
    logger.i("${sectorNames.length} sector name got collected");
    return sectorNames;
  }

  Future<List<SectorDto>> getSectorsWithRoutes({bool ordered = false}) async {
    logger.i("Collecting Sectors with their route info.");
    final List<Sector> sectorsFromDb = await repository.fetchAll();
    logger.i("${sectorsFromDb.length} sector(s) got collected.");
    if (sectorsFromDb.isNotEmpty) {
      logger.i("Converting ${sectorsFromDb.length} Sector(s) to Sector DTO(s)");
      final List<SectorDto> sectors = [];
      for (final Sector sector in sectorsFromDb) {
        sectors.add(sectorConverter.convert(sector));
      }
      if (ordered) {
        logger.d("Ordering sectors and their walls and routes");
        for (final sector in sectors) {
          for (final wall in sector.walls) {
            wall.routes.sort((a, b) => a.ordinal.compareTo(b.ordinal));
          }
          sector.walls.sort((a, b) => a.ordinal.compareTo(b.ordinal));
        }
        sectors.sort((a, b) => a.ordinal.compareTo(b.ordinal));
      }
      return sectors;
    } else {
      logger.i("No sector found in DB");
      return [];
    }
  }
}
