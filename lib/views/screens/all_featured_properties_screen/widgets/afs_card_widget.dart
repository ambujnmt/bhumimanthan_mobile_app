import '../../../../models/featured_property_model.dart';
import '../../../../utils/app_imports.dart';

class FeaturedPropertyCard extends StatelessWidget {
  final String label;
  final FeaturedProperty property;
  final VoidCallback? onFavoriteTap;

  const FeaturedPropertyCard({
    super.key,
    required this.label,
    required this.property,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      clip: Clip.antiAlias,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Get.toNamed(
          AppRoutes.propertyDetailsScreen,
          arguments: {'id': property.id.toString()},
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppNetworkImage(
                  imgUrl: property.mainImage,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  top: 12,
                  left: 12,
                  child: Wrap(
                    spacing: 6,
                    children: [
                      // if (property.isFeatured)
                      _badge(label, Colors.orange.shade700),
                      // if (property.isLuxury) _badge('LUXURY', Colors.black87),
                    ],
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onFavoriteTap,
                      child: const Padding(
                        padding: EdgeInsets.all(9),
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      property.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.kText(
                    formatPrice(property.price),
                    size: 22,
                    weight: FontWeight.w600,
                    color: AppColors.primary,
                    family: CustomFonts.outfit,
                  ),

                  CustomText.kText(
                    property.title,
                    lines: 1,
                    size: 16,
                    weight: FontWeight.w600,
                    family: CustomFonts.outfit,
                  ),

                  heightSpace6,

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: CustomText.kText(
                          '${property.location}, ${property.city}',
                          lines: 1,
                          size: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  Divider(height: 20, thickness: 1.3, color: AppColors.hint),

                  Row(
                    children: [
                      _detail(
                        Icons.king_bed_outlined,
                        '${property.bedrooms} Beds',
                      ),
                      _detail(
                        Icons.bathtub_outlined,
                        '${property.bathrooms} Baths',
                      ),
                      _detail(Icons.square_foot, '${property.superArea} sqft'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${property.furnishing} • ${property.configuration}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.black54,
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

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: CustomText.kText(
        text,
        size: 10,
        color: Colors.white,
        weight: FontWeight.w600,
        family: CustomFonts.outfit,
      ),
    );
  }

  Widget _detail(IconData icon, String text) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 17, color: Colors.grey.shade700),
          const SizedBox(width: 5),
          Flexible(child: CustomText.kText(text, lines: 1, size: 12)),
        ],
      ),
    );
  }
}
