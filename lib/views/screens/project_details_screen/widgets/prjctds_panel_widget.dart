import 'package:bhumi_manthan/views/screens/project_details_screen/project_details_screen_controller.dart';
import 'package:bhumi_manthan/views/widgets/app_fade_animated_switcher.dart';

import '../../../../models/project_details_model.dart';
import '../../../../utils/app_imports.dart';

class PrjctdsPanelWidget extends StatefulWidget {
  final ScrollController? sc;

  const PrjctdsPanelWidget({super.key, this.sc});

  @override
  State<PrjctdsPanelWidget> createState() => _PrjctdsPanelWidgetState();
}

class _PrjctdsPanelWidgetState extends State<PrjctdsPanelWidget> {
  final _con = Get.find<ProjectDetailsScreenController>();

  String getPrice(ProjectDetailsModel project) {
    final price = double.tryParse(project.startingPrice) ?? 0;

    if (price >= 10000000) {
      return '₹${(price / 10000000).toStringAsFixed(2)} Cr';
    }

    if (price >= 100000) {
      return '₹${(price / 100000).toStringAsFixed(2)} Lac';
    }

    return '₹${price.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
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
                  children: [SizedBox(height: 400, child: AppLoader.widget())],
                )
              : _con.data.value == null
              ? AppRefreshIndicator(
                  onRefresh: _con.refreshData,
                  child: errorLoadingData(),
                )
              : Builder(
                  builder: (context) {
                    ProjectDetailsModel project = _con.data.value!;
                    String formattedPrice = getPrice(project);
                    return ListView(
                      controller: widget.sc,
                      padding: EdgeInsets.all(
                        AppDimentions.defaultScreenPadding,
                      ),
                      children: [
                        CustomText.kText(
                          project.name,
                          size: 20,
                          weight: FontWeight.w600,
                          family: CustomFonts.outfit,
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: AppColors.subtitle,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: CustomText.kText(
                                '${project.location}, ${project.city}, ${project.state}',
                                size: 14,
                                color: AppColors.subtitle,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),
                        AppContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.kText(
                                'Starting Price',
                                size: 12,
                                color: AppColors.subtitle,
                              ),
                              heightSpace4,
                              CustomText.kText(
                                project.priceLabel?.isNotEmpty == true
                                    ? project.priceLabel!
                                    : formattedPrice,
                                size: 25,
                                family: CustomFonts.outfit,
                                weight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                              heightSpace8,
                              CustomText.kText(
                                project.configuration,
                                weight: FontWeight.w600,
                                size: 14,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        _sectionTitle(context, 'Project Overview'),
                        const SizedBox(height: 16),

                        _infoTile(
                          context,
                          Icons.business_outlined,
                          'Developer',
                          project.builderName,
                        ),
                        _infoTile(
                          context,
                          Icons.location_city_outlined,
                          'Project Location',
                          '${project.location}, ${project.city}',
                        ),
                        _infoTile(
                          context,
                          Icons.apartment_outlined,
                          'Configuration',
                          project.configuration,
                        ),
                        _infoTile(
                          context,
                          Icons.flag_outlined,
                          'Launch Status',
                          project.launchStatus,
                        ),

                        if (project.description?.isNotEmpty == true) ...[
                          const SizedBox(height: 24),
                          _sectionTitle(context, 'About This Project'),
                          const SizedBox(height: 12),
                          Text(
                            project.description!,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],

                        if (project.galleryImages.isNotEmpty) ...[
                          const SizedBox(height: 28),
                          _sectionTitle(context, 'Project Gallery'),
                          const SizedBox(height: 14),
                          SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: project.galleryImages.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    project.galleryImages[index],
                                    width: 210,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Container(
                                      width: 210,
                                      color: colors.surfaceContainerHighest,
                                      child: const Icon(
                                        Icons.broken_image_outlined,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        const SizedBox(height: 28),

                        _sectionTitle(context, 'Project Details'),
                        const SizedBox(height: 14),

                        _detailRow(context, 'Project ID', '${project.id}'),
                        _detailRow(context, 'Builder', project.builderName),
                        _detailRow(context, 'City', project.city),
                        _detailRow(context, 'State', project.state),
                        _detailRow(
                          context,
                          'Coordinates',
                          '${project.latitude}, ${project.longitude}',
                        ),
                        heightSpace100,
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}

Widget _sectionTitle(BuildContext context, String title) {
  return Text(
    title,
    style: Theme.of(
      context,
    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
  );
}

Widget _infoTile(
  BuildContext context,
  IconData icon,
  String title,
  String value,
) {
  final colors = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value.isEmpty ? 'Not available' : value,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _detailRow(BuildContext context, String label, String value) {
  final colors = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(label, style: TextStyle(color: colors.onSurfaceVariant)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value.isEmpty ? 'Not available' : value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
