import '../../../../../utils/app_imports.dart';
import '../home_screen_controller.dart';

class HomeBrokerSellerSlider extends StatelessWidget {
  HomeBrokerSellerSlider({super.key});
  final _con = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    if (_con.agents.isEmpty) return const SizedBox.shrink();

    return SectionWidget(
      title: 'Top Brokers & Sellers',
      content: SizedBox(
        height: 210,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimentions.defaultScreenPadding,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: _con.agents.length,
          separatorBuilder: (_, _) => widthSpace12,
          itemBuilder: (context, index) {
            final item = _con.agents[index];
            return AppContainer(
              width: 165,
              border: Border.all(color: grey.shade200, width: 1.5),
              child: Column(
                children: [
                  AppContainer(
                    height: 70,
                    width: 70,
                    clip: Clip.hardEdge,
                    shape: BoxShape.circle,
                    padding: EdgeInsets.zero,
                    child: item.image == null
                        ? Center(
                            child: Image.asset(
                              Images.userIcon,
                              height: 42,
                              width: 42,
                            ),
                          )
                        : AppNetworkImage(
                            imgUrl: item.image,
                            fit: BoxFit.cover,
                          ),
                  ),

                  const SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          item.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (item.verified)
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
                    item.cities.first,
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
                        '${item.ratingAvg} (${item.ratingCount})',
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
                    onTap: () => Get.toNamed(
                      AppRoutes.brokerSellerDetailsScreen,
                      arguments: {'id': item.key},
                    ),
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
