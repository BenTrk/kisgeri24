import "package:flutter/cupertino.dart";
import "package:kisgeri24/logging.dart";
import "package:timer_count_down/timer_count_down.dart";

class CountDownTimer extends StatelessWidget {
  final int _endTime;

  const CountDownTimer(this._endTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Countdown(
      key: const Key("timerCountDown"),
      seconds: (DateTime.fromMillisecondsSinceEpoch(_endTime)
                  .difference(DateTime.now())
                  .inMilliseconds /
              1000)
          .round(),
      build: (BuildContext context, double time) => Text(time.toString()),
      onFinished: () {
        logger.i("Timer is done!");
      },
    );
  }
}
