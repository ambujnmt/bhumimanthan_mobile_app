import '../../utils/app_imports.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final AlignmentGeometry? alignment;
  final BoxBorder? border;
  final BoxShape? shape;
  final bool hideShadow;
  final Clip? clip;

  const AppContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.borderRadius = AppDimentions.defaultBoxRadius,
    this.color = white,
    this.borderColor = const Color.fromARGB(102, 231, 231, 231),
    this.borderWidth = 1.2,
    this.alignment,
    this.border,
    this.shape,
    this.hideShadow = true,
    this.clip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      clipBehavior: clip ?? Clip.none,
      padding: padding ?? EdgeInsets.all(AppDimentions.screenPaddingS),
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: shape == null
            ? BorderRadius.circular(borderRadius)
            : null,
        shape: shape ?? BoxShape.rectangle,
        border:
            border ??
            Border.all(
              color: borderColor,
              width: borderWidth,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
        boxShadow: hideShadow
            ? null
            : [
                BoxShadow(
                  color: black.withValues(alpha: 0.25),
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: child,
    );
  }
}

class CustomBottomNavContainer extends StatelessWidget {
  final Widget child;
  const CustomBottomNavContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimentions.defaultScreenPadding,
            vertical: AppDimentions.screenPaddingXS,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            border: Border(top: BorderSide(color: AppColors.hint, width: 2)),
          ),
          child: child,
        ),
      ),
    );
  }
}
