import '../../utils/app_imports.dart';

class PaginationPageEndWidget extends StatelessWidget {
  final RxBool isLoadingMore;
  final RxBool hasError;
  final PaginationModel pagination;
  final bool enabled;
  const PaginationPageEndWidget({
    super.key,
    required this.isLoadingMore,
    required this.hasError,
    required this.pagination,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Center(
        child: !enabled
            ? SizedBox.shrink()
            : Obx(
                () => isLoadingMore.value
                    ? AppLoader.widget(size: 35)
                    : hasError.value
                    ? CustomText.kText(
                        'Something went wrong!',
                        color: red,
                        // Add your preferred text styling here
                      )
                    : pagination.isLastPage
                    ? CustomText.kText(
                        'You have reached the end',
                        weight: FontWeight.w600,
                      )
                    : SizedBox.shrink(),
              ),
      ),
    );
  }
}

class PaginationModel {
  final int currentPage;
  final int lastPage;
  final int perPage;

  const PaginationModel({
    this.currentPage = 0,
    this.lastPage = 0,
    this.perPage = 20,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
      perPage: json['per_page'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
    };
  }

  bool get isLastPage => currentPage >= lastPage;
}
