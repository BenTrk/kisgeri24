import "package:flutter/material.dart";
import "package:kisgeri24/data/dto/wall_dto.dart";
import "package:kisgeri24/screens/common/details_to_overview_app_bar.dart";
import "package:kisgeri24/ui/figma_design.dart" as kisgeri_design;

class RoutesScreen extends StatelessWidget {
  final WallDto wall;

  const RoutesScreen({super.key, required this.wall});

  @override
  Widget build(BuildContext context) {
    final List<Widget> routes = wall.routes
        .map(
          (route) => Center(
            child: Text(
              route.name,
              style: kisgeri_design.Figma.typo.body.copyWith(
                color: kisgeri_design.Figma.colors.secondaryColor,
              ),
            ),
          ),
        )
        .toList();
    return Scaffold(
      backgroundColor: kisgeri_design.Figma.colors.backgroundColor,
      appBar: getAppBar(context),
      body: Center(
        child: Column(
          children: [
            Text(
              key: const Key("wallName"),
              wall.name,
              style: kisgeri_design.Figma.typo.header2.copyWith(
                color: kisgeri_design.Figma.colors.secondaryColor,
                decoration: TextDecoration.underline,
                decorationColor: kisgeri_design.Figma.colors.secondaryColor,
              ),
            ),
            const SizedBox(height: 30),
            ListView(
              key: const Key("routes"),
              shrinkWrap: true,
              children: routes,
            ),
          ],
        ),
      ),
    );
  }
}
