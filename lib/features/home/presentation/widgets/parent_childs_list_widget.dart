import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/widgets/custom_state_switcher_widget.dart';
import 'package:parental_app/domain/models/childs/child_data_model.dart';
import 'package:parental_app/features/home/presentation/blocs/childs/childs_bloc.dart';
import 'package:parental_app/features/home/presentation/widgets/device_data_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/placeholders/devices_placeholder_widget.dart';

class ParentChildListWidget extends StatefulWidget {
  const ParentChildListWidget({super.key});

  @override
  State<ParentChildListWidget> createState() => _ParentChildListWidgetState();
}

class _ParentChildListWidgetState extends State<ParentChildListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ChildsBloc>().add(const CallAction());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildsBloc, BaseScreenState<List<ChildDataModel>>>(
      builder: (context, state) {
        return CustomStateSwitcher(
          childWidget: SizedBox(
            height: 120,
            child: ListView.separated(
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
