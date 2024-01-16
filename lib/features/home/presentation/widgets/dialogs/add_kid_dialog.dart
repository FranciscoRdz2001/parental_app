import 'package:flutter/material.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/app/widgets/custom_input_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_snackbars_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';

class AddKidDialog extends StatelessWidget {
  const AddKidDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Agregar dispositivo',
          style: AppStyles.w600(16),
        ),
        const SizedBox(height: 16),
        const CustomInputWidget(
          label: 'Código de acceso',
          prefixIcon: Icons.lock_outline_rounded,
        ),
        const SizedBox(height: 16),
        CustomButtonWidget(
          text: 'Agregar',
          onTap: () {
            NavigatorRouter.pop();
            AppSnackbars.success(
              context,
              message: 'Dispositivo agregado',
              description: 'El dispositivo se ha agregado correctamente',
            );
          },
        ),
      ],
    );
  }
}
