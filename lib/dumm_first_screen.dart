import 'package:flutter/material.dart';
import 'package:kisgeri24/classes/place.dart';
import 'package:kisgeri24/classes/places.dart';
import 'package:kisgeri24/data/repositories/route_repository.dart';
import 'package:kisgeri24/logging.dart';
import 'package:kisgeri24/model/init.dart';
import 'package:kisgeri24/services/firebase_service.dart';
import 'package:kisgeri24/data/models/route.dart' as kisgeri;

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {

  List<kisgeri.Route> _routes = [];

  @override
  void initState() {
    super.initState();
  }

  void collectRoutes() async {
    //_routes = await RouteRepository(FirebaseSingletonProvider.instance.database).fetchAll();
    Places places = await Init.getPlacesWithRoutes();
    logger.d('${places.placeList.length} places got fetched.');
    for (int i = 0; i < places.placeList.length; i++) {
      logger.d('Place: ${places.placeList[i]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route List'),
      ),
      body: _buildRouteList(),
    );
  }

  Widget _buildRouteList() {
    collectRoutes();
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            true;
          });
        },
        children: _routes.map<ExpansionPanel>((kisgeri.Route route) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(route.name),
              );
            },
            body: ListTile(
              title: Text('Points: ${route.points}'),
              subtitle: Text('Difficulty: ${route.difficulty}'),
              // Add more details here if needed
            ),
            isExpanded: true,
          );
        }).toList(),
      ),
    );
  }
}
