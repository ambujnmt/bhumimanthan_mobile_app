import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:intl/intl.dart';

import '../../../models/compare_property_model.dart';
import 'properties_compare_screen_controller.dart';

class PropertiesCompareScreen extends StatefulWidget {
  const PropertiesCompareScreen({super.key});

  @override
  State<PropertiesCompareScreen> createState() =>
      _PropertiesCompareScreenState();
}

class _PropertiesCompareScreenState extends State<PropertiesCompareScreen> {
  final _con = Get.put(PropertiesCompareScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Compare Properties'),
      body: Obx(
        () => _con.isLoading.value
            ? AppLoader.widget()
            : _con.items.isEmpty
            ? AppRefreshIndicator(
                onRefresh: _con.refreshData,
                child: errorLoadingData(),
              )
            : PropertyCompareWidget(properties: _con.items),
      ),
    );
  }
}

// Import your CompareProperty model here.

class PropertyCompareWidget extends StatelessWidget {
  final List<CompareProperty> properties;

  const PropertyCompareWidget({super.key, required this.properties});

  String formatPrice(num price) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    ).format(price);
  }

  String formatNumber(num? value) {
    if (value == null) return '—';
    return NumberFormat('#,##,##0.##', 'en_IN').format(value);
  }

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const Center(
        child: Text('No properties available for comparison.'),
      );
    }

    final rows = <_ComparisonRow>[
      _ComparisonRow('Price', (p) => formatPrice(p.price)),
      _ComparisonRow('Property Type', (p) => p.propertyType),
      _ComparisonRow('City', (p) => p.city),
      _ComparisonRow('Bedrooms', (p) => p.bedrooms?.toString() ?? '—'),
      _ComparisonRow('Bathrooms', (p) => p.bathrooms?.toString() ?? '—'),
      _ComparisonRow(
        'Super Area',
        (p) => p.area == null ? '—' : '${formatNumber(p.area)} sq.ft.',
      ),
      _ComparisonRow(
        'Price per sq.ft.',
        (p) => p.pricePerSqft == null
            ? '—'
            : '${formatPrice(p.pricePerSqft!)} / sq.ft.',
      ),
      _ComparisonRow('Furnishing', (p) => p.furnishing),
      _ComparisonRow(
        'Possession',
        (p) => p.possession?.trim().isNotEmpty == true
            ? p.possession!
            : 'Not specified',
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: AppDimentions.defaultScreenPadding,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: Table(
          defaultColumnWidth: const FixedColumnWidth(170),
          columnWidths: {0: const FixedColumnWidth(125)},
          border: TableBorder.all(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // Property header row with images.
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade50),
              children: [
                _headerCell('Property'),
                ...properties.map((property) => _propertyHeader(property)),
              ],
            ),

            // Comparison detail rows.
            ...List.generate(rows.length, (index) {
              final row = rows[index];

              return TableRow(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.white : Colors.grey.shade50,
                ),
                children: [
                  _labelCell(row.label),
                  ...properties.map(
                    (property) => _valueCell(row.value(property)),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String title) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _propertyHeader(CompareProperty property) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Get.toNamed(
          AppRoutes.propertyDetailsScreen,
          arguments: {'id': property.id},
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppNetworkImage(
                imgUrl: property.image,
                height: 105,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            CustomText.kText(
              property.title,
              lines: 2,
              weight: FontWeight.w600,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelCell(String label) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _valueCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(value, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _ComparisonRow {
  final String label;
  final String Function(CompareProperty property) value;

  const _ComparisonRow(this.label, this.value);
}
