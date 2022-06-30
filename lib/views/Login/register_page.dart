import 'package:camera/camera.dart';
import 'package:faal/utils/colors.dart';
import 'package:faal/views/Login/succes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../controllers/upload_controller.dart';
import '../../utils/text_styles.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/check_tile.dart';
import '../../widgets/text_input_field.dart';
import '../camera/simple_camera.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  var profile = Get.find<UploadController>();
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

  bool showPass = true;
  bool showPass2 = true;

  bool loadData = false;

  bool isPromo = false;
  bool isTerms = false;
  bool isCoocks = false;

  showdragphoto() {
    Get.dialog(
      GetBuilder<LoginController>(builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // color: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Subir foto',
                  style: titleDetail,
                ),
                const Divider(
                  height: 25,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _.uploadPhotoProfile();
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/galerybtn.svg'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Galería',
                            style: richTextStyle,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();

                        Get.to(
                          () => const SimpleCamera(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/camerabtn.svg'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Cámara',
                            style: richTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 20,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Center(
                          child: Text(
                            'Registrate',
                            textAlign: TextAlign.center,
                            style: titleAppBar,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _.photoProfile == null
                            ? Stack(
                                alignment: const Alignment(1.0, 1.1),
                                children: [
                                  SizedBox(
                                    height: 130,
                                    width: 130,
                                    child: TextButton(
                                      clipBehavior: Clip.hardEdge,
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                          Colors.white.withOpacity(0.3),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          kTextColorLigth.withOpacity(0.5),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white54,
                                        size: 90,
                                      ),
                                      onPressed: () {
                                        showdragphoto();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: TextButton(
                                      clipBehavior: Clip.hardEdge,
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                          Colors.white.withOpacity(0.2),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.black,
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        showdragphoto();
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  showdragphoto();
                                },
                                child: Stack(
                                  alignment: const Alignment(1.0, 1.1),
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: Hero(
                                        tag: 'photoTaked',
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.file(
                                            _.photoProfile!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: TextButton(
                                        clipBehavior: Clip.hardEdge,
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                            Colors.white.withOpacity(0.2),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.black,
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          showdragphoto();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        TextInputField(
                          labelText: 'NOMBRE Y APELLIDOS',
                          controller: _nameController,
                          inputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          visibleText: false,
                          isPass: false,
                        ),
                        TextInputField(
                          labelText: 'EMAIL',
                          controller: _emailController,
                          inputType: TextInputType.emailAddress,
                          errorText: _.textValidateEmail,
                          textInputAction: TextInputAction.next,
                          visibleText: false,
                          isPass: false,
                        ),
                        TextInputField(
                          labelText: 'CONTRASEÑA',
                          controller: _passwordController,
                          inputType: TextInputType.visiblePassword,
                          function: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          errorText: _.textValidatePassword,
                          textInputAction: TextInputAction.next,
                          visibleText: showPass,
                          isPass: true,
                        ),
                        TextInputField(
                          labelText: 'CONFIRMAR CONTRASEÑA',
                          controller: _confirmPasswordController,
                          textInputAction: TextInputAction.next,
                          errorText: _.textConfirmPassword,
                          inputType: TextInputType.name,
                          function: () {
                            setState(() {
                              showPass2 = !showPass2;
                            });
                          },
                          visibleText: showPass2,
                          isPass: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.off(() => const LoginPage());
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '¿Ya tienes cuenta?',
                                  style: richTextStyle,
                                ),
                                TextSpan(
                                  text: ' Inicia sesión',
                                  style: richUrlTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        CheckTile(
                          isChecked: isPromo,
                          onChecked: (value) {
                            setState(() {
                              isPromo = value!;
                            });
                          },
                          rich: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Quiero recibir notificaciones promocionales y novedades de F.A.A.L srl',
                                  style: richTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                        CheckTile(
                          isChecked: isTerms,
                          onChecked: (value) {
                            setState(() {
                              isTerms = value!;
                            });
                          },
                          rich: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'He leido y acepto las',
                                  style: richTextStyle,
                                ),
                                TextSpan(
                                  text: ' Condiciones de uso',
                                  style: richTextStyle,
                                ),
                                TextSpan(
                                  text: ' y la',
                                  style: richTextStyle,
                                ),
                                TextSpan(
                                  text: ' política de privacidad',
                                  style: richUrlTextStyle,
                                ),
                                TextSpan(
                                  text: ' de F.A.A.L srl',
                                  style: richTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ButtonPrimary(
                    title: 'Entrar',
                    onPressed: () async {
                      if (!_.isLoading!) {
                        var response = await _.registerEmailAndPassword(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                        );
                        printInfo(info: response.toString());
                        if (response == true) {
                          Get.to(
                            () => const SuccesPage(),
                          );
                        }
                      }
                    },
                    load: _.isLoading!,
                    disabled: _.isLoading!,
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

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.topLeft,
      child: Text(
        'Preferencias de privacidad',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: 'AvantGarde',
          color: kTextColorLigth,
        ),
      ),
    );
  }
}
