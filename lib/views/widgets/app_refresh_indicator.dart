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

class NoDataAvailable extends StatelessWidget {
  final String? title;
  final String? message;
  final double? height;
  final bool isScrollable;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onPressed;

  const NoDataAvailable({
    super.key,
    this.title,
    this.message,
    this.height,
    this.isScrollable = true,
    this.icon = Icons.inbox_outlined,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ListView(
      shrinkWrap: !isScrollable,
      padding: EdgeInsets.zero,
      physics: !isScrollable ? const NeverScrollableScrollPhysics() : null,
      children: [
        SizedBox(
          height: height ?? Get.height * .7,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: .08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 46,
                      color: primaryColor.withValues(alpha: .7),
                    ),
                  ),

                  const SizedBox(height: 24),

                  CustomText.kText(
                    (title ?? 'Nothing here yet').tr,
                    size: 18,
                    weight: FontWeight.w700,
                    align: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  CustomText.kText(
                    (message ?? 'No data found.').tr,
                    size: 14,
                    color: Colors.grey.shade600,
                    align: TextAlign.center,
                    lines: 3,
                  ),

                  if (buttonText != null && onPressed != null) ...[
                    const SizedBox(height: 22),
                    ElevatedButton(
                      onPressed: onPressed,
                      child: Text(buttonText!.tr),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ApiErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final double? height;
  final bool isScrollable;
  final VoidCallback? onRetry;

  const ApiErrorWidget({
    super.key,
    this.title,
    this.message,
    this.height,
    this.isScrollable = true,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ListView(
      shrinkWrap: !isScrollable,
      padding: EdgeInsets.zero,
      physics: !isScrollable ? const NeverScrollableScrollPhysics() : null,
      children: [
        SizedBox(
          height: height ?? Get.height * .7,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: .08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cloud_off_rounded,
                      size: 46,
                      color: Colors.redAccent,
                    ),
                  ),

                  const SizedBox(height: 24),

                  CustomText.kText(
                    (title ?? 'Something went wrong').tr,
                    size: 18,
                    weight: FontWeight.w700,
                    align: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  CustomText.kText(
                    (message ?? 'Unable to load data. Please try again.').tr,
                    size: 14,
                    color: Colors.grey.shade600,
                    align: TextAlign.center,
                    lines: 3,
                  ),

                  if (onRetry != null) ...[
                    const SizedBox(height: 22),
                    ElevatedButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: Text('Try Again'.tr),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
