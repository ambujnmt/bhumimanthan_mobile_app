import 'package:bhumi_manthan/models/propertiy_details_model.dart';

import '../../../../utils/app_imports.dart';
import 'favorites_screen_controller.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with AutomaticKeepAliveClientMixin {
  final _con = Get.put(FavoritesScreenController());

  final sc = ScrollController();

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppbar(
        scrollController: sc,
        title: 'Favorites',
        showLeading: false,
      ),
      body: Obx(
        () => AppRefreshIndicator(
          onRefresh: _con.refreshData,
          child: _con.isLoading.value
              ? AppLoader.widget()
              : _con.favorites.isEmpty
              ? ListView(
                  children: [
                    SizedBox(height: Get.height * .5, child: _emptyState()),
                  ],
                )
              : ListView.separated(
                  controller: sc,
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  itemCount: _con.favorites.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (context, index) =>
                      _favoriteCard(_con.favorites[index]),
                ),
        ),
      ),
    );
  }

  Widget _favoriteCard(PropertyDetailsModel property) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: AppNetworkImage(
                    imgUrl: property.mainImage,
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText.kText(
                      property.listingType,
                      size: 11,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: IconButton(
                      onPressed: () => _con.removeFavorite(property),
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 21,
                      ),
                      tooltip: 'Remove from favorites',
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.kText(
                    property.title,
                    size: 16,
                    weight: FontWeight.w700,
                    lines: 2,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: CustomText.kText(
                          [property.location, property.city]
                              .whereType<String>()
                              .where((e) => e.isNotEmpty)
                              .join(', '),
                          size: 12,
                          color: Colors.grey.shade600,
                          lines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  CustomText.kText(
                    _formatPrice(property.price),
                    size: 20,
                    weight: FontWeight.w800,
                    color: Colors.blue.shade800,
                  ),
                  const SizedBox(height: 14),
                  Divider(color: Colors.grey.shade200, height: 1),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _propertyFeature(
                        Icons.bed_outlined,
                        property.configuration,
                      ),
                      _propertyFeature(
                        Icons.square_foot,
                        '${property.superArea} sq.ft.',
                      ),
                      _propertyFeature(
                        Icons.verified_outlined,
                        property.status,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _propertyFeature(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 5),
        CustomText.kText(value, size: 11, color: Colors.grey.shade700),
      ],
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 48,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 24),
            CustomText.kText(
              'No Favorites Yet',
              size: 20,
              weight: FontWeight.w700,
            ),
            const SizedBox(height: 10),
            CustomText.kText(
              'Save properties you love by tapping the heart icon. '
              'They will appear here for easy access.',
              size: 13,
              color: Colors.grey.shade600,
              align: TextAlign.center,
              lines: 3,
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(String? price) {
    final amount = double.tryParse(price ?? '');

    if (amount == null) return 'Price on request';

    if (amount >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(2)} Cr';
    }

    if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)} Lac';
    }

    return '₹${amount.toStringAsFixed(0)}';
  }
}
