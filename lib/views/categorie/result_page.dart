import 'package:faal_new2/controllers/categories_controller.dart';
import 'package:faal_new2/views/categorie/widget/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Models/category_model.dart';
import '../../controllers/products/products_controller.dart';
import '../../utils/styles_context.dart';
import '../../utils/text_styles.dart';
import '../../widgets/product_tile.dart';
import '../responses/wait_page.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  CategoryModel? result;
  ResultPage({Key? key, this.result}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  var prodController = Get.find<ProductsController>();
  var cateController = Get.find<CategoriesController>();

  @override
  void initState() {
    prodController.getProductsByCategory(widget.result!.id!);
    cateController.getCategoryByID(widget.result!.subCategorieID!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) {
        if (_.loadCategorisProduct!) {
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
                    widget.result!.name!,
                    style: titleAppBar,
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  widget.result!.subCategorie!
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Otras categorias',
                              style: titlePromotionProduct,
                              textAlign: TextAlign.left,
                            ),
                            GetBuilder<CategoriesController>(
                              builder: (_) {
                                if (_.parentCategorie != null) {
                                  return CategoryTile(
                                    model: _.parentCategorie!,
                                    isSubCat: true,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Resultados',
                    style: titlePromotionProduct,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: widget.result!.subCategorie!
                        ? Get.height * 0.73
                        : Get.height * 0.82,
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _.productbyCategorie.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                          product: _.productbyCategorie[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
