import '../../utils/app_imports.dart';

class AppNetworkImage extends StatelessWidget {
  final String? imgUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const AppNetworkImage({
    super.key,
    this.imgUrl,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('img url: $imgUrl');
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imgUrl ?? '',
      fit: fit,
      placeholder: (context, url) => Image.asset(
        height: height,
        width: width,
        Images.placeholder,
        fit: fit,
      ),
      errorWidget: (context, url, error) => Image.asset(
        height: height,
        width: width,
        Images.placeholder,
        fit: fit,
      ),
    );
  }

  /// Preload the image into Flutter's image cache.
  static Future<void> preload(String? url) async {
    if (url == null || url.isEmpty) return;

    try {
      await precacheImage(CachedNetworkImageProvider(url), Get.context!);
    } catch (e) {
      debugPrint('Image preload failed: $url, error: $e');
    }
  }
}
