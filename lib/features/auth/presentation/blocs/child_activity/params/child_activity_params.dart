import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/domain/models/activity/app_activity_model.dart';

class ChildActivityParams extends ScreenParams {
  final List<AppActivityModel> apps;

  const ChildActivityParams({
    required this.apps,
  });
}
