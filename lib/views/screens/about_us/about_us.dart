import 'package:flutter_html/flutter_html.dart';

import '../../../utils/app_imports.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final isLoading = true.obs;
  final _api = ApiServices();

  final data = Rxn<Map>();

  Future<void> _getData() async {
    final res = await _api.get('/terms-and-conditions');
    if (!res.success) return;
    data.value = res.data['data'];
  }

  Future<void> refreshData() async {
    isLoading(true);
    await _getData();
    isLoading(false);
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Terms & Conditions'),
      body: Obx(
        () => isLoading.value
            ? AppLoader.widget()
            : data.value == null
            ? AppRefreshIndicator(
                onRefresh: refreshData,
                child: errorLoadingData(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(AppDimentions.screenPaddingXS),
                child: Html(data: data.value!['content']),
              ),
      ),
    );
  }
}
