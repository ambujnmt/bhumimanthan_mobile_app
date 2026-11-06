import '../../utils/app_imports.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController? scrollController;
  final String? title;
  final bool showLeading;

  const CustomAppbar({
    super.key,
    this.scrollController,
    this.title,
    this.showLeading = true,
  });

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
      leading: widget.showLeading
          ? Align(
              alignment: Alignment.centerRight,
              child: CustomCircleIconButton(
                onTap: Get.back,
                icon: Icon(Icons.arrow_back, color: AppColors.secondary),
              ),
            )
          : null,
      title: CustomText.kText(
        widget.title ?? 'title',
        lines: 1,
        size: 20,
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

class CustomAppbar1 extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController? scrollController;
  final String? title;
  final bool showLeading;
  final bool error;
  final List<Widget>? actions;

  const CustomAppbar1({
    super.key,
    this.scrollController,
    this.title,
    this.showLeading = true,
    this.error = false,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppbar1> createState() => _CustomAppbar1State();
}

class _CustomAppbar1State extends State<CustomAppbar1> {
  double scrollProgress = 0.0;

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

    final offset = widget.scrollController!.offset;
    final progress = (offset / (Get.height * .25)).clamp(0.0, 1.0);

    if (scrollProgress != progress) {
      setState(() {
        scrollProgress = progress;
      });
    }
  }

  @override
  void didUpdateWidget(covariant CustomAppbar1 oldWidget) {
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
      backgroundColor: Color.lerp(
        Colors.transparent,
        AppColors.backgroundColor,
        scrollProgress,
      ),
      surfaceTintColor: transparent,
      elevation: 0,
      leading: widget.showLeading
          ? Align(
              alignment: Alignment.centerRight,
              child: CustomCircleIconButton(
                onTap: Get.back,
                icon: Icon(Icons.arrow_back, color: AppColors.secondary),
              ),
            )
          : null,
      title: Opacity(
        opacity: widget.error ? 1 : scrollProgress,
        child: CustomText.kText(
          widget.title ?? 'title',
          lines: 1,
          size: 20,
          weight: FontWeight.w600,
          family: CustomFonts.outfit,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: Color.lerp(
            Colors.transparent,
            Colors.grey.shade300,
            scrollProgress,
          ),
        ),
      ),
      actions: widget.actions,
    );
  }
}

class CustomCircleIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? icon;
  final double size;
  const CustomCircleIconButton({
    super.key,
    this.icon,
    this.onTap,
    this.size = 42,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AppContainer(
        height: size,
        width: size,
        borderColor: grey.shade400,
        color: fromHex('e8eaee'),
        shape: BoxShape.circle,
        padding: EdgeInsets.all(AppDimentions.screenPaddingXXS),
        alignment: Alignment.center,
        child: icon ?? Icon(Icons.question_mark, color: AppColors.secondary),
      ),
    );
  }
}
