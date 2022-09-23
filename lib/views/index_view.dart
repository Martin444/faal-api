import 'package:faal_new2/controllers/navigations_controller.dart';
import 'package:faal_new2/controllers/products/products_controller.dart';
import 'package:faal_new2/views/home/home_page.dart';
import 'package:faal_new2/views/info_us/info_us.dart';
import 'package:faal_new2/views/notifications/notifications.dart';
import 'package:faal_new2/views/orders/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../widgets/drawer_menu.dart';
import 'home/widgets/header_search.dart';
import 'responses/wait_page.dart';

class IndexView extends StatefulWidget {
  const IndexView({Key? key}) : super(key: key);

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  final _serviceProducts = Get.find<ProductsController>();

  @override
  void initState() {
    super.initState();
    _serviceProducts.getInitProducts(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) {
        if (_.isLoadingInit) {
          return const WaitPage();
        } else {
          return GetBuilder<NavigationsControllers>(builder: (_) {
            Widget? getPagee() {
              switch (_.indexPage) {
                case 0:
                  return const HomePage();
                case 1:
                  return const OrdersPage();
                case 2:
                  return const NotificationsPage();
                case 3:
                  return const InfoUs();
                default:
                  return const HomePage();
              }
            }

            return Scaffold(
              backgroundColor: kBackground,
              drawer: const DrawMenu(),
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      const HeaderSearch(),
                      getPagee()!,
                    ],
                  ),
                ),
              ),
            );
          });
        }
      },
    );
  }
}
