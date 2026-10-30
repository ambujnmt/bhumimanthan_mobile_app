import '../../../utils/app_imports.dart';
import 'contact_us_controller.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _con = Get.put(ContactUsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Contact Us'),
      body: Expanded(
        child: ListView(
          padding: EdgeInsets.all(AppDimentions.defaultScreenPadding),
          children: [
            AppTextfield(
              hintText: 'Subject',
              controller: _con.subController,
              errorText: _con.subError,
              capitalization: TextCapitalization.sentences,
            ),
            AppTextfield(
              hintText: 'Message',
              minLines: 4,
              maxLines: 6,
              controller: _con.messController,
              errorText: _con.messError,
              capitalization: TextCapitalization.sentences,
            ),
            heightSpace20,
            Obx(
              () => _con.showLoader.value
                  ? AppLoader.widget()
                  : CustomButton(
                      text: 'Submit',
                      onTap: () => _con.onSubmitTapped(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsSuccessScreen extends StatelessWidget {
  final String? ticketId;

  const ContactUsSuccessScreen({super.key, this.ticketId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),

                // Success illustration
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 86,
                      height: 86,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 52,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Message Sent Successfully!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Thank you for contacting Domis Quick. '
                  'Our support team has received your message '
                  'and will get back to you as soon as possible.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),

                if (ticketId != null && ticketId!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colors.outlineVariant),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Your Reference Number',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          ticketId!,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.primary,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Keep this number for future reference.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                heightSpace20,
                CustomButton(
                  text: 'Done',
                  color: transparent,
                  textColor: black,
                  border: Border.all(color: AppColors.primary),
                  onTap: Get.back,
                ),
                heightSpace100,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
