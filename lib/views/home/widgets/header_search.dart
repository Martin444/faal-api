import 'package:animate_do/animate_do.dart';
import 'package:faal/controllers/search_controller.dart';
import 'package:faal/widgets/anim/delayed_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_list_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/text_input_search.dart';
import '../../cartlist/cart_list_page.dart';

class HeaderSearch extends StatelessWidget {
  const HeaderSearch({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: (_) {
        return DelayedReveal(
          delay: const Duration(milliseconds: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: SvgPicture.asset(
                  'assets/searchicon.svg',
                  height: 30,
                ),
              ),
              SizedBox(
                child: SvgPicture.asset(
                  'assets/faaltext.svg',
                  color: kTextColor,
                  height: 30,
                ),
              ),
              Row(
                children: [
                  GetBuilder<CartListController>(
                    builder: (c) {
                      return GestureDetector(
                        onTap: () => {
                          Get.to(
                            () => const CartListPage(),
                            transition: Transition.rightToLeft,
                          ),
                        },
                        child: Stack(
                          alignment: const Alignment(1.9, -3.0),
                          children: [
                            SvgPicture.asset(
                              'assets/cart.svg',
                              height: 30,
                            ),
                            CircleAvatar(
                              radius: 9,
                              backgroundColor: kredDesensa,
                              child: Text(
                                '${c.listCart!.length}',
                                style: TextStyle(
                                  fontSize: 12,
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
                ],
              ),
              // Flexible(
              //   child: TextInputSearch(
              //       labelText: 'Buscar articulo',
              //       controller: searchController,
              //       inputType: TextInputType.emailAddress,
              //       visibleText: false,
              //       isPass: false,
              //       functionSubmited: (value) {
              //         _.search(value);
              //       }),
              // ),
            ],
          ),
        );
      },
    );
  }
}
