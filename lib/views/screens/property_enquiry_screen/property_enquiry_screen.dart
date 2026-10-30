import 'package:bhumi_manthan/utils/app_imports.dart';
import 'package:bhumi_manthan/views/screens/property_enquiry_screen/property_enquiry_screen_controller.dart';
import 'package:bhumi_manthan/views/widgets/app_dropdown.dart';

class PropertyEnquiryScreen extends StatefulWidget {
  const PropertyEnquiryScreen({super.key});

  @override
  State<PropertyEnquiryScreen> createState() => _PropertyEnquiryScreenState();
}

class _PropertyEnquiryScreenState extends State<PropertyEnquiryScreen> {
  final _con = Get.put(PropertyEnquiryScreenController());

  final List<CustomDropdownItem<String>> _interests = [
    CustomDropdownItem(value: 'residential', title: 'Residential Plots'),
    CustomDropdownItem(value: 'commercial', title: 'Commercial Plots'),
    CustomDropdownItem(value: 'apartment', title: 'Apartments'),
    CustomDropdownItem(value: 'villa', title: 'Villas'),
    CustomDropdownItem(value: 'farmhouse', title: 'Farm House'),
  ];

  final List<CustomDropdownItem<String>> _budgets = [
    CustomDropdownItem(value: 'below-25', title: 'Below 25 Lac'),
    CustomDropdownItem(value: '25-50', title: '25 Lac - 50 Lac'),
    CustomDropdownItem(value: '50-1cr', title: '50 Lac - 1 Cr'),
    CustomDropdownItem(value: '1-2cr', title: '1 Cr - 2 Cr'),
    CustomDropdownItem(value: 'above-2cr', title: 'Above 2 Cr'),
  ];

  final sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: 'Property Enquiry'),
      body: Obx(
        () => IgnorePointer(
          ignoring: _con.isLoading.value,
          child: ListView(
            controller: sc,
            padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
            children: [
              Text(
                'Interested in this property?',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Share your details and our team can help you with '
                'pricing, availability and more.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 22),

              // Compact property preview
              _buildPropertyCard(theme),

              const SizedBox(height: 28),

              Text(
                'Your Details',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),

              AppTextfield(
                isRequired: true,
                controller: _con.nameController,
                capitalization: TextCapitalization.words,
                inputAction: TextInputAction.next,
                hintText: 'Enter your full name',
                label: 'Name',
                errorText: _con.nameError,
              ),
              AppTextfield(
                isRequired: true,
                hintText: '10-digit mobile number',
                controller: _con.phoneController,
                inputType: TextInputType.phone,
                inputAction: TextInputAction.next,
                label: 'Mobile',
                errorText: _con.phoneError,
              ),
              AppTextfield(
                isRequired: true,
                hintText: 'you@example.com',
                controller: _con.emailController,
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                label: 'Email',
                errorText: _con.emailError,
              ),
              AppDropdownField(
                isRequired: true,
                label: 'Interested In',
                hintText: 'Select',
                selected: _con.selectedInterest.value,
                items: _interests,
                onSelect: (item) => _con.selectedInterest(item),
                errorText: _con.typeError,
              ),

              AppDropdownField(
                isRequired: true,
                label: 'Budget',
                hintText: 'Select your budget',
                selected: _con.selectedBudget.value,
                items: _budgets,
                onSelect: (item) => _con.selectedBudget(item),
                errorText: _con.budgetError,
              ),

              AppTextfield(
                isRequired: true,
                hintText: 'Tell us what you would like to know',
                controller: _con.moreController,
                minLines: 3,
                maxLines: 5,
                capitalization: TextCapitalization.sentences,
                label: 'More Details',
                errorText: _con.moreError,
              ),
              heightSpace20,
              CustomButton(
                text: 'Send Enquiry',
                onTap: () => _con.onSend(),
                showLoader: _con.isLoading,
              ),
              const SizedBox(height: 12),
              Text(
                'Your details will be used to respond to your property enquiry.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              heightSpace100,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCard(ThemeData theme) {
    return AppContainer(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 100,
              height: 100,
              child: AppNetworkImage(
                imgUrl: _con.property.mainImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _con.property.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        _con.property.location,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  formatPrice(_con.property.price),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _con.property.propertyType,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
