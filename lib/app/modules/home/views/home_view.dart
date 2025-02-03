import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'widgets/filter_bar.dart';
import 'widgets/info_card.dart';
import 'widgets/statistics_dialog.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YOU BLOOD INFO".toUpperCase()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const FilterBar(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;

                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey[100]!,
                        Colors.grey[300]!,
                      ],
                    ),
                  ),
                  child: Obx(() {
                    if (controller.filteredItems.isEmpty) {
                      return const Center(
                          child: Text('Nenhum resultado encontrado'));
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.5,
                              ),
                              itemCount: controller.filteredItems.length,
                              itemBuilder: (context, index) {
                                final item = controller.filteredItems[index];
                                return InfoCard(item: item);
                              },
                            ),
                          ),
                        ),
                        _buildBottomInfo(),
                      ],
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildInfoText('Total: ${controller.totalItems}')),
                Obx(() => _buildInfoText(
                    'Filtrados: ${controller.filteredItemsCount}')),
                Obx(() => _buildInfoText(
                    'Percentual: ${controller.filteredPercentage}')),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Get.dialog(const StatisticsDialog()),
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey[800],
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
