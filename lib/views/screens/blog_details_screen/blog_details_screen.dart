import 'package:bhumi_manthan/utils/app_imports.dart';

import 'blog_details_screen_controller.dart';

class BlogDetailsScreen extends StatefulWidget {
  const BlogDetailsScreen({super.key});

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  final _con = Get.put(BlogDetailsScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar(title: 'Blog Details'));
  }
}
