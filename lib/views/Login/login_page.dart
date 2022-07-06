import 'package:faal/utils/colors.dart';
import 'package:faal/views/Login/register_page.dart';
import 'package:faal/views/responses/wait_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../utils/text_styles.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/text_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPass = true;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) {
        if (_.isLoadingSocial!) {
          return const Scaffold(
            body: Center(
              child: WaitPage(),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 40,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    Image.asset('assets/logo.png'),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Inicia sesión',
                        textAlign: TextAlign.center,
                        style: titleDetail,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextInputField(
                      labelText: 'EMAIL',
                      controller: _emailController,
                      errorText: _.textValidateEmail,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      visibleText: false,
                      isPass: false,
                    ),
                    const SizedBox(height: 10),
                    TextInputField(
                      labelText: 'CONTRASEÑA',
                      controller: _passwordController,
                      errorText: _.textValidatePassword,
                      textInputAction: TextInputAction.next,
                      function: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                      inputType: TextInputType.name,
                      visibleText: showPass,
                      isPass: true,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.off(() => const RegisterPage());
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '¿Aún no tienes cuenta?',
                              style: richTextStyle,
                            ),
                            TextSpan(
                              text: ' Registrate',
                              style: richUrlTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 70,
                    // ),
                    // ButtonSecondaryIcon(
                    //   title: 'Continuar con Facebook',
                    //   path: 'assets/fbb.svg',
                    //   padding: 5,
                    //   height: 35,
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
                    const Spacer(
                      flex: 3,
                    ),
                    const SizedBox(height: 40),
                    ButtonPrimary(
                      title: 'Entrar',
                      onPressed: () async {
                        var response = await _.loginWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (response) {
                          Get.back();
                          Get.back();
                        }
                      },
                      load: _.isLoading!,
                      disabled: _.isLoading!,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'PREFERENCIAS DE PRIVACIDAD',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: kredDesensa,
        ),
      ),
    );
  }
}
