import 'package:bhumi_manthan/models/project_details_model.dart';

import '../../../../utils/app_imports.dart';

class ApsCardWidget extends StatelessWidget {
  final ProjectDetailsModel item;
  final VoidCallback? onFavoriteTap;

  const ApsCardWidget({super.key, required this.item, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      clip: Clip.antiAlias,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Get.toNamed(
          AppRoutes.projectDetailsScreen,
          arguments: {'id': item.id.toString()},
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              imgUrl: item.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.kText(
                    'Starting from',
                    lines: 1,
                    size: 13,
                    color: Colors.grey,
                  ),
                  CustomText.kText(
                    formatPrice(item.startingPrice),
                    size: 18,
                    weight: FontWeight.w600,
                    color: AppColors.primary,
                    family: CustomFonts.outfit,
                  ),

                  CustomText.kText(
                    item.name,
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
                          '${item.location}, ${item.city}',
                          lines: 1,
                          size: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  Divider(height: 20, thickness: 1.3, color: AppColors.hint),

                  // Row(
                  //   children: [
                  //     _detail(
                  //       Icons.king_bed_outlined,
                  //       '${item.configuration} Beds',
                  //     ),
                  //     _detail(
                  //       Icons.bathtub_outlined,
                  //       '${item.} Baths',
                  //     ),
                  //     _detail(Icons.square_foot, '${property.superArea} sqft'),
                  //   ],
                  // ),

                  // const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.builderName} • ${item.configuration}',
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
}
