import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_state_switcher_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/domain/models/childs/child_data_model.dart';
import 'package:parental_app/features/home/presentation/blocs/childs/childs_bloc.dart';
import 'package:parental_app/features/home/presentation/widgets/device_data_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/placeholders/devices_placeholder_widget.dart';

class ParentChildListWidget extends StatelessWidget {
  const ParentChildListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildsBloc, BaseScreenState<List<ChildDataModel>>>(
      builder: (context, state) {
        final isEmpty = state.value?.isEmpty ?? true;
        return CustomStateSwitcher(
          childWidget: SizedBox(
            height: 120,
            child: isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.devices_other,
                          color: AppColors.lightGray,
                          size: 32,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tienes dispositivos registrados',
                          style: AppStyles.w400(12, AppColors.lightGray),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.value?.length ?? 0,
                    itemBuilder: (context, x) {
                      final child = state.value![x];
                      return DeviceDataWidget(child: child);
                    },
                    separatorBuilder: (_, x) {
                      return const SizedBox(width: 16);
                    },
                  ),
          ),
          isLoading: state.status.isLoading,
          loadingWidget: const DevicesPlaceholderWidget(),
        );
      },
    );
  }
}
