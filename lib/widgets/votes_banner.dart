import 'package:flutter/material.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'container.dart';

class VotesBanner extends StatelessWidget {
  const VotesBanner({Key? key, required this.votes}) : super(key: key);

  final Map<String, int> votes;

  double _computeMaxCardOnScreenWidth(BuildContext context, int votesCount) {
    final constraints = BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width,
    );
    // Аналог Expanded в Row
    return constraints.maxWidth / 3 - 24;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: votes.entries
            .map(
              (e) => CustomContainer.bordered(
                width: _computeMaxCardOnScreenWidth(context, votes.length),
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
            )
            .toList(),
      ),
    );
  }
}
