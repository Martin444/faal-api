import 'package:faal/controllers/products_controller.dart';
import 'package:faal/utils/colors.dart';
import 'package:faal/views/home/widgets/products_list.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _serviceProducts.getInitProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10),
              HeaderSearch(searchController: searchController),
              const SizedBox(height: 10),
              const PromotionList(),
              const ProductsList(),
            ],
          ),
        ),
      ),
    );
  }
}
