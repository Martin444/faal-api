import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'dart:math';

import '../../../Models/product_model.dart';
import '../../../controllers/cart_list_controller.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/anim/delayed_reveal.dart';
import '../../../widgets/button_primary_icon.dart';

// ignore: must_be_immutable
class DetailModal extends StatefulWidget {
  ProductModel product;
  DetailModal({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailModal> createState() => _DetailModalState();
}

class _DetailModalState extends State<DetailModal> {
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Dialog(
            insetAnimationDuration: const Duration(milliseconds: 500),
            insetAnimationCurve: Curves.easeOutCubic,
            insetPadding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: const Alignment(0.95, -0.9),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.product.images![0],
                            height: Get.height / 2.5,
                            width: Get.width,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DelayedReveal(
                                delay: const Duration(milliseconds: 100),
                                child: Text(
                                  widget.product.name ?? '',
                                  textAlign: TextAlign.left,
                                  style: titleDetail,
                                ),
                              ),
                              const SizedBox(height: 20),
                              DelayedReveal(
                                delay: const Duration(milliseconds: 100),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.product.price!.length > 7
                                            ? '\$ ${widget.product.price!.replaceAll('.', ',').replaceRange(7, null, '')}'
                                            : '\$ ${widget.product.price!}'
                                                .replaceAll('.', ','),
                                        textAlign: TextAlign.left,
                                        style: priceDetail,
                                      ),
                                    ),
                                    Flexible(
                                      child: ButtonPrimaryIcon(
                                        title: 'COMPARTIR',
                                        path: 'assets/share.svg',
                                        onPressed: () {},
                                        load: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              DelayedReveal(
                                delay: const Duration(milliseconds: 100),
                                child: ButtonPrimaryIcon(
                                  title: 'AGREGAR AL CARRITO',
                                  path: 'assets/cart.svg',
                                  onPressed: () {
                                    _.selectExistProductInList(widget.product);
                                  },
                                  load: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFc2c2c2).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset(
                          'assets/close.svg',
                          height: 35,
                          width: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
