import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/property_details_screen/widgets/pds_about_widget.dart';

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

    return Obx(
      () => _con.isLoading.value
          ? Scaffold(
              appBar: CustomAppbar(title: 'Details'),
              body: AppLoader.widget(),
            )
          : Scaffold(
              extendBodyBehindAppBar: true,
              appBar: CustomAppbar1(
                error: _con.data.value == null,
                scrollController: sc,
                title: _con.data.value == null
                    ? 'Details'
                    : _con.data.value!.title,
              ),
              body: Obx(
                () => _con.data.value == null
                    ? AppRefreshIndicator(
                        onRefresh: _con.refreshData,
                        child: errorLoadingData(),
                      )
                    : ListView(
                        controller: sc,
                        padding: EdgeInsets.zero,
                        children: [
                          // AppFadeAnimatedSwitcher(
                          //   child: _con.isLoading.value
                          //       ? AppNetworkImage(
                          //           imgUrl: _con.data.value?.mainImage ?? '',
                          //           height: Get.height * .4,
                          //           width: Get.width,
                          //           fit: BoxFit.cover,
                          //         )
                          //       : PdsImageWidget(con: _con),
                          // ),
                          AppNetworkImage(
                            height: Get.height * .4,
                            width: Get.width,
                            imgUrl: _con.data.value?.image ?? '',
                            fit: BoxFit.cover,
                          ),
                          Transform.translate(
                            offset: const Offset(0, -AppDimentions.boxRadiusXL),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimentions.defaultScreenPadding,
                              ),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                    AppDimentions.boxRadiusXL,
                                  ),
                                ),
                              ),
                              child: Builder(
                                builder: (context) {
                                  final blog = _con.data.value!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      heightSpace17,
                                      // Category
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 7,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(
                                            alpha: .15,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          blog.category,
                                          style: theme.textTheme.labelMedium
                                              ?.copyWith(
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
                                                  style: theme
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Published ${timeAgo(blog.publishedAt)}',
                                                  style: theme
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: colors
                                                            .onSurfaceVariant,
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
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                  color:
                                                      colors.onSurfaceVariant,
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
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
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
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                style: theme
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(height: 1.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 400),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
    );
  }
}
