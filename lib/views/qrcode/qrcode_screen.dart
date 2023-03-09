import 'package:face_to_face_voting/blocs/profile/profile_bloc.dart';
import 'package:face_to_face_voting/theme/app_theme.dart';
import 'package:face_to_face_voting/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    CustomText.titleMedium("Это ваш пропуск на голосование",
                        color: AppTheme.theme.colorScheme.onBackground,
                        fontWeight: 700),
                    CustomText.bodySmall(
                        "Обязательно покажите QR-код при входе и выходе из аудитории",
                        color: AppTheme.theme.colorScheme.onBackground,
                        fontWeight: 500)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return state.maybeMap(
                    success: (state) {
                      return QrImage(
                        data: state.user.$id,
                        version: QrVersions.auto,
                        size: MediaQuery.of(context).size.width * 0.7,
                      );
                    },
                    orElse: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
