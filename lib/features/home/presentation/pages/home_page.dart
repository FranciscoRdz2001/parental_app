import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/screen_base_bloc.dart';
import 'package:parental_app/core/app/data/global_data.dart';
import 'package:parental_app/core/app/theme/app_colors.dart';
import 'package:parental_app/core/app/widgets/custom_app_name.dart';
import 'package:parental_app/core/app/widgets/custom_scaffold_widget.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/core/utils/screen_sizer_util.dart';
import 'package:parental_app/features/home/presentation/blocs/childs/childs_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/most_used_apps/most_used_apps_bloc.dart';
import 'package:parental_app/features/home/presentation/blocs/requests/requests_bloc.dart';
import 'package:parental_app/features/home/presentation/widgets/circle_image_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/drawers/home_drawer.dart';
import 'package:parental_app/features/home/presentation/widgets/most_used_apps_data_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/parent_childs_list_widget.dart';
import 'package:parental_app/features/home/presentation/widgets/sync_request_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    context.read<RequestsBloc>().add(const CallAction());
    context.read<ChildsBloc>().add(const CallAction());
    context.read<MostUsedAppsBloc>().add(const CallAction());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      scaffoldKey: _scaffoldKey,
      drawer: const HomeDrawer(),
      child: RefreshIndicator(
        onRefresh: () async {
          loadData();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 135,
              toolbarHeight: 0,
              elevation: 0,
              actions: const [SizedBox()],
              leading: const SizedBox(),
              clipBehavior: Clip.hardEdge,
              scrolledUnderElevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppName(),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: const CircleImageWidget(
                            size: 48,
                            child: Icon(
                              Icons.person_2_outlined,
                              color: AppColors.lightGray,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Bienvenido ',
                                  style: AppStyles.w400(
                                    16,
                                    Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          GlobalData.instance.user?.fullName ??
                                              'Sin nombre',
                                      style: AppStyles.w600(16),
                                    ),
                                  ],
                                ),
                              ),
                              if (GlobalData.instance.user?.syncCode != null)
                                Text(
                                  '#${GlobalData.instance.user!.syncCode}',
                                  style: AppStyles.w600(
                                    12,
                                    AppColors.secondaryColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Aquí podrás ver el estado de los dispositivos de tu hijos',
                      style: AppStyles.w400(12, AppColors.lightGray),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: ScreenSizer.of(context).height - (135 - 56 - 32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SyncRequestWidget(),
                    Text(
                      'Dispositivos',
                      style: AppStyles.w600(14),
                    ),
                    const SizedBox(height: 16),
                    const ParentChildListWidget(),
                    const SizedBox(height: 16),
                    Text(
                      'Aplicaciones mas usadas',
                      style: AppStyles.w600(14),
                    ),
                    const SizedBox(height: 16),
                    const MostUsedAppsDataWidget(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
