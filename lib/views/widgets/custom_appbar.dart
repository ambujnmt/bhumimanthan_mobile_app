import '../../utils/app_imports.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController? scrollController;
  final String? title;

  const CustomAppbar({super.key, this.scrollController, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool isScrolled = false;

  void _initWidget() {
    if (widget.scrollController == null) return;
    widget.scrollController?.addListener(_onScroll);
    _onScroll();
  }

  @override
  void initState() {
    super.initState();
    _initWidget();
  }

  void _onScroll() {
    if (!mounted || !widget.scrollController!.hasClients) return;

    final scrolled = widget.scrollController!.offset > 20;

    if (isScrolled != scrolled) {
      setState(() {
        isScrolled = scrolled;
      });
    }
  }

  @override
  void didUpdateWidget(covariant CustomAppbar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      widget.scrollController?.addListener(_onScroll);
      _onScroll();
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: AppColors.backgroundColor,
      elevation: 0,
      leading: InkWell(
        onTap: Get.back,
        child: Align(
          alignment: Alignment.centerRight,
          child: AppContainer(
            height: 42,
            width: 42,
            color: fromHex('e8eaee'),
            shape: BoxShape.circle,
            padding: EdgeInsets.zero,
            child: Icon(Icons.arrow_back, color: AppColors.secondary),
          ),
        ),
      ),
      title: CustomText.kText(
        widget.title ?? 'title',
        lines: 1,
        size: 17,
        weight: FontWeight.w600,
        family: CustomFonts.outfit,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: AnimatedOpacity(
          opacity: isScrolled ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
