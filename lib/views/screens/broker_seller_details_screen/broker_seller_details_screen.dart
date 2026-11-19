import 'package:bhumi_manthan/utils/app_imports.dart';

class BrokerSellerDetailsScreen extends StatefulWidget {
  const BrokerSellerDetailsScreen({super.key});

  @override
  State<BrokerSellerDetailsScreen> createState() =>
      _BrokerSellerDetailsScreenState();
}

class _BrokerSellerDetailsScreenState extends State<BrokerSellerDetailsScreen> {
  final sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: ''),
      body: ListView(
        controller: sc,
        children: [
          _profileHeader(),
          _experienceLocation(),
          _listedProperties(),
          _ratingSummary(),
          _reviews(),
          heightSpace100,
        ],
      ),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        heightSpace10,
        const CircleAvatar(
          radius: 48,
          backgroundImage: NetworkImage('https://i.pravatar.cc/200?img=12'),
        ),
        const SizedBox(height: 12),
        CustomText.kText('Rahul Sharma', size: 21, weight: FontWeight.w600),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xffE8F1FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Broker',
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
            CustomText.kText('Dwarka, Delhi', color: Colors.blueGrey),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(AppDimentions.defaultScreenPadding),
          child: CustomButton(
            width: 230,
            text: '9876567890',
            leftIcon: Icons.call,
          ),
        ),
      ],
    );
  }

  Widget _experienceLocation() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Expanded(
            child: _infoItem(
              Icons.star,
              '4.8',
              '124 Reviews',
              iconColor: orange,
            ),
          ),
          Container(height: 45, width: 1, color: Colors.grey.shade200),
          Expanded(
            child: _infoItem(Icons.work_outline, 'Experience', '8 Years'),
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

  Widget _listedProperties() {
    return _section(
      'Listed Properties',
      Column(
        children: [
          _propertyItem(
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400',
            'Luxury Independent Villa',
            'Dwarka, New Delhi',
            '₹2.5 Cr',
          ),
          const Divider(height: 22),
          _propertyItem(
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=400',
            'Modern 3 BHK Apartment',
            'Rohini, Delhi',
            '₹85 Lac',
          ),
          const Divider(height: 22),
          _propertyItem(
            'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?w=400',
            'Premium Residential House',
            'Janakpuri, Delhi',
            '₹1.8 Cr',
          ),
        ],
      ),
    );
  }

  Widget _propertyItem(
    String image,
    String name,
    String location,
    String price,
  ) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(image, height: 75, width: 90, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                location,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 5),
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ratingSummary() {
    return _section(
      'Rating Summary',
      Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Text(
                    '4.8',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.star, color: Colors.orange),
                  const Text('124 Reviews', style: TextStyle(fontSize: 11)),
                ],
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  children: [
                    _ratingBar(5, 85),
                    _ratingBar(4, 25),
                    _ratingBar(3, 8),
                    _ratingBar(2, 4),
                    _ratingBar(1, 2),
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
    return _section(
      'Customer Reviews',
      Column(
        children: [
          _reviewItem(
            'Amit Verma',
            'https://i.pravatar.cc/100?img=11',
            5,
            'Very professional and helpful. Helped me find the perfect property within my budget.',
            '2 days ago',
          ),
          const Divider(height: 25),
          _reviewItem(
            'Priya Singh',
            'https://i.pravatar.cc/100?img=47',
            4,
            'Good experience. The entire property visit and documentation process was smooth.',
            '1 week ago',
          ),
          const Divider(height: 25),
          _reviewItem(
            'Rohit Mehta',
            'https://i.pravatar.cc/100?img=13',
            5,
            'Excellent service and quick response. Highly recommended.',
            '2 weeks ago',
          ),
        ],
      ),
    );
  }

  Widget _reviewItem(
    String name,
    String image,
    int rating,
    String review,
    String date,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 19, backgroundImage: NetworkImage(image)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              date,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: List.generate(
            5,
            (index) => Icon(
              Icons.star,
              size: 15,
              color: index < rating ? Colors.orange : Colors.grey.shade300,
            ),
          ),
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
