import "package:auto_size_text/auto_size_text.dart";
import "package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:kisgeri24/data/dto/challenge_view.dart";
import "package:kisgeri24/data/dto/sector_dto.dart";
import "package:kisgeri24/data/dto/wall_dto.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/screens/challenge/challenges_screen.dart";
import "package:kisgeri24/screens/common/bottom_nav_bar.dart";
import "package:kisgeri24/screens/overview/dto/overview_dto.dart";
import "package:kisgeri24/screens/overview/misc/card_provider.dart";
import "package:kisgeri24/screens/overview/misc/slider_components.dart";
import "package:kisgeri24/screens/overview/overview_bloc.dart";
import "package:kisgeri24/screens/overview/popups/start_timer_overlay.dart";
import "package:kisgeri24/screens/routes/routes_screen.dart";
import "package:kisgeri24/ui/figma_design.dart" as kisgeri_design;

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  OverviewScreenState createState() => OverviewScreenState();
}

class OverviewScreenState extends State<OverviewScreen>
    with WidgetsBindingObserver {
  SliderCategory _selectedTab = SliderCategory.routes;
  final Map<SectorDto, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: const Key("overview_bloc_of_overview_screen"),
      create: (context) => OverviewBloc(),
      child: Scaffold(
        key: const Key("overview_screen_scaffold"),
        appBar: PreferredSize(
          key: const Key("overview_screen_app_bar_sized"),
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            key: const Key("overview_screen_app_bar"),
            centerTitle: true,
            leading: IconButton(
              key: const Key("overview_screen_menu_button"),
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: kisgeri_design.Figma.colors.primaryColor,
            ),
            actions: [
              IconButton(
                key: const Key("overview_screen_notification_button"),
                icon: Icon(
                  key: const Key("overview_screen_notification_icon"),
                  Icons.notifications_none_outlined,
                  color: kisgeri_design.Figma.colors.primaryColor,
                ),
                onPressed: () {
                  logger.d("Notification button pressed.");
                },
              ),
            ],
            title: AutoSizeText(
              "KISGERI24",
              key: const Key("overview_screen_app_bar_title"),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: kisgeri_design.Figma.typo.body.copyWith(
                color: kisgeri_design.Figma.colors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: kisgeri_design.Figma.colors.backgroundColor,
          ),
        ),
        bottomNavigationBar: const MainBottomNavigationBar(
          key: Key("overview_screen_bottom_nav_bar"),
        ),
        body: BlocListener<OverviewBloc, OverviewState>(
          key: const Key("overview_screen_bloc_listener"),
          listenWhen: (previous, current) {
            return current != previous;
          },
          listener: (context, state) {
            /*logger.d('State in listener: $state');
            if (state is OverviewInitial) {
              context.read<OverviewBloc>().add(const LoadDataEvent());
            }*/
          },
          child: BlocBuilder<OverviewBloc, OverviewState>(
            key: const Key("overview_screen_bloc_builder"),
            builder: (context, state) {
              if (state is OverviewInitial) {
                context.read<OverviewBloc>().add(
                      LoadDataEvent(),
                    );
                /* init state happens upon start but timer could have been
                   started already, this this value has to be checked
                   beforehand (maybe stored in shared prefs)
                */
              }
              if (state is LoadingState) {
                return const Center(
                  key: Key("overview_screen_loading_indicator_center"),
                  child: CircularProgressIndicator(
                    key: Key("overview_screen_loading_indicator"),
                    backgroundColor: Color(0xFF1e1e1e),
                    color: Color(0xFF1e1e1e),
                  ),
                );
              } else if (state is LoadedState) {
                return getCompleteView(context, state.data);
              } else if (state is ErrorState) {
                return Center(
                  key: const Key("overview_screen_error_message_center"),
                  child: Column(
                    key: const Key("overview_screen_error_message_column"),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.report_gmailerrorred_outlined,
                        key: Key("overview_screen_error_message_icon"),
                        color: Colors.red,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        child: AutoSizeText(
                          textAlign: TextAlign.center,
                          "Error: ${state.errorMessage}",
                          key: const Key("overview_screen_error_message"),
                          style: kisgeri_design.Figma.typo.body.copyWith(
                            color: kisgeri_design.Figma.colors.secondaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        key: const Key(
                            "overview_screen_error_message_retry_button"),
                        onPressed: () {
                          context.read<OverviewBloc>().add(LoadDataEvent());
                        },
                        style: kisgeri_design.Figma.buttons.primaryButtonStyle,
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                key: Key("overview_screen_loading_indicator_center_center"),
                child: CircularProgressIndicator(
                  key: Key("overview_screen_loading_indicator"),
                  backgroundColor: Color(0xff181305),
                  color: Color(0xFFFFBA00),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getCompleteView(BuildContext context, OverviewDto dto) {
    return ListView(
      key: const Key("overview_screen_list_view"),
      primary: false,
      shrinkWrap: true,
      children: [
        Column(
          key: const Key("overview_screen_sector_column"),
          children: [
            const SizedBox(height: 25),
            AutoSizeText(
              "Áttekintő",
              key: const Key("overview_screen_overview_text"),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: kisgeri_design.Figma.typo.header2.copyWith(
                color: kisgeri_design.Figma.colors.secondaryColor,
                decoration: TextDecoration.underline,
                decorationColor: kisgeri_design.Figma.colors.secondaryColor,
              ),
            ),
            const SizedBox(height: 30),
            getPointsOrStartSection(context, dto),
            const SizedBox(height: 30),
            CustomSlidingSegmentedControl<SliderCategory>(
              key: const Key("overview_screen_category_slider"),
              fixedWidth: 172.0,
              // 152.0?
              initialValue: _selectedTab,
              children: {
                SliderCategory.routes: AutoSizeText(
                  key: const Key("overview_screen_routes_text"),
                  SliderCategory.routes.value,
                  style: SliderCategory.routes.getTextStyle(_selectedTab),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SliderCategory.challenges: AutoSizeText(
                  key: const Key("overview_screen_challenges_text"),
                  SliderCategory.challenges.value,
                  style: SliderCategory.challenges.getTextStyle(_selectedTab),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              },
              decoration: BoxDecoration(
                color: kisgeri_design.Figma.colors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: kisgeri_design.Figma.colors.primaryColor,
                ),
              ),
              thumbDecoration: BoxDecoration(
                color: kisgeri_design.Figma.colors.primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInToLinear,
              onValueChanged: (v) {
                setState(() {
                  logger.d(
                    "slider value changed from "
                    "${_selectedTab.value} to ${v.value}",
                  );
                  _selectedTab = v;
                });
              },
            ),
            const SizedBox(height: 20),
            getContentBasedOnSliderValue(dto),
          ],
        ),
      ],
    );
  }

  Widget getContentBasedOnSliderValue(OverviewDto dto) {
    logger.d("about to return content based on selected tab: $_selectedTab");
    if (_selectedTab == SliderCategory.routes) {
      return SizedBox(
        width: 350,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                dto.sectors.map((route) => buildSectorCard(route)).toList(),
          ),
        ),
      );
    }
    return SizedBox(
      width: 310,
      child: Center(
        child: composeChallengeView(dto),
      ),
    );
  }

  Column composeChallengeView(OverviewDto dto) {
    final List<Widget> elements = [];
    for (final ChallengeView element in dto.challenges) {
      elements.add(const SizedBox(height: 20));
      elements.add(
        buildChallengeCard(element, (challenge) async {
          await _performNavigationToChallenge(challenge);
        }),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...elements],
    );
  }

  Widget getPointsOrStartSection(BuildContext context, OverviewDto dto) {
    if (dto.started != null) {
      return getPointsAndCountdownSection(dto);
    }
    return getStartTimeSection(context);
  }

  Widget getPointsAndCountdownSection(OverviewDto dto) {
    return const Text("data");
  }

  Widget getStartTimeSection(BuildContext context) {
    return Column(
      key: const Key("overview_screen_start_time_section"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          key: const Key("overview_screen_start_time_text"),
          "A gomb megnyomásával elindítjátok a számlálót",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: kisgeri_design.Figma.colors.secondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        SizedBox(
          key: const Key("overview_screen_start_time_button_box"),
          width: 240,
          height: 50,
          child: ButtonTheme(
            key: const Key("overview_screen_start_time_button_theme"),
            child: ElevatedButton(
              key: const Key("overview_screen_start_time_button"),
              style: kisgeri_design.Figma.buttons.primaryButtonStyle,
              onPressed: () async {
                await showTimerConfirmationDialog(context);
              },
              child: AutoSizeText(
                key: const Key("overview_screen_start_time_button_text"),
                "INDULHAT A VERSENY!",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Lato",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: kisgeri_design.Figma.colors.backgroundColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSectorCard(SectorDto sector) {
    if (sector.walls.length == 1) {
      logger.d("sector has only one wall (${sector.walls[0].name}, "
          "returning text button instead of card");
      return Center(
        key: Key("overview_screen_sector_card_center_${sector.name}"),
        child: SizedBox(
          key: Key("overview_screen_sector_card_sized_box_${sector.name}"),
          width: 312,
          child: TextButton(
            key: Key("overview_screen_sector_card_text_button_${sector.name}"),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoutesScreen(
                    wall: sector.walls.first,
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                kisgeri_design.Figma.colors.backgroundColor,
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.zero,
              ),
              shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                sector.name,
                key: Key("overview_screen_sector_card_text_${sector.name}"),
                style: kisgeri_design.Figma.typo.body.copyWith(
                  color: kisgeri_design.Figma.colors.secondaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );
    }
    final bool isExpanded = _expandedStates[sector] ?? false;
    logger.d("sector ${sector.name} has ${sector.walls.length} walls returning "
        "expansion tile with ${isExpanded ? "expanded" : "collapsed"} state.");
    return Card(
      key: Key("overview_screen_sector_card_${sector.name}"),
      elevation: 0.0,
      color: kisgeri_design.Figma.colors.backgroundColor,
      child: ExpansionTile(
        key: Key("overview_screen_sector_expansion_tile_${sector.name}"),
        onExpansionChanged: (value) {
          setState(() {
            _expandedStates[sector] = value;
          });
        },
        textColor: kisgeri_design.Figma.colors.secondaryColor,
        title: AutoSizeText(
          sector.name,
          key: Key("overview_screen_sector_title_${sector.name}"),
          style: kisgeri_design.Figma.typo.body
              .copyWith(color: kisgeri_design.Figma.colors.secondaryColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: _getRotatingTrailingIconIfNecessary(sector, isExpanded),
        children: [
          ListView(
            key: const Key("overview_screen_sector_list_view"),
            shrinkWrap: true,
            children: sector.walls
                .map(
                  (wall) => buildWallCard(wall, (wall) async {
                    await _performNavigationToRoutesScreen(wall);
                  }),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget? _getRotatingTrailingIconIfNecessary(
    SectorDto sectorDto,
    bool isExpanded,
  ) {
    if (sectorDto.walls.length == 1) {
      return Icon(
        key: const Key("overview_screen_sector_trailing_icon"),
        kisgeri_design.Figma.icons.chevronDown,
        color: Colors.transparent,
      );
    }
    return AnimatedRotation(
      turns: isExpanded ? 0.5 : 0,
      duration: const Duration(milliseconds: 400),
      child: Icon(
        key: const Key("overview_screen_sector_trailing_icon"),
        kisgeri_design.Figma.icons.chevronDown,
        color: kisgeri_design.Figma.colors.secondaryColor,
      ),
    );
  }

  Future<void> _performNavigationToChallenge(
    ChallengeView challengeView,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengesScreen(challengeView),
      ),
    );
  }

  Future<void> _performNavigationToRoutesScreen(WallDto wall) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoutesScreen(
          wall: wall,
        ),
      ),
    );
  }
}
