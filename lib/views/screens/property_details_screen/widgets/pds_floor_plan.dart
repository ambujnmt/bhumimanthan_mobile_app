import '../../../../utils/app_imports.dart';

class PdsFloorPlan extends StatelessWidget {
  const PdsFloorPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Floor Plan',
      content: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimentions.defaultScreenPadding,
        ),
        child: Column(children: []),
      ),
    );
  }
}
