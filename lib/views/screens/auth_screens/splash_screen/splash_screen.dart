import '../../../../utils/app_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: Image.asset(Images.splashBg, fit: BoxFit.cover),
            ),
          ),

          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(Images.splashTxt),
                    ),
                  ),
                  heightSpace20,
                  Padding(
                    padding: EdgeInsets.all(AppDimentions.screenPaddingXL),
                    child: CustomButton(
                      text: 'Get Started',
                      onTap: () => Get.toNamed(AppRoutes.loginScreen),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
