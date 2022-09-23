import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/button_primary_icon.dart';
import 'login_page.dart';
import 'register_page.dart';

class OnBoardRegister extends StatefulWidget {
  const OnBoardRegister({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardRegisterState createState() => _OnBoardRegisterState();
}

class _OnBoardRegisterState extends State<OnBoardRegister> {
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
      body: GetBuilder<LoginController>(
        builder: (_) {
          return Stack(
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
                          0.6,
                          7.0,
                        ],
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
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
                      flex: 3,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/logo_header.svg',
                        color: Colors.white,
                        height: 40,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    // ButtonSecondaryIcon(
                    //   title: 'Continuar con Facebook',
                    //   path: 'assets/fbb.svg',
                    //   height: 35,
                    //   padding: 5,
                    //   onPressed: () async {
                    //     var response = await _.loginwithFacebook();
                    //     if (response) {
                    //       Get.back();
                    //       Get.back();
                    //     }
                    //   },
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ButtonSecondaryIcon(
                    //   title: 'Continuar con Google',
                    //   path: 'assets/google.svg',
                    //   height: 25,
                    //   onPressed: () async {
                    //     var response = await _.loginWhitGoogle();
                    //     if (response) {
                    //       Get.back();
                    //       Get.back();
                    //     }
                    //   },
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonPrimaryIcon(
                      title: 'Continuar con tu email',
                      path: 'assets/menu.svg',
                      onPressed: () {
                        Get.to(
                          () => const RegisterPage(),
                          transition: Transition.rightToLeft,
                        );
                      },
                      load: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿Ya tienes cuenta? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'AvantGarde',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const LoginPage(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Inicia sesión',
                              style: TextStyle(
                                color: kredDesensa,
                                fontSize: 18,
                                fontFamily: 'AvantGarde',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
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
          );
        },
      ),
    );
  }
}
