import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/widgets/custom_button_widget.dart';
import 'package:parental_app/core/navigator/app_navigator.dart';
import 'package:parental_app/core/utils/app_snackbars_util.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/params/request_action_params.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/request_actions_bloc.dart';

class SyncRequestDialog extends StatelessWidget {
  final String uuid;
  const SyncRequestDialog({super.key, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestActionsBloc, BaseScreenState<int>>(
      listener: (context, state) {
        if (state.status.isLoaded) {
          final type = state.value!;
          final titleType = type == 1 ? 'agregado' : 'eliminado';
          final descriptionType = type == 1
              ? 'El dispositivo se ha agregado correctamente'
              : 'El dispositivo se ha eliminado correctamente';
          AppSnackbars.success(
            context,
            message: 'Dispositivo $titleType',
            description: descriptionType,
          );
          if (context.mounted) {
            NavigatorRouter.pop();
          }
        } else if (state.status.isError) {
          AppSnackbars.error(
            context,
            message: 'Error al agregar dispositivo',
            description: 'Ha ocurrido un error al agregar el dispositivo',
          );
          if (context.mounted) {
            NavigatorRouter.pop();
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Aceptar solicitud de sincronización',
            style: AppStyles.w600(16),
          ),
          const SizedBox(height: 16),
          BlocBuilder<RequestActionsBloc, BaseScreenState>(
            builder: (context, state) {
              return CustomButtonWidget(
                text: 'Aceptar',
                isLoading: state.status.isLoading,
                onTap: () {
                  context.read<RequestActionsBloc>().add(
                        CallAction(
                          params: RequestActionParams(
                            uuid: uuid,
                            isAccept: true,
                          ),
                        ),
                      );
                },
              );
            },
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              context.read<RequestActionsBloc>().add(
                    CallAction(
                      params: RequestActionParams(
                        uuid: uuid,
                        isAccept: false,
                      ),
                    ),
                  );
            },
            child: Text(
              'Rechazar solicitud de sincronización',
              style: AppStyles.w400(14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
