import '../../utils/app_imports.dart';
import 'app_dropdown.dart';

class AppDropdownField extends StatelessWidget {
  final List<CustomDropdownItem> items;
  final Function(CustomDropdownItem? item)? onSelect;
  final CustomDropdownItem? selected;
  final String? label;
  final String? hintText;
  final double? bottomPadding;
  // final Color? fillColor;
  final bool? isRequired;
  final RxString errorText;

  AppDropdownField({
    super.key,
    this.items = const [],
    this.onSelect,
    this.selected,
    this.label,
    this.hintText,
    this.bottomPadding,
    // this.fillColor,
    this.isRequired,
    RxString? errorText,
  }) : errorText = errorText ?? ''.obs;

  @override
  Widget build(BuildContext context) {
    return AppTextfield(
      readOnly: true,
      textColor: black,
      isRequired: isRequired ?? false,
      bottomPad: bottomPadding,
      label: label ?? 'Report Type',
      hintText: hintText ?? 'Inspection type',
      // fillColor: fillColor,
      errorText: errorText,
      controller: TextEditingController(text: selected?.title),
      actions: [Icon(Icons.keyboard_arrow_down, size: 26, color: grey[600])],
      onTap: () async {
        final item = await showCustomDropdown(
          items: items,
          title: hintText,
          selected: selected,
        );
        onSelect?.call(item);
      },
    );
  }
}
