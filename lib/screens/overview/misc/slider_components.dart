import "package:flutter/material.dart";
import "package:kisgeri24/ui/figma_design.dart" as kisgeri;

enum SliderCategory {
  routes("UTAK"),
  challenges("KIHÍVÁSOK");

  final String value;

  const SliderCategory(this.value);

  TextStyle getTextStyle(SliderCategory category) {
    return TextStyle(
      color: category == this
          ? kisgeri.Figma.colors.backgroundColor
          : kisgeri.Figma.colors.primaryColor,
    );
  }
}
