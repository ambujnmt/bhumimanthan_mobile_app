import '../../../../utils/app_imports.dart';

class PdsAboutWidget extends StatelessWidget {
  const PdsAboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'About Property',
      padding: EdgeInsets.zero,
      content: Column(
        children: [
          ExpandableText(
            text:
                'Experience elevated living at DLF The Arbour, a spacious four-bedroom residence designed around light, privacy and garden views. The apartment features expansive living spaces, floor-to-ceiling glazing, premium finishes and generous balconies. Located just off Golf Course Extension Road, it offers easy access to leading schools, hospitals, business districts and everyday conveniences.',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;
  bool isOverflowing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final textPainter = TextPainter(
              text: TextSpan(
                text: widget.text,
                style: widget.style ?? CustomText.kTextStyle(),
              ),
              maxLines: widget.maxLines,
              textDirection: Directionality.of(context),
            )..layout(maxWidth: constraints.maxWidth);

            isOverflowing = textPainter.didExceedMaxLines;

            return CustomText.kText(
              widget.text,
              size: 16,
              color: AppColors.subtitle,
              lines: isExpanded ? null : widget.maxLines,
              textOverFlow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: widget.style,
            );
          },
        ),
        if (isOverflowing)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  CustomText.kText(
                    isExpanded ? 'Show less' : 'Show more',
                    color: AppColors.primary,
                    size: 14,
                    weight: FontWeight.bold,
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
