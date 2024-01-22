import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/widgets/custom_shimmer.dart';
import 'package:parental_app/core/app/widgets/custom_state_switcher_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/domain/models/request/child_request_model.dart';
import 'package:parental_app/features/home/presentation/blocs/childs/childs_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/most_used_apps/most_used_apps_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/request_actions_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/requests_bloc.dart';
import 'package:parental_app/features/home/presentation/widgets/sync_device_data_widget.dart';

class SyncRequestWidget extends StatefulWidget {
  const SyncRequestWidget({super.key});

  @override
  State<SyncRequestWidget> createState() => _SyncRequestWidgetState();
}

class _SyncRequestWidgetState extends State<SyncRequestWidget> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    context.read<RequestsBloc>().add(const CallAction());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestActionsBloc, BaseScreenState<int>>(
      listener: (context, state) {
        if (state.status.isLoaded) {
          context.read<RequestsBloc>().add(const CallAction());
          context.read<MostUsedAppsBloc>().add(const CallAction());
          context.read<ChildsBloc>().add(const CallAction());
        }
      },
      child:
          BlocBuilder<RequestsBloc, BaseScreenState<List<ChildRequestModel>>>(
        builder: (context, state) {
          return CustomStateSwitcher(
            isLoading: !state.status.isLoaded,
            loadingWidget: const Column(
              children: [
                CustomShimmer(
                  height: 60,
                  width: double.infinity,
                ),
                SizedBox(height: 16),
              ],
            ),
            childWidget: (state.value?.length ?? 0) != 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ExpansionPanelList(
                          dividerColor: Colors.transparent,
                          animationDuration: const Duration(milliseconds: 200),
                          elevation: 0,
                          expandedHeaderPadding: EdgeInsets.zero,
                          expansionCallback: (x, y) {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              backgroundColor: Colors.transparent,
                              canTapOnHeader: true,
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  minVerticalPadding: 0,
                                  dense: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  style: ListTileStyle.drawer,
                                  title: Text(
                                    'Solicitudes de vinculación',
                                    style: AppStyles.w600(14),
                                  ),
                                );
                              },
                              body: SizedBox(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: ListView.separated(
                                    clipBehavior: Clip.none,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.value?.length ?? 0,
                                    itemBuilder: (context, x) {
                                      final child = state.value![x];
                                      return SyncDeviceDataWidget(child: child);
                                    },
                                    separatorBuilder: (_, x) {
                                      return const SizedBox(width: 16);
                                    },
                                  ),
                                ),
                              ),
                              isExpanded: isExpanded,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
