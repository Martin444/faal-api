import 'package:faal_new2/Models/order_model.dart';
import 'package:faal_new2/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helps/rules.dart';
import '../../../utils/styles_context.dart';
import '../order_details.dart';

// ignore: must_be_immutable
class CardOrder extends StatelessWidget {
  OrderModel model;

  CardOrder({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: Get.width * 0.05),
          child: const Dashes(),
        ),
        GestureDetector(
          onTap: () {
            Get.to(
              () => OrderDetailPage(
                orderDetail: model,
              ),
            );
          },
          child: Container(
            decoration: decorationMethod,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          model.products![0].images![0],
                          height: 70,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${model.products![0].name!} y ${model.products!.length - 1} más',
                            style: titleProduct,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: RulesFunctions()
                              .validColorsStatus(
                                model.status!,
                              )
                              .withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          RulesFunctions().validStatus(model.status!),
                          style: titleProduct,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$${model.amount!.toStringAsFixed(2)}',
                        style: priceProduct,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Dashes extends StatelessWidget {
  const Dashes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 100,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainHeight();
          const dashWidth = 2.0;
          const dashHeight = 5.0;
          final dashCount = (boxWidth / (5 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.vertical,
            children: List.generate(
              dashCount,
              (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xff8F959A).withOpacity(0.7),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
