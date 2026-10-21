import '../../utils/app_imports.dart';
import 'app_fade_animated_switcher.dart';

class AppRefreshIndicator extends StatelessWidget {
  final RefreshCallback onRefresh;
  final bool enableRefresh;
  final Widget? child;
  const AppRefreshIndicator({
    super.key,
    required this.onRefresh,
    this.child,
    this.enableRefresh = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppFadeAnimatedSwitcher(
      child: enableRefresh
          ? RefreshIndicator(
              onRefresh: onRefresh,
              color: AppColors.primary,
              child: AppFadeAnimatedSwitcher(child: child ?? ListView()),
            )
          : (child ?? ListView()),
    );
  }
}

Widget noDataAvailable({
  String? message,
  double? height,
  bool isScrollable = true,
}) {
  return ListView(
    shrinkWrap: !isScrollable,
    padding: EdgeInsets.zero,
    physics: !isScrollable ? const NeverScrollableScrollPhysics() : null,
    children: [
      SizedBox(
        height: height ?? Get.height * .7,
        child: Center(
          child: CustomText.kText((message ?? 'No data found.').tr),
        ),
      ),
    ],
  );
}

Widget errorLoadingData({
  String? message,
  double? height,
  bool isScrollable = true,
  ScrollController? sc,
}) {
  return ListView(
    controller: sc,
    shrinkWrap: !isScrollable,
    physics: !isScrollable ? const NeverScrollableScrollPhysics() : null,
    children: [
      SizedBox(
        height: height ?? Get.height * .7,
        child: Center(
          child: CustomText.kText(message ?? 'Something went wrong.'),
        ),
      ),
    ],
  );
}
