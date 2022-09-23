import 'package:faal_new2/controllers/login_controller.dart';
import 'package:faal_new2/controllers/navigations_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';

class DrawMenu extends StatelessWidget {
  const DrawMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (user) {
        return Drawer(
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: GetBuilder<NavigationsControllers>(
              builder: (_) {
                return ListView(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(
                            child: SvgPicture.asset(
                              'assets/back.svg',
                              color: kTextColor,
                              height: 30,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          child: SvgPicture.asset(
                            'assets/faaltext.svg',
                            color: kTextColor,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MenuTile(
                      title: 'Home',
                      path: 'assets/home.svg',
                      onTaping: () {
                        Get.back();
                        _.setIndexPage(0);
                      },
                      selected: _.indexPage == 0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    user.accessTokenID != null
                        ? MenuTile(
                            title: 'Mis pedidos',
                            path: 'assets/folder.svg',
                            onTaping: () {
                              _.setIndexPage(1);
                              Get.back();
                            },
                            selected: _.indexPage == 1,
                          )
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    user.accessTokenID != null
                        ? user.userData!.role == 'admin'
                            ? MenuTile(
                                title: 'Notificaciones',
                                path: 'assets/notifications.svg',
                                onTaping: () {
                                  Get.back();
                                  _.setIndexPage(2);
                                },
                                selected: _.indexPage == 2,
                              )
                            : Container()
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuTile(
                      title: 'Contacto',
                      path: 'assets/support.svg',
                      onTaping: () async {
                        Get.back();
                        var url = Uri.parse(
                          'whatsapp://send?phone=+5493873597658',
                        );
                        await launchUrl(url);
                      },
                      selected: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuTile(
                      title: 'Quienes somos',
                      path: 'assets/info-circle.svg',
                      onTaping: () {
                        Get.back();
                        _.setIndexPage(3);
                      },
                      selected: _.indexPage == 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    user.accessTokenID != null
                        ? MenuTile(
                            title: 'Cerrar sesión',
                            path: 'assets/logout.svg',
                            onTaping: () {
                              Get.back();
                              user.logOut();
                            },
                            selected: false,
                          )
                        : Container(),
                    const SizedBox(height: 10),
                    Divider(
                      color: kTextColor,
                      thickness: 2,
                    ),
                    MenuTile(
                      title: 'Medios de pago:',
                      path: 'assets/cash.svg',
                      onTaping: () {},
                      selected: false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/mercado.png',
                          fit: BoxFit.cover,
                          width: 45,
                          height: 45,
                        ),
                        SvgPicture.asset('assets/pay-mastercard.svg'),
                        SvgPicture.asset('assets/pay-visa.svg')
                      ],
                    ),
                    Image.asset(
                      'assets/pay-naranja.png',
                      fit: BoxFit.contain,
                      width: 50,
                      height: 100,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class MenuTile extends StatelessWidget {
  String? title;
  VoidCallback? onTaping;
  String? path;
  bool? selected;

  MenuTile({
    Key? key,
    required this.title,
    required this.onTaping,
    required this.path,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTaping,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: selected! ? kpurplecolor : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              path!,
              color: selected! ? Colors.white : kTextColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title!,
              style: selected! ? titleAppBarWithe : titleAppBar,
            ),
          ],
        ),
      ),
    );
  }
}
