import 'package:faal/views/Login/on_board_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/anim/delayed_reveal.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/button_secundary.dart';
import 'login_page.dart';

class OnBoardLogin extends StatefulWidget {
  const OnBoardLogin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardLoginState createState() => _OnBoardLoginState();
}

class _OnBoardLoginState extends State<OnBoardLogin> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/backImagelogin.jpg'),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.7,
                      10.0,
                    ],
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 20,
                top: 50,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SvgPicture.asset(
                      'assets/closex.svg',
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                DelayedReveal(
                  delay: const Duration(milliseconds: 100),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/logo_header.svg',
                      color: Colors.white,
                      height: 40,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                DelayedReveal(
                  delay: const Duration(milliseconds: 200),
                  child: ButtonPrimary(
                    title: 'Registrarse',
                    onPressed: () {
                      Get.to(
                        () => const OnBoardRegister(),
                        transition: Transition.fadeIn,
                      );
                    },
                    load: false,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                DelayedReveal(
                  delay: const Duration(milliseconds: 300),
                  child: ButtonSecondary(
                    isPro: false,
                    title: 'Iniciar sesión',
                    onPressed: () {
                      Get.to(
                        () => const LoginPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
