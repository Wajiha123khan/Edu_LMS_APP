import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screen/ActiveOn.dart';
// import '../screen/AdmissionDate.dart';
// import '../screen/LeaveDate.dart';
// import '../screen/onLeave.dart';
import '../utils/colors.dart';

class FilterCardController extends GetxController {
  final ScrollController cardScrollController = ScrollController();

  // Rx for selected filter
  var selectedFilter = ''.obs;

  @override
  void onClose() {
    cardScrollController.dispose();
    super.onClose();
  }

  void scrollBackward(BuildContext context) {
    if (cardScrollController.hasClients) {
      final double currentOffset = cardScrollController.offset;
      final double screenWidth = MediaQuery.of(context).size.width - 80;
      final double newOffset = currentOffset - screenWidth * 0.5;

      cardScrollController.animateTo(
        newOffset.clamp(0.0, cardScrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollForward(BuildContext context) {
    if (cardScrollController.hasClients) {
      final double currentOffset = cardScrollController.offset;
      final double screenWidth = MediaQuery.of(context).size.width - 80;
      final double newOffset = currentOffset + screenWidth * 0.5;

      cardScrollController.animateTo(
        newOffset.clamp(0.0, cardScrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onFilterTap(String title, BuildContext context) {
    if (title == 'All student') {
      selectedFilter.value = title;
    } else if (title == 'ActiveOn') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ActiveOn()));
    }
    // Add other navigation options if needed here (commented in your original)
    else {
      // For other filters just update selectedFilter
      selectedFilter.value = title;
    }
    print('$title filter tapped');
  }
}

class FilterCardWidget extends StatelessWidget {
  final List<String> filterOptions;
  final String initialFilter;
  final Function(String) onFilterChanged;
  final bool showNavigationArrows;

  FilterCardWidget({
    Key? key,
    required this.filterOptions,
    this.initialFilter = 'All student',
    required this.onFilterChanged,
    this.showNavigationArrows = true,
  }) : super(key: key) {
    // Initialize controller and selectedFilter once
    final controller = Get.put(FilterCardController());
    if (controller.selectedFilter.value.isEmpty) {
      controller.selectedFilter.value = initialFilter;
    }
  }

  Widget _buildFilterCard(
    FilterCardController controller,
    String title,
    BuildContext context,
  ) {
    return Obx(() {
      final bool isActive = title == controller.selectedFilter.value;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: () {
            controller.onFilterTap(title, context);
            onFilterChanged(title);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: isActive
                  ? null
                  : Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1.0,
                    ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
            ),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? Colors.white : AppColors.textDark,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterCardController>();

    if (!showNavigationArrows) {
      return SizedBox(
        height: 50,
        child: ListView.builder(
          controller: controller.cardScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: filterOptions.length,
          itemBuilder: (context, index) {
            return _buildFilterCard(controller, filterOptions[index], context);
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.scrollBackward(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppColors.textDark.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                controller: controller.cardScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: filterOptions.length,
                itemBuilder: (context, index) {
                  return _buildFilterCard(
                    controller,
                    filterOptions[index],
                    context,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => controller.scrollForward(context),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: AppColors.textDark.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
