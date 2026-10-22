import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_about_widget.dart';
import 'package:bhumi_manthan/views/widgets/app_fade_animated_switcher.dart';

import 'blog_details_screen_controller.dart';

class BlogDetailsScreen extends StatefulWidget {
  const BlogDetailsScreen({super.key});

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  final sc = ScrollController();
  final _con = Get.put(BlogDetailsScreenController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SlidingUpPanel(
        minHeight: Get.height * .6 + AppDimentions.boxRadiusXL,
        maxHeight: Get.height * .95,
        parallaxEnabled: true,
        scrollController: sc,
        body: Align(
          alignment: Alignment.topCenter,
          child: Obx(
            () => Skeletonizer(
              enabled: _con.isLoading.value,
              child: AppNetworkImage(
                height: Get.height * .4,
                width: Get.width,
                imgUrl: _con.data.value?.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        color: transparent,
        panelBuilder: () => Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimentions.boxRadiusXL),
            ),
          ),
          child: Obx(
            () => AppFadeAnimatedSwitcher(
              child: _con.isLoading.value
                  ? Column(
                      children: [
                        SizedBox(height: 400, child: AppLoader.widget()),
                      ],
                    )
                  : _con.data.value == null
                  ? AppRefreshIndicator(
                      onRefresh: _con.refreshData,
                      child: errorLoadingData(),
                    )
                  : Builder(
                      builder: (context) {
                        final blog = _con.data.value!;
                        return ListView(
                          controller: sc,
                          padding: EdgeInsets.all(
                            AppDimentions.defaultScreenPadding,
                          ),
                          children: [
                            // Category
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: .15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                blog.category,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Blog title
                            CustomText.kText(
                              blog.title,
                              size: 24,
                              lines: null,
                              weight: FontWeight.w600,
                            ),

                            const SizedBox(height: 18),

                            // Author and reading time
                            Row(
                              children: [
                                AppContainer(
                                  height: 50,
                                  width: 50,
                                  shape: BoxShape.circle,
                                  clip: Clip.hardEdge,
                                  child: Image.asset(Images.userIcon),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        blog.authorName,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Published ${timeAgo(blog.publishedAt)}',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: colors.onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.access_time,
                                  size: 17,
                                  color: colors.onSurfaceVariant,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${blog.readTime} min read',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colors.onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),
                            Divider(color: colors.outlineVariant),
                            const SizedBox(height: 20),

                            // Article content
                            Text(
                              'About This Article',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(height: 14),
                            ExpandableText(text: blog.excerpt),

                            const SizedBox(height: 28),

                            // Article footer
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colors.surfaceContainerHighest
                                    .withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: colors.primary,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Stay informed with Bhoomi Manthan for '
                                      'more real estate news, property guides, '
                                      'and expert insights.',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
