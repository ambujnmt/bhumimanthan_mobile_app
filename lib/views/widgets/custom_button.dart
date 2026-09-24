import '../../utils/app_imports.dart';

class CustomButton extends StatelessWidget {
  final EdgeInsetsGeometry? textPadding;

  final Alignment textAlignment;

  final String? text;
  final VoidCallback? onTap;

  /// Custom widgets
  final Widget? left;
  final Widget? right;

  /// Or pass icons directly
  final IconData? leftIcon;
  final IconData? rightIcon;

  final double height;
  final double? width;
  final EdgeInsetsGeometry padding;

  /// Gradient colors
  final List<Color>? colors;

  final Color? textColor;
  final Color? color;
  final double? textSize;
  final BoxBorder? border;
  final double? radiusVal;
  const CustomButton({
    super.key,
    this.text,
    this.onTap,
    this.left,
    this.right,
    this.leftIcon,
    this.rightIcon,
    this.height = 52,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.colors,
    this.color,
    this.textColor,
    this.textPadding,
    this.textAlignment = Alignment.center,
    this.textSize,
    this.width,
    this.border,
    this.radiusVal,
  });

  @override
  Widget build(BuildContext context) {
    final Widget? leftWidget =
        left ?? (leftIcon != null ? Icon(leftIcon, color: Colors.white) : null);

    final Widget? rightWidget =
        right ??
        (rightIcon != null ? Icon(rightIcon, color: Colors.white) : null);

    return Material(
      color: Colors.transparent,
      child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radiusVal ?? AppDimentions.boxRadiusL,
          ),
          color: colors == null ? (color ?? AppColors.primary) : null,
          border: border,
          gradient: colors == null
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors:
                      colors ?? [AppColors.primarylight, AppColors.secondary],
                ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            radiusVal ?? AppDimentions.boxRadiusL,
          ),
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Center Text
              Padding(
                padding:
                    textPadding ??
                    EdgeInsets.symmetric(
                      horizontal: AppDimentions.screenPaddingS,
                    ),
                child: Align(
                  alignment: textAlignment,
                  child: CustomText.kText(
                    text ?? 'custom button',
                    weight: FontWeight.w700,
                    color: textColor ?? Colors.white,
                    size: textSize ?? 18,
                    lines: 1,
                  ),
                ),
              ),

              /// Left & Right Content
              Padding(
                padding: padding,
                child: Row(
                  children: [
                    SizedBox(
                      width: height - 10,
                      height: height - 10,
                      child: leftWidget ?? const SizedBox(),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: rightWidget ?? const SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
