import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:kisgeri24/logging.dart";
import "package:kisgeri24/screens/overview/overview_bloc.dart";
import "package:kisgeri24/ui/figma_design.dart" as kisgeri_design;

Future<void> showTimerConfirmationDialog(BuildContext parentContext) {
  return showDialog<void>(
    context: parentContext,
    builder: (BuildContext context) {
      return BlocProvider(
        key: const Key("StartTimerOverlayBlocProvider"),
        create: (context) => OverviewBloc(),
        child: BlocBuilder<OverviewBloc, OverviewState>(
          builder: (context, state) {
            return AlertDialog(
              key: const Key("StartTimerOverlayAlertDialog"),
              alignment: Alignment.center,
              actionsAlignment: MainAxisAlignment.center,
              title: Text(
                key: const Key("StartTimerOverlayAlertDialogTitle"),
                "Most akarsz kezdeni?",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: kisgeri_design.Figma.typo.header2.copyWith(
                  color: kisgeri_design.Figma.colors.backgroundColor,
                ),
              ),
              backgroundColor: kisgeri_design.Figma.colors.primaryColor,
              content: Text(
                key: const Key("StartTimerOverlayAlertDialogContent"),
                "\nBiztosan most szeretnéd elindítani a számlálót? \nA "
                "számláló elindításával a kezdési időpontot már nem "
                "lehet megváltoztatni.",
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: kisgeri_design.Figma.typo.bold.copyWith(
                  color: kisgeri_design.Figma.colors.backgroundColor,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              elevation: 24.0,
              //shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              actions: <Widget>[
                Column(
                  key: const Key("StartTimerOverlayAlertDialogActions"),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      key: const Key("StartTimerOverlayAlertDialogYesButton"),
                      style: kisgeri_design.Figma.buttons.primaryButtonStyle
                          .copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          kisgeri_design.Figma.colors.backgroundColor,
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(203, 35),
                        ),
                      ),
                      onPressed: () {
                        context.read<OverviewBloc>().add(
                              LoadDataEvent.withTimer(
                                calculateEndTime(
                                  null, /* TODO: replace with timer value from context/dto */
                                ),
                              ),
                            );
                        logger.i("Timer start requested!");
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        key: const Key(
                          "StartTimerOverlayAlertDialogYesButtonText",
                        ),
                        "IGEN, INDULHAT A VERSENY!",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kisgeri_design.Figma.typo.preTitle.copyWith(
                          color: kisgeri_design.Figma.colors.secondaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      key: const Key("StartTimerOverlayAlertDialogNoButton"),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(203, 35),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color:
                                  kisgeri_design.Figma.colors.backgroundColor,
                            ),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(
                          kisgeri_design.Figma.colors.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        key: const Key(
                          "StartTimerOverlayAlertDialogNoButtonText",
                        ),
                        "MÉGSE",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kisgeri_design.Figma.typo.preTitle.copyWith(
                          color: kisgeri_design.Figma.colors.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

int calculateEndTime(int? timer) {
  /*
   get the team's category, and based on that, calculate the end time
   (since this dialog comes only for teams that are representing themself not
   in the 24h category)
  */
  if (timer != null) {
    return DateTime.now().millisecondsSinceEpoch + timer * 60 * 1000;
  }
  return 0;
}
