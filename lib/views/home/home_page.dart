import 'package:faal_new2/views/home/widgets/category_flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/scroll_controllers.dart';
import '../../helps/modals.dart';
import 'widgets/products_list.dart';
import 'widgets/promotion_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _serviceScrolled = Get.find<ScrollControllers>();

  @override
  void initState() {
    super.initState();
    _serviceScrolled.scrollControllerHome = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ModalsHelpers().modalConfirm();
        return true;
      },
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const SizedBox(height: 10),
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
                        ProductsList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
