import 'package:bhumi_manthan/models/search_property_model.dart';
import 'package:bhumi_manthan/utils/app_imports.dart';

class SrsItemsWidget extends StatelessWidget {
  final SearchPropertyModel item;
  const SrsItemsWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.propertyDetailsScreen,
        arguments: {'id': item.id},
      ),
      child: AppContainer(
        borderColor: grey.shade200,
        padding: EdgeInsets.zero,
        clip: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large property image
            Stack(
              children: [
                AppNetworkImage(
                  imgUrl: item.mainImage,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: AppContainer(
                    color: black.withValues(alpha: .55),
                    borderColor: grey.shade400,
                    borderRadius: AppDimentions.boxRadiusXXS,
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimentions.screenPaddingXXS,
                      horizontal: AppDimentions.screenPaddingXS,
                    ),

                    child: CustomText.kText(
                      '${formatNumber(item.superArea)} Sq.Ft.',
                      weight: FontWeight.w600,
                      size: 12,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),

            // Property details
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimentions.screenPaddingS,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.kText(
                    item.title,
                    lines: 2,
                    size: 18,
                    family: CustomFonts.outfit,
                  ),

                  heightSpace8,

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          item.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Divider(color: Colors.grey.shade200, height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.kText(
                              'Price',
                              size: 12,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(height: 4),
                            CustomText.kText(
                              formatPrice(item.price),
                              size: 18,
                              family: CustomFonts.outfit,
                              color: AppColors.primary,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Listed by',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.ownership ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  heightSpace2,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
