import 'package:bhumi_manthan/views/screens/agent_contact_screens/submit_user_details/submit_user_details_controller.dart';
import 'package:bhumi_manthan/views/screens/auth_screens/otp_input_screen/widgets/custom_otp_widget.dart';

import '../../../../utils/app_imports.dart';

class SubmitUserDetails extends StatefulWidget {
  const SubmitUserDetails({super.key});

  @override
  State<SubmitUserDetails> createState() => _SubmitUserDetailsState();
}

class _SubmitUserDetailsState extends State<SubmitUserDetails> {
  final _con = Get.put(SubmitUserDetailsController());

  final sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppbar(scrollController: sc, title: 'Contact Agent/Seller'),
      body: _con.agentId == null
          ? ApiErrorWidget()
          : Obx(
              () => AppFadeAnimatedSwitcher(
                child: _con.isLoading.value
                    ? AppLoader.widget()
                    : IgnorePointer(
                        ignoring: _con.isSubmitting.value,
                        child: ListView(
                          controller: sc,
                          padding: EdgeInsets.all(
                            AppDimentions.defaultScreenPadding,
                          ),
                          children: [
                            Text(
                              'Interested in this property?',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Share your details get agent/seller contact details.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 22),

                            // Compact property preview
                            // _buildPropertyCard(theme),
                            const SizedBox(height: 28),

                            Obx(
                              () => _con.otpSent.value
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Verify Your Number',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        Text(
                                          'Enter verification code to verify you phone number.',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: theme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                        heightSpace40,
                                        CustomPinput(length: 6),
                                        // heightSpace40,
                                        // Center(
                                        //   child: TextButton(
                                        //     onPressed: () {},
                                        //     child: CustomText.kText(
                                        //       'Resend OTP',
                                        //     ),
                                        //   ),
                                        // ),
                                        heightSpace40,
                                        CustomButton(
                                          text: 'Submit Details',
                                          onTap: () => _con.onSend(),
                                          showLoader: _con.isSubmitting,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Your Details',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        Text(
                                          'Your details will be shared with the agent or seller.',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: theme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                        const SizedBox(height: 16),

                                        AppTextfield(
                                          readOnly: _con.otpSent.value,
                                          isRequired: true,
                                          controller: _con.nameController,
                                          capitalization:
                                              TextCapitalization.words,
                                          inputAction: TextInputAction.next,
                                          hintText: 'Enter your full name',
                                          label: 'Your Name',
                                          errorText: _con.nameError,
                                        ),

                                        AppTextfield(
                                          readOnly: _con.otpSent.value,
                                          hintText:
                                              'Enter a valid email address',
                                          controller: _con.emailController,
                                          inputType: TextInputType.emailAddress,
                                          inputAction: TextInputAction.next,
                                          label: 'Email (Optional)',
                                          errorText: _con.emailError,
                                        ),

                                        AppTextfield(
                                          readOnly: _con.otpSent.value,
                                          isRequired: true,
                                          hintText: '10-digit mobile number',
                                          controller: _con.phoneController,
                                          inputType: TextInputType.phone,
                                          inputAction: TextInputAction.next,
                                          label: 'Mobile',
                                          errorText: _con.phoneError,
                                        ),
                                        heightSpace20,
                                        CustomButton(
                                          text: 'Submit Details',
                                          onTap: () => _con.onSend(),
                                          showLoader: _con.isSubmitting,
                                        ),
                                      ],
                                    ),
                            ),
                            heightSpace100,
                          ],
                        ),
                      ),
              ),
            ),
    );
  }

  //   Widget _buildPropertyCard(ThemeData theme) {
  //     return AppContainer(
  //       child: Row(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: SizedBox(
  //               width: 100,
  //               height: 100,
  //               child: AppNetworkImage(
  //                 imgUrl: _con.property.mainImage,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(width: 14),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   _con.property.title,
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: theme.textTheme.titleMedium?.copyWith(
  //                     fontWeight: FontWeight.w800,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 7),
  //                 Row(
  //                   children: [
  //                     Icon(
  //                       Icons.location_on_outlined,
  //                       size: 16,
  //                       color: theme.colorScheme.onSurfaceVariant,
  //                     ),
  //                     const SizedBox(width: 4),
  //                     Expanded(
  //                       child: Text(
  //                         _con.property.location,
  //                         maxLines: 2,
  //                         overflow: TextOverflow.ellipsis,
  //                         style: theme.textTheme.bodySmall,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 7),
  //                 Text(
  //                   formatPrice(_con.property.price),
  //                   style: theme.textTheme.titleSmall?.copyWith(
  //                     color: theme.colorScheme.primary,
  //                     fontWeight: FontWeight.w800,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 5),
  //                 Text(
  //                   _con.property.propertyType,
  //                   style: theme.textTheme.bodySmall?.copyWith(
  //                     color: theme.colorScheme.onSurfaceVariant,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
}
