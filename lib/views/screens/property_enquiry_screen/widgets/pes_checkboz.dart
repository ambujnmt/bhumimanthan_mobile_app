import '../../../../utils/app_imports.dart';

class CommunicationConsent extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CommunicationConsent({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 22,
              width: 22,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'I agree to receive communications from the company '
                'regarding my enquiry, services, offers and updates '
                'through SMS, WhatsApp and email. I understand that '
                'I can withdraw my consent at any time.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
