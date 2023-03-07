import 'package:flutter/material.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'container.dart';

class VotesBanner extends StatelessWidget {
  const VotesBanner({Key? key, required this.votes}) : super(key: key);

  final Map<String, int> votes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: votes.entries
          .map(
            (e) => Expanded(
              child: CustomContainer.bordered(
                color: Colors.transparent,
                borderRadiusAll: 4,
                margin: const EdgeInsets.only(left: 12, right: 12),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    CustomText.titleMedium(e.value.toString(),
                        color: AppTheme.theme.colorScheme.primary,
                        fontWeight: 700),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: CustomText.labelSmall(e.key,
                          fontWeight: 600, letterSpacing: 0.2),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  // [
  //   Expanded(
  //     child: CustomContainer.bordered(
  //       color: Colors.transparent,
  //       borderRadiusAll: 4,
  //       margin: const EdgeInsets.only(left: 24, right: 12),
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         children: <Widget>[
  //           CustomText.titleMedium("45",
  //               color: AppTheme.theme.colorScheme.primary, fontWeight: 700),
  //           Container(
  //             margin: const EdgeInsets.only(top: 4),
  //             child: const CustomText.labelSmall("За",
  //                 fontWeight: 600, letterSpacing: 0.2),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //   Expanded(
  //     child: CustomContainer.bordered(
  //       color: Colors.transparent,
  //       borderRadiusAll: 4,
  //       margin: const EdgeInsets.only(left: 12, right: 12),
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         children: <Widget>[
  //           CustomText.titleMedium("2",
  //               color: AppTheme.theme.colorScheme.primary, fontWeight: 700),
  //           Container(
  //             margin: const EdgeInsets.only(top: 4),
  //             child: const CustomText.labelSmall("Против",
  //                 fontWeight: 600, letterSpacing: 0.2),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //   Expanded(
  //     child: CustomContainer.bordered(
  //       color: Colors.transparent,
  //       borderRadiusAll: 4,
  //       margin: const EdgeInsets.only(left: 12, right: 24),
  //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
  //       child: Column(
  //         children: <Widget>[
  //           CustomText.titleMedium("12",
  //               color: AppTheme.theme.colorScheme.primary, fontWeight: 700),
  //           Container(
  //             margin: const EdgeInsets.only(top: 4),
  //             child: const CustomText.labelSmall("Воздержалось",
  //                 fontWeight: 600, letterSpacing: 0.2),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // ],
}
