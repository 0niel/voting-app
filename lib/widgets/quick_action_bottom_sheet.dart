import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/utils/spacing.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QuickActionBottomSheet {
  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: AppTheme.theme.colorScheme.background,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: Padding(
              padding: Spacing.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CustomText.titleMedium("Быстрые действия", fontWeight: 700),
                  Container(
                    margin: Spacing.top(16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const [
                            Expanded(
                              child: QuickActionWidget(
                                iconData: Icons.qr_code,
                                actionText: 'Сканировать',
                              ),
                            ),
                            Expanded(
                              child: QuickActionWidget(
                                iconData: Icons.people,
                                actionText: 'Участники',
                              ),
                            ),
                            Expanded(
                              child: QuickActionWidget(
                                iconData: MdiIcons.vote,
                                actionText: 'Голосование',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuickActionWidget extends StatelessWidget {
  final IconData iconData;
  final String actionText;

  const QuickActionWidget(
      {Key? key, required this.iconData, required this.actionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Spacing.y(12),
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Material(
              color: AppTheme.theme.colorScheme.primary.withAlpha(20),
              // button color
              child: InkWell(
                splashColor: AppTheme.theme.colorScheme.primary.withAlpha(100),
                highlightColor: Colors.transparent,
                child: SizedBox(
                  width: 52,
                  height: 52,
                  child: Icon(
                    iconData,
                    color: AppTheme.theme.colorScheme.primary,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: Spacing.top(4),
            child: CustomText.bodySmall(actionText, fontWeight: 600),
          )
        ],
      ),
    );
  }
}
