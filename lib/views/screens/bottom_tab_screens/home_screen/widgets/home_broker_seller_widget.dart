import '../../../../../utils/app_imports.dart';
import '../../../broker_seller_details_screen/broker_seller_details_screen.dart';

class HomeBrokerSellerSlider extends StatelessWidget {
  final String title;
  final List<BrokerSeller> items;
  final Function(BrokerSeller)? onTap;
  final VoidCallback? onSeeAll;

  const HomeBrokerSellerSlider({
    super.key,
    this.title = 'Top Brokers & Sellers',
    required this.items,
    this.onTap,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return SectionWidget(
      title: title,
      content: SizedBox(
        height: 210,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimentions.defaultScreenPadding,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (_, _) => widthSpace12,
          itemBuilder: (context, index) {
            final item = items[index];
            return AppContainer(
              width: 165,
              border: Border.all(color: grey.shade200, width: 1.5),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: item.image.isNotEmpty
                        ? NetworkImage(item.image)
                        : null,
                    child: item.image.isEmpty
                        ? const Icon(Icons.person, size: 35)
                        : null,
                  ),
                  const SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (item.isVerified)
                        const Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 15,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, size: 15, color: Colors.orange),
                      const SizedBox(width: 3),
                      Text(
                        '${item.rating} (${item.reviews})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  CustomButton(
                    text: 'View Details',
                    height: 32,
                    textSize: 15,
                    color: AppColors.secondary,
                    onTap: () => Get.to(() => BrokerSellerDetailsScreen()),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BrokerSeller {
  final String name;
  final String image;
  final String location;
  final double rating;
  final int reviews;
  final bool isVerified;

  const BrokerSeller({
    required this.name,
    required this.image,
    required this.location,
    required this.rating,
    required this.reviews,
    this.isVerified = false,
  });
}
