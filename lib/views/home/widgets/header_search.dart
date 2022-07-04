import 'package:faal/controllers/login_controller.dart';
import 'package:faal/views/Login/login_page.dart';
import 'package:faal/views/searcher/search_page.dart';
import 'package:faal/widgets/anim/delayed_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_list_controller.dart';
import '../../../utils/colors.dart';
import '../../cartlist/cart_list_page.dart';

class HeaderSearch extends StatelessWidget {
  const HeaderSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedReveal(
      delay: const Duration(milliseconds: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SizedBox(
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const SearchPage(),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SvgPicture.asset(
                    'assets/searchicon.svg',
                    height: 25,
                  ),
                ),
              ),
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
              GetBuilder<LoginController>(
                builder: (_) {
                  if (_.userData == null) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          'assets/user-circle.svg',
                          height: 35,
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        // Get.to(() => const LoginPage());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            _.userData!.photoUrl!,
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
