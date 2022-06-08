import 'package:faal/controllers/cart_list_controller.dart';
import 'package:faal/controllers/products_controller.dart';
import 'package:faal/controllers/scroll_controllers.dart';
import 'package:faal/controllers/search_controller.dart';
import 'package:faal/utils/colors.dart';
import 'package:faal/views/cartlist/cart_list_page.dart';
import 'package:faal/views/home/widgets/Search/search_section.dart';
import 'package:faal/views/home/widgets/products_list.dart';
import 'package:faal/views/responses/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
  final TextEditingController searchController = TextEditingController();

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
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: GetBuilder<CartListController>(
              builder: (c) {
                return GestureDetector(
                  onTap: () => {
                    Get.to(
                      () => const CartListPage(),
                    ),
                  },
                  child: Stack(
                    alignment: const Alignment(0.9, -1.3),
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: kYellow,
                        child: SvgPicture.asset(
                          'assets/cart.svg',
                          height: 30,
                        ),
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: kredcolor,
                        child: Text(
                          '${c.listCart!.length}',
                          style: TextStyle(
                            fontSize: 14,
                            color: kBackground,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GetBuilder<SearchController>(
                  builder: (searcher) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        HeaderSearch(searchController: searchController),
                        const SizedBox(height: 10),
                        searcher.searching!
                            ? const SearchSection()
                            : SizedBox(
                                height: Get.height * 0.85,
                                child: SingleChildScrollView(
                                  controller:
                                      _serviceScrolled.scrollControllerHome,
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Stack(
                                    alignment: const Alignment(0.0, 0.99),
                                    children: [
                                      Column(
                                        children: const [
                                          PromotionList(),
                                          ProductsList(),
                                        ],
                                      ),
                                      _.isLoadingMoreProd
                                          ? SizedBox(
                                              height: 10,
                                              child: LinearProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  kYellow,
                                                ),
                                                backgroundColor: kBackground,
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
