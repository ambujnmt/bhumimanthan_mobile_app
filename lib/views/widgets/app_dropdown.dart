import '../../utils/app_imports.dart';

Future<CustomDropdownItem?> showCustomDropdown({
  String? title,
  required List<CustomDropdownItem> items,
  CustomDropdownItem? selected,
  Color? backgroundColor,
}) async {
  double heightFactor = 0.3;
  if (items.length > 4 && items.length <= 7) {
    heightFactor = 0.4;
  } else if (items.length > 7 && items.length <= 10) {
    heightFactor = 0.5;
  } else if (items.length > 10) {
    heightFactor = 0.85;
  }

  return await showModalBottomSheet<CustomDropdownItem>(
    context: Get.context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.3),
    builder: (ctx) {
      final sheetContent = Container(
        height: Get.height * heightFactor,
        decoration: BoxDecoration(
          color: backgroundColor ?? white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          border: const Border(
            top: BorderSide(color: Colors.white24, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),

                CustomText.kText(
                  title ?? 'Select an option',
                  size: 18,
                  weight: FontWeight.bold,
                  color: black,
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (_, _) => Divider(
                      color: grey[400]!.withValues(alpha: 0.2),
                      height: 0,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final label = item.title;

                      final isSelected = item.value == selected?.value;

                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Navigator.pop(ctx, item),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? grey.withValues(alpha: 0.2)
                                : transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomText.kText(
                                  label,
                                  size: 16,
                                  color: black.withValues(alpha: 0.9),
                                  weight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  lines: 1,
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.done, color: black, size: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: sheetContent,
      );
    },
  );
}

class CustomDropdownItem<T> {
  final T value;
  final String title;
  CustomDropdownItem({required this.value, required this.title});
}
