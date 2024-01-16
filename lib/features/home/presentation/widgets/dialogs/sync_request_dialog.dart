import 'package:flutter/material.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_snackbars_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';

class SyncRequestDialog extends StatelessWidget {
  const SyncRequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Aceptar solicitud de sincronización',
          style: AppStyles.w600(16),
        ),
        const SizedBox(height: 16),
        CustomButtonWidget(
          text: 'Aceptar',
          onTap: () {
            NavigatorRouter.pop();
            AppSnackbars.success(
              context,
              message: 'Dispositivo agregado',
              description: 'El dispositivo se ha agregado correctamente',
            );
          },
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            NavigatorRouter.pop();
            AppSnackbars.error(
              context,
              message: 'Solicitud rechazada',
              description: 'La solicitud de sincronización ha sido rechazada',
            );
          },
          child: Text(
            'Rechazar solicitud de sincronización',
            style: AppStyles.w400(14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
