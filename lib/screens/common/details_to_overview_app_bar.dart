import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/ui/figma_design.dart" as kisgeri_design;

AppBar getAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kisgeri_design.Figma.colors.backgroundColor,
    leading: Row(
      children: [
        IconButton(
          icon: Icon(
            kisgeri_design.Figma.icons.arrowLeft,
            color: kisgeri_design.Figma.colors.primaryColor,
          ),
          onPressed: () {
            logger.d("Leaving details screen");
            Navigator.pop(context);
          },
        ),
        AutoSizeText("ÁTTEKINTŐ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: kisgeri_design.Figma.typo.preTitle.copyWith(
              color: kisgeri_design.Figma.colors.secondaryColor,
            )),
      ],
    ),
    leadingWidth: 130,
  );
}
