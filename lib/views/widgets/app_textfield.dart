import '../../utils/app_imports.dart';

class AppTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool useObscure;
  final RxString? errorText;
  final bool isRequired;
  final bool readOnly;
  final FocusNode? node;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final void Function(String input)? onChanged;
  final TextCapitalization? capitalization;
  final double? bottomPad;
  final int? minLines;
  final int? maxLines;
  final List<Widget>? actions;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final double? radiusVal;

  AppTextfield({
    super.key,
    this.controller,
    this.prefixIcon,
    this.hintText,
    this.bottomPad,
    this.isRequired = false,
    this.readOnly = false,
    this.label,
    this.useObscure = false,
    this.node,
    this.capitalization,
    this.inputType,
    this.onChanged,
    RxString? errorText,
    this.inputAction,
    this.minLines,
    this.maxLines,
    this.actions,
    this.onTap,
    this.radiusVal,
  }) : errorText = errorText ?? ''.obs;

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  final obscureText = false.obs;

  late final _radius = BorderRadius.circular(
    widget.radiusVal ?? AppDimentions.boxRadiusL,
  );

  late final _border = OutlineInputBorder(
    borderRadius: _radius,
    borderSide: BorderSide(color: fromHex('#E5E5E5'), width: 1.2),
  );
  late final _enabledBorder = OutlineInputBorder(
    borderRadius: _radius,
    borderSide: BorderSide(color: fromHex('#E5E5E5'), width: 1.2),
  );
  late final _focusedBorder = OutlineInputBorder(
    borderRadius: _radius,
    borderSide: BorderSide(color: AppColors.primary, width: 1.2),
  );

  @override
  void initState() {
    super.initState();
    if (widget.useObscure) {
      obscureText(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Row(
            children: [
              widthSpace15,
              Flexible(
                child: CustomText.kText(
                  widget.label!,
                  align: TextAlign.left,
                  size: 16,
                  lines: 1,
                ),
              ),
              if (widget.isRequired) CustomText.kText('*'),
            ],
          ),
          heightSpace7,
        ],
        Obx(
          () => TextField(
            onTap: widget.onTap,
            focusNode: widget.node,
            controller: widget.controller,
            keyboardType: widget.inputType,
            readOnly: widget.readOnly,
            textInputAction: widget.inputAction ?? TextInputAction.next,
            obscureText: obscureText.value,
            textCapitalization:
                widget.capitalization ??
                (widget.inputType == TextInputType.name
                    ? TextCapitalization.sentences
                    : TextCapitalization.none),
            minLines: widget.useObscure ? 1 : widget.minLines ?? 1,
            maxLines: widget.useObscure ? 1 : widget.maxLines,
            onChanged:
                widget.onChanged ??
                (value) {
                  widget.errorText!('');
                },
            style: widget.readOnly
                ? CustomText.kTextStyle(color: grey)
                : CustomText.kTextStyle(),
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              border: _border,
              enabledBorder: _enabledBorder,
              focusedBorder: widget.readOnly ? _border : _focusedBorder,
              disabledBorder: _border,
              errorBorder: _border.copyWith(borderSide: BorderSide(color: red)),
              errorText: widget.errorText!.value.isEmpty
                  ? null
                  : widget.errorText!.value.tr,
              errorStyle: CustomText.kTextStyle(color: red, size: 14),
              hint: Row(
                children: [
                  Expanded(
                    child: CustomText.kText(
                      widget.hintText ?? '',
                      color: grey,
                      weight: FontWeight.w400,
                      lines: 1,
                    ),
                  ),
                  if (widget.isRequired && widget.label == null)
                    CustomText.kText(' *'),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              suffixIcon: widget.actions != null || widget.useObscure
                  ? IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...?widget.actions,
                          if (widget.useObscure)
                            FittedBox(
                              child: InkWell(
                                onTap: obscureText.toggle,
                                child: Icon(
                                  !obscureText.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: grey[600],
                                  size: 24,
                                ),
                              ),
                            ),
                          widthSpace15,
                        ],
                      ),
                    )
                  : null,
              suffixIconConstraints: BoxConstraints(
                maxHeight: 45,
                maxWidth: 100,
              ),
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Expanded(child: widget.prefixIcon!)],
                    ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 45,
                maxWidth: 45,
                minHeight: 40,
                maxHeight: 40,
              ),
            ),
          ),
        ),
        // Obx(
        //   () => errorText!.value.isEmpty
        //       ? SizedBox()
        //       : CustomText.kText(errorText!.value, color: red),
        // ),
        SizedBox(height: widget.bottomPad ?? 17),
      ],
    );
  }
}
