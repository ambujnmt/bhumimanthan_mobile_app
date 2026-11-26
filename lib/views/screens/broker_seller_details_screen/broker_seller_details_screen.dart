import 'package:bhumi_manthan/utils/app_imports.dart';

import '../../../models/agent_data_model.dart';

class BrokerSellerDetailsScreen extends StatefulWidget {
  const BrokerSellerDetailsScreen({super.key});

  @override
  State<BrokerSellerDetailsScreen> createState() =>
      _BrokerSellerDetailsScreenState();
}

class _BrokerSellerDetailsScreenState extends State<BrokerSellerDetailsScreen> {
  final sc = ScrollController();

  String? agentKey;

  final isLoading = false.obs;

  final data = Rxn<AgentDataModel>();

  Future<void> _getData() async {
    final res = await ApiServices().get('/agents/$agentKey');
    if (!res.success) return;
    data.value = JsonParser.tryParse(
      res.data['data'],
      (json) => AgentDataModel.fromJson(json),
    );
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void initState() {
    super.initState();
    agentKey = Get.arguments?['id']?.toString();
    if (agentKey == null) return;
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: ''),
      body: Obx(() {
        if (isLoading.value) return AppLoader.widget();
        if (data.value == null) return ApiErrorWidget();
        return ListView(
          controller: sc,
          children: [
            _profileHeader(),
            _experienceRatingAverage(),
            // _listedProperties(),
            _ratingSummary(),
            _reviews(),
            heightSpace100,
          ],
        );
      }),
    );
  }

  Widget _profileHeader() {
    final agent = data.value!.agent!;
    return Column(
      children: [
        heightSpace10,
        AppContainer(
          height: 95,
          width: 95,
          shape: BoxShape.circle,
          clip: Clip.hardEdge,
          padding: EdgeInsets.zero,
          child: AppNetworkImage(imgUrl: agent.image, fit: BoxFit.cover),
        ),
        const SizedBox(height: 12),
        CustomText.kText(agent.name ?? '', size: 21, weight: FontWeight.w600),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xffE8F1FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            agent.type ?? 'Unknown',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined, color: Colors.blueGrey, size: 18),
            SizedBox(width: 4),
            CustomText.kText(agent.cities.first, color: Colors.blueGrey),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(AppDimentions.defaultScreenPadding),
          child: CustomButton(
            width: 230,
            text: 'View Number',
            onTap: () =>
                Get.toNamed(AppRoutes.submitUserDetails, arguments: {'id': 1}),
          ),
        ),
      ],
    );
  }

  Widget _experienceRatingAverage() {
    final agent = data.value!.agent!;
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Expanded(
            child: _infoItem(
              Icons.star,
              agent.ratingAvg.toString(),
              '${agent.ratingCount} Reviews',
              iconColor: orange,
            ),
          ),
          Container(height: 45, width: 1, color: Colors.grey.shade200),
          Expanded(
            child: _infoItem(
              Icons.work_outline,
              'Experience',
              agent.experience ?? 'Unknown',
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(
    IconData icon,
    String title,
    String value, {
    Color? iconColor,
  }) {
    return Column(
      children: [
        Icon(icon, color: iconColor ?? Colors.blueGrey, size: 23),
        const SizedBox(height: 7),
        Text(title, style: TextStyle(fontSize: 13, color: grey.shade700)),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ],
    );
  }

  // Widget _listedProperties() {
  //   final items = data.value!.properties;
  //   return SectionWidget(
  //     title: 'Listed Properties (${items.length})',
  //     content: Padding(
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: AppDimentions.defaultScreenPadding,
  //       ),
  //       child: Column(
  //         spacing: 10,
  //         children: items
  //             .take(5)
  //             .map(
  //               (i) => _propertyItem(
  //                 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400',
  //                 'Luxury Independent Villa',
  //                 'Dwarka, New Delhi',
  //                 '₹2.5 Cr',
  //               ),
  //             )
  //             .toList(),
  //       ),
  //     ),
  //   );
  // }

  // Widget _propertyItem(
  //   String image,
  //   String name,
  //   String location,
  //   String price,
  // ) {
  //   return Row(
  //     children: [
  //       ClipRRect(
  //         borderRadius: BorderRadius.circular(10),
  //         child: AppNetworkImage(
  //           imgUrl: image,
  //           height: 75,
  //           width: 90,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       const SizedBox(width: 12),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               name,
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 13,
  //               ),
  //             ),
  //             const SizedBox(height: 5),
  //             Text(
  //               location,
  //               style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
  //             ),
  //             const SizedBox(height: 5),
  //             Text(
  //               price,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 13,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _ratingSummary() {
    final agent = data.value!.agent;
    final rating = data.value!.ratingBreakdown;
    return _section(
      'Rating Summary',
      Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    '${agent?.ratingAvg ?? '0'}',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.star, color: Colors.orange),
                  Text(
                    '${agent?.ratingCount} Reviews',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  children: [
                    _ratingBar(5, rating?.five ?? 0),
                    _ratingBar(4, rating?.four ?? 0),
                    _ratingBar(3, rating?.three ?? 0),
                    _ratingBar(2, rating?.two ?? 0),
                    _ratingBar(1, rating?.one ?? 0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(int star, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text('$star'),
          const Icon(Icons.star, color: Colors.orange, size: 13),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: count / 124,
                minHeight: 7,
                backgroundColor: Colors.grey.shade200,
                color: Colors.orange,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 25,
            child: Text('$count', style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _reviews() {
    final reviews = data.value!.reviews;
    return _section(
      'Customer Reviews',
      Column(
        spacing: 10,
        children: reviews
            .take(30)
            .map(
              (r) => _reviewItem(
                r.userName ?? 'Unavailable',
                r.rating ?? 0,
                r.review ?? '',
                formatDateTime(r.updatedAt.toString()),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _reviewItem(String name, int rating, String review, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 22, child: Icon(Icons.person_outline)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  heightSpace5,
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        size: 15,
                        color: index < rating
                            ? Colors.orange
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              date,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
            ),
          ],
        ),

        const SizedBox(height: 7),
        Text(
          review,
          style: TextStyle(
            fontSize: 12,
            height: 1.5,
            color: Colors.grey.shade700,
          ),
        ),
        heightSpace7,
        Divider(color: grey.shade300, thickness: 1.2, height: 0),
      ],
    );
  }

  Widget _section(String title, Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(18),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
