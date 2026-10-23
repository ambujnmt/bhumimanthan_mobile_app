import '../../../utils/app_imports.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  final imageUrl = Get.arguments as String?;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SizedBox.expand(
        child: InteractiveViewer(
          minScale: 1.0,
          maxScale: 4.0,
          panEnabled: true,
          scaleEnabled: true,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: AppNetworkImage(imgUrl: imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
