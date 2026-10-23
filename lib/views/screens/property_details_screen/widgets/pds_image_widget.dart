import 'package:bhumi_manthan/views/screens/property_details_screen/property_details_screen_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../../utils/app_imports.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PdsImageWidget extends StatefulWidget {
  const PdsImageWidget({super.key, required this.con});
  final PropertyDetailsScreenController con;

  @override
  State<PdsImageWidget> createState() => _PdsImageWidgetState();
}

class _PdsImageWidgetState extends State<PdsImageWidget> {
  final _currentIndex = 0.obs;

  final Set<String> _preloadedImages = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadBanners();
    });
  }

  Future<void> _preloadBanners() async {
    if (!mounted) return;

    final urls = widget.con.data.value!.galleryImages
        .map((img) => img)
        .where((url) => url.isNotEmpty && !_preloadedImages.contains(url))
        .toSet();

    await Future.wait(
      urls.map((url) async {
        await AppNetworkImage.preload(url);
        if (mounted) {
          _preloadedImages.add(url);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.con.data.value!.galleryImages.length,
          options: CarouselOptions(
            viewportFraction: 1,
            height: Get.height * .4,
            autoPlay: widget.con.data.value!.galleryImages.length > 1,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 600),
            autoPlayCurve: Curves.easeInOut,
            enableInfiniteScroll:
                widget.con.data.value!.galleryImages.length > 1,
            onPageChanged: (index, reason) => _currentIndex(index),
          ),
          itemBuilder: (context, index, realIndex) {
            final imgUrl = widget.con.data.value!.galleryImages[index];
            return InkWell(
              onTap: () =>
                  Get.toNamed(AppRoutes.imageViewScreen, arguments: imgUrl),
              child: AppNetworkImage(
                imgUrl: imgUrl,
                // imgUrl:
                //     'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=900&q=80',
                fit: BoxFit.cover,
                width: Get.width,
              ),
            );
          },
        ),
        Positioned(
          bottom: AppDimentions.boxRadiusXL + 10,
          left: 0,
          right: 0,
          child: Obx(
            () => DotsIndicator(
              dotsCount: widget.con.data.value!.galleryImages.length,
              position: _currentIndex.value.toDouble(),

              decorator: DotsDecorator(
                color: AppColors.secondary,
                activeColor: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
