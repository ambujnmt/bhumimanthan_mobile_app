import 'package:bhumi_manthan/models/fav_property_model.dart';

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
              : _con.items.isEmpty
              ? NoDataAvailable(
                  title: 'No Favorites Yet',
                  message:
                      'Save properties you love by tapping the heart icon. '
                      'They will appear here for easy access.',
                )
              : ListView.separated(
                  controller: sc,
                  padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
                  itemCount: _con.items.length,
                  separatorBuilder: (_, _) => heightSpace10,
                  itemBuilder: (context, index) =>
                      _favoriteCard(_con.items[index]),
                ),
        ),
      ),
    );
  }

  Widget _favoriteCard(FavPropertyModel property) {
    return InkWell(
      onTap: () => Get.toNamed(
        AppRoutes.propertyDetailsScreen,
        arguments: {'id': property.id},
      ),
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
                  child: CustomCircleIconButton(
                    size: 32,
                    icon: Icon(Icons.delete_outline, color: red),
                    onTap: () => _con.removeFavorite(property),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimentions.screenPaddingS),
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
                  heightSpace10,
                  CustomText.kText(
                    formatPrice(property.price),
                    size: 20,
                    weight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                  heightSpace10,
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
}
