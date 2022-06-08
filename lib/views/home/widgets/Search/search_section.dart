import 'package:faal/views/responses/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/products_controller.dart';
import '../../../../controllers/search_controller.dart';
import '../../../../utils/text_styles.dart';
import '../../../../widgets/product_tile.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: (_) {
        // ignore: prefer_is_empty
        if (_.listResult.length > 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Resultados',
                style: titleAppBar,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: Get.height * 0.8,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _.listResult.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 320,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 24,
                  ),
                  // physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    // printInfo(info: _.listResult[index].toString());
                    return ProductTile(
                      product: _.listResult[index],
                    );
                  },
                ),
              )
            ],
          );
        } else {
          return const Expanded(
            child: Center(
              child: SizedBox(
                // height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
