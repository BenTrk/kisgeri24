import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/misc/init_values.dart";
import "package:kisgeri24/ui/figma_design.dart" as kisgeri;

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  MainBottomNavigationBarState createState() => MainBottomNavigationBarState();
}

class MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  final double _height = 70.0;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          logger.d("ÁTTEKINTŐ");
        case 1:
          logger.d("TELJESÍTMÉNY");
        case 2:
          logger.d("NAPIREND");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).padding.bottom + _height,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kisgeri.Figma.colors.primaryColor,
          selectedItemColor: kisgeri.Figma.colors.secondaryColor,
          selectedFontSize: 12,
          unselectedItemColor: kisgeri.Figma.colors.backgroundColor,
          unselectedIconTheme:
              IconThemeData(color: kisgeri.Figma.colors.backgroundColor),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedLabelStyle: zeroHeightTextStyle,
          unselectedLabelStyle: zeroHeightTextStyle,
          items: <BottomNavigationBarItem>[
            buildNavItem(0, kisgeri.Figma.icons.home, "ÁTTEKINTŐ"),
            buildNavItem(1, kisgeri.Figma.icons.pieChart, "TELJESÍTMÉNY"),
            buildNavItem(2, kisgeri.Figma.icons.calendar, "NAPIREND"),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  BottomNavigationBarItem buildNavItem(
    int index,
    IconData icon,
    String label,
  ) {
    bool isSelected = index == _selectedIndex;
    return BottomNavigationBarItem(
      icon: Container(
        key: Key("bottom_nav_bar_item_-$index-[$label]"),
        height: 55,
        width: 95,
        decoration: isSelected
            ? BoxDecoration(
                color: kisgeri.Figma.colors.navbarSelectedBackgroundColor,
                borderRadius: BorderRadius.circular(12.0),
              )
            : null,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? kisgeri.Figma.colors.secondaryColor
                    : kisgeri.Figma.colors.backgroundColor,
              ),
              const SizedBox(height: 6),
              AutoSizeText(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kisgeri.Figma.typo.button.copyWith(
                  color: isSelected
                      ? kisgeri.Figma.colors.secondaryColor
                      : kisgeri.Figma.colors.backgroundColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      label: unsetString,
    );
  }
}
