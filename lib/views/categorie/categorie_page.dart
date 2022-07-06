import 'package:faal/utils/styles_context.dart';
import 'package:faal/utils/text_styles.dart';
import 'package:faal/views/categorie/widget/category_tile.dart';
import 'package:faal/views/responses/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/categories_controller.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({Key? key}) : super(key: key);

  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  var categoryController = Get.find<CategoriesController>();
  var scrollController = ScrollController();

  @override
  void initState() {
    categoryController.getCategoryList('1');
    super.initState();

    scrollController.addListener(() {
      categoryController.scrollChargeMoreCategory(scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      builder: (_) {
        if (_.isLoadingCategorys!) {
          return const WaitPage();
        } else {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 30,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: systemDart,
              elevation: 0,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      'assets/back.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Categorias',
                    style: titleAppBar,
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _.categoryList.length,
                        itemBuilder: (context, index) => CategoryTile(
                          model: _.categoryList[index],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        !_.isLoadingMoreCategorys! ? _.getMoreCategory() : null;
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: _.endCategory ? 70 : 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            Text(
                              _.isLoadingMoreCategorys!
                                  ? 'Cargando'
                                  : 'Ver mas categorias',
                              style: inputSearchStyle,
                            ),
                            SvgPicture.asset('assets/arrowdown.svg')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
