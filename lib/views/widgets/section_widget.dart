import '../../utils/app_imports.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;
  final Widget? content;
  final EdgeInsetsGeometry? padding;
  final FontWeight? titleWeight;
  final double? titleContentSpacing;
  const SectionWidget({
    super.key,
    required this.title,
    this.onViewAll,
    this.content,
    this.padding,
    this.titleWeight,
    this.titleContentSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: AppDimentions.defaultScreenPadding,
              ),
          child: Row(
            children: [
              Expanded(
                child: CustomText.kText(
                  title,
                  size: 18,
                  family: CustomFonts.outfit,
                  weight: titleWeight ?? FontWeight.w800,
                ),
              ),
              if (onViewAll != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onViewAll,
                    child: Row(
                      children: [
                        widthSpace10,
                        CustomText.kText(
                          'View All',
                          size: 13,
                          color: AppColors.primary,
                        ),
                        widthSpace2,
                        Icon(
                          size: 20,
                          Icons.keyboard_arrow_right,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (content != null) ...[
          SizedBox(height: titleContentSpacing ?? 15),
          content!,
        ],
      ],
    );
  }
}
