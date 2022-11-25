import 'package:faal_new2/views/Login/login_page.dart';
import 'package:faal_new2/widgets/anim/delayed_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../controllers/upload_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/text_input_field.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecoveryPasswordPageState createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpCodeController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _rePassController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
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
                          !_.isOtpMode!
                              ? Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        'Recuperá tu contraseña',
                                        textAlign: TextAlign.center,
                                        style: titleAppBar,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextInputField(
                                      labelText: 'INGRESA TU EMAIL',
                                      controller: _emailController,
                                      inputType: TextInputType.emailAddress,
                                      functionSubmited: (val) {
                                        _.validateInputEmail(val);
                                      },
                                      onFunctionSubmited: (val) {
                                        _.validateEmailForRecovery(
                                          _emailController.text,
                                        );
                                      },
                                      errorText: _.emailError,
                                      textInputAction: TextInputAction.done,
                                      visibleText: false,
                                      isPass: false,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : !_.isRecoveryMode!
                                  ? Column(
                                      children: [
                                        DelayedReveal(
                                          delay:
                                              const Duration(milliseconds: 300),
                                          child: Center(
                                            child: Text(
                                              'Enviamos un email a ${_emailController.text.toUpperCase()} con el código de recuperación de contraseña',
                                              textAlign: TextAlign.center,
                                              style: titleAppBar,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        DelayedReveal(
                                          delay:
                                              const Duration(milliseconds: 600),
                                          child: TextInputField(
                                            labelText: 'INGRESA TU CÓDIGO',
                                            controller: _otpCodeController,
                                            inputType: TextInputType.number,
                                            errorText: _.otpCodeError,
                                            onFunctionSubmited: (v) {
                                              _.compareOtpCode(
                                                _otpCodeController.text,
                                              );
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            visibleText: false,
                                            isPass: false,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                  : !_.isResponseMode!
                                      ? Column(
                                          children: [
                                            DelayedReveal(
                                              delay: const Duration(
                                                  milliseconds: 300),
                                              child: Center(
                                                child: Text(
                                                  'Elige una nueva contraseña para tu cuenta',
                                                  textAlign: TextAlign.center,
                                                  style: titleAppBar,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            DelayedReveal(
                                              delay: const Duration(
                                                  milliseconds: 600),
                                              child: TextInputField(
                                                labelText: 'NUEVA CONTRASEÑA',
                                                controller: _passController,
                                                inputType: TextInputType
                                                    .visiblePassword,
                                                errorText: _.textValidateEmail,
                                                textInputAction:
                                                    TextInputAction.done,
                                                function: () {
                                                  setState(() {
                                                    showPass = !showPass;
                                                  });
                                                },
                                                visibleText: showPass,
                                                isPass: true,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            DelayedReveal(
                                              delay: const Duration(
                                                  milliseconds: 600),
                                              child: TextInputField(
                                                labelText:
                                                    'REPITE NUEVA CONTRASEÑA',
                                                controller: _rePassController,
                                                inputType: TextInputType
                                                    .visiblePassword,
                                                errorText:
                                                    _.errorPasswordChange,
                                                textInputAction:
                                                    TextInputAction.done,
                                                function: () {
                                                  setState(() {
                                                    showPass = !showPass2;
                                                  });
                                                },
                                                visibleText: showPass2,
                                                isPass: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Center(
                                              child: SvgPicture.asset(
                                                'assets/okeylogo.svg',
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            DelayedReveal(
                                              delay: const Duration(
                                                  milliseconds: 300),
                                              child: Center(
                                                child: Text(
                                                  '¡Tu contraseña fue cambiada con éxito!',
                                                  textAlign: TextAlign.center,
                                                  style: titleAppBar,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                          const Spacer(
                            flex: 3,
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
                    child: !_.isOtpMode!
                        ? ButtonPrimary(
                            title: 'Enviar',
                            onPressed: () async {
                              _.validateEmailForRecovery(_emailController.text);
                            },
                            load: _.isSendEmailVer!,
                            disabled: !_.enableEmailInput!,
                          )
                        : !_.isRecoveryMode!
                            ? ButtonPrimary(
                                title: 'Enviar código',
                                onPressed: () async {
                                  _.compareOtpCode(_otpCodeController.text);
                                },
                                load: _.isSendEmailVer!,
                                disabled: _.isLoading!,
                              )
                            : !_.isResponseMode!
                                ? ButtonPrimary(
                                    title: 'Cambiar contraseña',
                                    onPressed: () async {
                                      _.changePassword(
                                        _emailController.text,
                                        _passController.text,
                                        _rePassController.text,
                                      );
                                    },
                                    load: _.isSendEmailVer!,
                                    disabled: _.isLoading!,
                                  )
                                : ButtonPrimary(
                                    title: 'Iniciar sesión',
                                    onPressed: () async {
                                      _.initialSesion();
                                    },
                                    load: _.isSendEmailVer!,
                                    disabled: _.isLoading!,
                                  ),
                  ),
                ],
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
