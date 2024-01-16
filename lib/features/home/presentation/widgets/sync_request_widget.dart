import 'package:flutter/material.dart';
import 'package:parental_app/core/app/data/mocked_data.dart';
import 'package:parental_app/core/utils/app_styes_util.dart';
import 'package:parental_app/features/home/presentation/widgets/sync_device_data_widget.dart';

class SyncRequestWidget extends StatefulWidget {
  const SyncRequestWidget({super.key});

  @override
  State<SyncRequestWidget> createState() => _SyncRequestWidgetState();
}

class _SyncRequestWidgetState extends State<SyncRequestWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: ListView.separated(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: MockedData.devicesNames.length,
                itemBuilder: (context, x) {
                  return SyncDeviceDataWidget(index: x);
                },
                separatorBuilder: (_, x) {
                  return const SizedBox(width: 16);
                },
              ),
            ),
            isExpanded: isExpanded,
          ),
        ],
      ),
    );
  }
}
