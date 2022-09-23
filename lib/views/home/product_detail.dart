import 'package:faal_new2/Models/product_model.dart';
import 'package:faal_new2/controllers/cart_list_controller.dart';
import 'package:faal_new2/controllers/products/products_controller.dart';
import 'package:faal_new2/helps/capitalize.dart';
import 'package:faal_new2/views/home/widgets/relationated_list.dart';
import 'package:faal_new2/widgets/button_primary.dart';
import 'package:faal_new2/widgets/button_secundary_iconed.dart';
import 'package:faal_new2/widgets/title_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/styles_context.dart';
import '../../utils/text_styles.dart';

class ProductDetail extends StatefulWidget {
  ProductModel model;
  ProductDetail({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var prodsControll = Get.find<ProductsController>();
  var helpCap = Capitalization();
  var isCopyLink = false;

  @override
  void initState() {
    prodsControll.getProductsByCategory(
      widget.model.categories![0]['id'],
      excluse: widget.model.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leadingWidth: 60,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: systemDart,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SvgPicture.asset(
                  'assets/back.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(
              Capitalization().capitalizarPrimeraLetra(widget.model.name!),
              style: titleAppBar,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: 'productImage${widget.model.id}',
                  child: Image.network(
                    widget.model.images![0],
                    fit: BoxFit.cover,
                    width: Get.width,
                    height: 300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/tag.svg',
                              height: 24,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                widget.model.categories![0]['name'],
                                style: tagProduct2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          '${helpCap.capitalizarPrimeraLetra(widget.model.name)}',
                          textAlign: TextAlign.left,
                          style: titleDetail,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.model.price!.length > 7
                                ? '\$ ${widget.model.price!.replaceAll('.', ',').replaceRange(7, null, '')}'
                                : '\$ ${widget.model.price!}'
                                    .replaceAll('.', ','),
                            style: priceDetail,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ButtonPrimary(
                            title: _.validatinExistInList(widget.model)
                                ? 'Agregar al carrito'
                                : 'Artículo agregado',
                            onPressed: () {
                              _.selectExistProductInList(
                                widget.model,
                              );
                            },
                            load: false,
                            disabled: !_.validatinExistInList(widget.model),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ButtonSecondaryIcon(
                            title: !isCopyLink
                                ? 'Copiar enlace del producto'
                                : 'Enlace copiado!',
                            path: !isCopyLink
                                ? 'assets/duplicate.svg'
                                : 'assets/check.svg',
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: widget.model.permalink,
                                ),
                              ).then(
                                (value) => {
                                  setState(() {
                                    isCopyLink = true;
                                  })
                                },
                              );
                            },
                            isPro: isCopyLink,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TitleLine(
                            title: 'PRODUCTOS RELACIONADOS',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const RelationatedList(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
