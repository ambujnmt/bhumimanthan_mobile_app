import 'package:bhumi_manthan/utils/app_imports.dart';

class AgentContactDetailsScreen extends StatefulWidget {
  const AgentContactDetailsScreen({super.key});

  @override
  State<AgentContactDetailsScreen> createState() =>
      _AgentContactDetailsScreenState();
}

class _AgentContactDetailsScreenState extends State<AgentContactDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Agent/seller Contact Details'),
      body: ListView(children: []),
    );
  }
}
