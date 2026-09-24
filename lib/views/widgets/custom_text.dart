import '../../utils/app_imports.dart';

class CustomText {
  // static const font = 'Manrope';

  static Text kText(
    final String hint, {
    final double? size,
    final FontWeight? weight,
    final Color? color,
    final TextAlign? align,
    final TextOverflow? textOverFlow,
    final int? lines = 2,
    final bool italic = false,
    final TextStyle? style,
    final String? family,
  }) {
    return Text(
      hint,
      style:
          style ??
          TextStyle(
            fontFamily: family,
            fontSize: size ?? 15,
            fontWeight: weight ?? FontWeight.w500,
            color: color ?? black,
            fontStyle: italic ? FontStyle.italic : null,
          ),
      textAlign: align,
      overflow: lines == null ? null : textOverFlow ?? TextOverflow.ellipsis,
      maxLines: lines,
    );
  }

  static TextStyle kTextStyle({
    final double? size,
    final FontWeight? weight,
    final Color? color,
    final String? family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
      fontWeight: weight ?? FontWeight.w500,
      color: color ?? black,
    );
  }
}

class CustomFonts {
  static final String manrope = 'Manrope';
  static final String outfit = 'Outfit';
}
