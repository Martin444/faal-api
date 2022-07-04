import 'package:faal/controllers/products_controller.dart';
import 'package:faal/controllers/scroll_controllers.dart';
import 'package:faal/utils/colors.dart';
import 'package:faal/views/home/widgets/category_flag.dart';
import 'package:faal/views/home/widgets/products_list.dart';
import 'package:faal/views/responses/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/drawer_menu.dart';
import 'widgets/header_search.dart';
import 'widgets/promotion_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _serviceProducts = Get.find<ProductsController>();
  final _serviceScrolled = Get.find<ScrollControllers>();

  @override
  void initState() {
    super.initState();
    _serviceProducts.getInitProducts(1);
    _serviceScrolled.scrollControllerHome = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) {
        if (_.isLoadingInit) {
          return const WaitPage();
        } else {
          return Scaffold(
            backgroundColor: kBackground,
            drawer: const DrawMenu(),
            body: SafeArea(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // const SizedBox(height: 10),
                      const HeaderSearch(),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: Get.height * 0.85,
                        child: SingleChildScrollView(
                          controller: _serviceScrolled.scrollControllerHome,
                          // physics: const NeverScrollableScrollPhysics(),
                          child: Stack(
                            alignment: const Alignment(0.0, 0.99),
                            children: [
                              Column(
                                children: const [
                                  PromotionList(),
                                  SizedBox(height: 10),
                                  CategoryFlag(),
                                  ProductsList(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        }
      },
    );
  }
}
