import "package:flutter/material.dart";
import "package:kisgeri24/data/dto/challenge_view.dart";
import "package:kisgeri24/screens/common/details_to_overview_app_bar.dart";
import "package:kisgeri24/ui/figma_design.dart" as kisgeri_design;

class ChallengesScreen extends StatelessWidget {
  final ChallengeView challenge;

  const ChallengesScreen(this.challenge, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kisgeri_design.Figma.colors.backgroundColor,
      appBar: getAppBar(context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(challenge.name,
                style: kisgeri_design.Figma.typo.header2.copyWith(
                  color: kisgeri_design.Figma.colors.secondaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: kisgeri_design.Figma.colors.secondaryColor,
                )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
