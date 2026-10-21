import 'package:dots_indicator/dots_indicator.dart';

import '../../../../../utils/app_imports.dart';
import '../home_screen_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final _con = Get.find<HomeScreenController>();
  final _currentIndex = 0.obs;

  Worker? _bannerWorker;
  final Set<String> _preloadedImages = {};

  @override
  void initState() {
    super.initState();

    _bannerWorker = ever(_con.banners, (_) {
      _preloadBanners();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preloadBanners();
    });
  }

  Future<void> _preloadBanners() async {
    if (!mounted) return;

    final urls = _con.banners
        .map((banner) => banner.image)
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
  void dispose() {
    _bannerWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _con.banners.isEmpty
          ? SizedBox.shrink()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselSlider.builder(
                  itemCount: _con.banners.length,
                  options: CarouselOptions(
                    aspectRatio: 16 / 7,
                    viewportFraction: 1,
                    autoPlay: _con.banners.length > 1,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 600,
                    ),
                    autoPlayCurve: Curves.easeInOut,
                    enableInfiniteScroll: _con.banners.length > 1,
                    onPageChanged: (index, reason) => _currentIndex(index),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final banner = _con.banners[index];

                    return AppContainer(
                      clip: Clip.hardEdge,
                      padding: EdgeInsets.zero,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: AppDimentions.defaultScreenPadding,
                      ),
                      child: AppNetworkImage(
                        imgUrl: banner.image,
                        // imgUrl:
                        //     'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=900&q=80',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                heightSpace7,
                Obx(
                  () => DotsIndicator(
                    dotsCount: _con.banners.length,
                    position: _currentIndex.value.toDouble(),
                    decorator: DotsDecorator(
                      color: AppColors.secondary,
                      activeColor: AppColors.primary,
                    ),
                  ),
                ),
                heightSpace10,
              ],
            ),
    );
  }
}
