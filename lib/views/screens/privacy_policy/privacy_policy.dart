import '../../../utils/app_imports.dart';
import '../../widgets/html_content.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final isLoading = true.obs;
  final _api = ApiServices();

  final data = Rxn<Map>();

  Future<void> _getData() async {
    final res = await _api.get('/privacy-policy');
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
      appBar: CustomAppbar(title: 'Privacy Policy'),
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
                child: HtmlContent(data: data.value!['content']),
              ),
      ),
    );
  }
}
