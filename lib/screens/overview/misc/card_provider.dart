import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:kisgeri24/data/dto/challenge_view.dart";
import "package:kisgeri24/data/dto/wall_dto.dart";
import "package:kisgeri24/ui/figma_design.dart" as kisgeri_design;

const String indentation = "     ";

// this does not provide a Card but due to naming I put it here until I find
// a better place
Row buildChallengeCard(
  ChallengeView challenge,
  Function(ChallengeView) onCardTap,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AutoSizeText(
        challenge.name,
        style: kisgeri_design.Figma.typo.body.copyWith(
          color: kisgeri_design.Figma.colors.secondaryColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      InkWell(
        onTap: () async {
          onCardTap(challenge);
        },
        child: Icon(
          kisgeri_design.Figma.icons.edit,
          color: kisgeri_design.Figma.colors.secondaryColor,
        ),
      ),
    ],
  );
}

Card buildWallCard(WallDto wall, Function(WallDto) onCardTap) {
  return Card(
    key: Key("overview_screen_wall_card_${wall.name}"),
    //elevation: 1.0,
    elevation: 0.0,
    color: kisgeri_design.Figma.colors.backgroundColor,
    child: ListTile(
      key: Key("overview_screen_wall_list_tile_${wall.name}"),
      title: AutoSizeText(
        key: Key("overview_screen_wall_list_tile_title_${wall.name}"),
        indentation + wall.name,
        style: kisgeri_design.Figma.typo.body.copyWith(
          color: kisgeri_design.Figma.colors.secondaryColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        onCardTap(wall);
      },
    ),
  );
}
