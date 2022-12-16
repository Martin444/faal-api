import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/user_model.dart';
import '../services/login_services.dart';
import '../services/upload_service.dart';
import '../views/Login/login_page.dart';
import 'notifications_controllers.dart';

class LoginController extends GetxController {
  UserModel? userData;

  String? _textValidateEmail;
  String? get textValidateEmail => _textValidateEmail;
  String? _textValidatePassword;
  String? get textValidatePassword => _textValidatePassword;
  String? _textConfirmPassword;
  String? get textConfirmPassword => _textConfirmPassword;

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  final bool _isLoadingSocial = false;
  bool? get isLoadingSocial => _isLoadingSocial;

  bool? _isLoadingPage = true;
  bool? get isLoadingPage => _isLoadingPage;

  String? _accessTokenID;
  String? get accessTokenID => _accessTokenID;

  LoginServices getService = LoginServices();
  UploadService serviceUp = UploadService();
  var notifyPermision = Get.find<NotificationsControllers>();

  File? _photoTaked;
  File? get photoTaked => _photoTaked;

  File? _photoProfile;
  File? get photoProfile => _photoProfile;

  @override
  void onInit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    super.onInit();
    _textValidateEmail = null;
    _textValidatePassword = null;
    _isLoading = false;
    _accessTokenID = pref.getString('accessTokenID');
    if (_accessTokenID != null) {
      validateUserInit(_accessTokenID!);
    } else {
      _isLoadingPage = false;
      update();
    }
  }

  validateUserInit(String token) async {
    try {
      var getUserResponse = await getService.getDataUser(_accessTokenID!);
      if (getUserResponse.statusCode == 401) {
        _isLoadingPage = false;
        logOut();
      } else if (getUserResponse.statusCode == 404) {
        _isLoadingPage = false;
        logOut();
      }
      _isLoadingPage = false;
      printInfo(info: 'E =========${getUserResponse.body}');
      var parseJson = jsonDecode(getUserResponse.body);
      userData = UserModel(
        id: parseJson['id'],
        photoUrl: parseJson['photoURL'],
        name: parseJson['name'],
        email: parseJson['email'],
        role: parseJson['role'],
      );
      update();
    } catch (e) {
      printError(info: 'ERRR =========$e');
      throw Exception(e);
    }
  }

  bool validateEmail(String email) {
    if (email.isEmpty || email.isEmpty) {
      _textValidateEmail = 'Este campo es obligatorio';
      update();
      return false;
    } else {
      var cvalid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(email);

      if (cvalid) {
        _textValidateEmail = null;
        update();
        return true;
      } else {
        _textValidateEmail = 'Por favor, introduzca una dirección de correo';
        update();
        return false;
      }
    }
  }

  bool validatepassword(String password) {
    // ignore: prefer_is_empty
    if (password.length == 0 || password.isEmpty) {
      _textValidatePassword = 'Este campo es obligatorio';
      update();
      return false;
    } else {
      var cvalid = password.length >= 4;

      if (cvalid) {
        _textValidatePassword = null;
        update();
        return true;
      } else {
        _textValidatePassword = 'Utiliza 8 carácteres como mínimo';
        update();
        return false;
      }
    }
  }

  // Login social

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> loginWhitGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      var result = await _auth.signInWithCredential(credential);
      printInfo(info: 'Soy el user ${result.user}');
      await validatingUserSocial(result.user!);
      return result.user!.displayName == null ? false : true;
    } catch (e) {
      GoogleSignIn().signOut();
      GoogleSignIn().disconnect();
      printError(info: 'Google err ${e.toString()}');

      return false;
    }
  }

  // Future<bool> loginwithFacebook() async {
  //   try {
  //     final LoginResult? result = await FacebookAuth.instance.login();
  //     printInfo(info: result!.accessToken!.token.toString());
  //     switch (result.status) {
  //       case LoginStatus.success:
  //         try {
  //           _isLoadingSocial = true;
  //           update();
  //           final AuthCredential facebookCredential =
  //               FacebookAuthProvider.credential(
  //             result.accessToken!.token,
  //           );
  //           final userCredential =
  //               await _auth.signInWithCredential(facebookCredential);
  //           await validatingUserSocial(userCredential.user!);
  //           return true;
  //         } on FirebaseAuthException catch (e) {
  //           printError(info: e.code.toString());
  //           if (e.code == 'account-exists-with-different-credential') {
  //             Get.showSnackbar(
  //               const GetSnackBar(
  //                 message: 'Ya existe una cuenta con este email',
  //                 duration: Duration(seconds: 2),
  //               ),
  //             );
  //           } else {
  //             Get.showSnackbar(
  //               GetSnackBar(
  //                 message: e.message,
  //                 duration: const Duration(seconds: 2),
  //               ),
  //             );
  //           }
  //           _isLoadingSocial = false;
  //           update();
  //           return false;
  //         }
  //       case LoginStatus.cancelled:
  //         return false;
  //       case LoginStatus.failed:
  //       default:
  //         return false;
  //     }
  //   } catch (e) {
  //     printError(info: e.toString());
  //     return false;
  //   }
  // }

  Future<bool> validatingUserSocial(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var resopnse = await getService.loginSocial(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        photoURL: user.photoURL,
      );
      printInfo(info: user.toString());
      var jsonResponse = jsonDecode(resopnse.body);
      _accessTokenID = jsonResponse['access_token'];
      prefs.setString('accessTokenID', _accessTokenID!);
      validateUserInit(_accessTokenID!);
      // _isLoadingSocial = false;
      update();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var emailValidator = validateEmail(email);
    var passValidator = validatepassword(password);

    if (emailValidator && passValidator) {
      try {
        var response = await getService.login(email, password);

        if (response.statusCode == 201) {
          _textValidateEmail = null;
          var jsonResponse = jsonDecode(response.body);
          _accessTokenID = jsonResponse['access_token'];
          prefs.setString('accessTokenID', _accessTokenID!);

          validateUserInit(_accessTokenID!);
          _isLoading = false;
          update();
          return true;
        } else if (response.statusCode == 500) {
          _textValidateEmail = 'Hubo un error interno';
          _isLoading = false;
          update();
          return false;
        } else if (response.statusCode == 400) {
          _textValidatePassword = 'Contraseña incorrecta';
          _isLoading = false;
          update();
          return false;
        } else {
          _textValidateEmail = 'Dirección de correo o contraseña inválida';
          _isLoading = false;
          update();
          return false;
        }
      } catch (e) {
        _isLoading = false;
        printError(
          info: '$e',
        );
        return false;
      }
      // print(respons);
    } else {
      _isLoading = false;
      HapticFeedback.vibrate();
      return false;
    }
  }

  Future<bool> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accessTokenID');
    _accessTokenID = null;
    userData = null;
    update();
    return true;
  }

  //compare password
  bool comparePassword(String password, String password2) {
    if (password == password2) {
      return true;
    } else {
      return false;
    }
  }

  var notifiController = Get.find<NotificationsControllers>();

  Future<bool> registerEmailAndPassword(
    String name,
    String email,
    String password,
    String password2,
  ) async {
    _isLoading = true;
    _textConfirmPassword = null;
    _textValidateEmail = null;
    _textValidatePassword = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var emailValidator = validateEmail(email);
    var passValidator = validatepassword(password);
    var pass2Validator = comparePassword(password, password2);

    if (emailValidator && passValidator) {
      if (pass2Validator) {
        try {
          dynamic urlImage;
          if (_photoProfile != null) {
            urlImage = await addPhotoServer(_photoProfile!);
          } else {
            urlImage = {'status': 200, 'body': 'none'};
          }

          if (urlImage['status'] == 200) {
            var register = await notifiController.registerOnFirebase();
            var response = await getService.register(
              photoURL: urlImage['body'],
              name: name,
              email: email,
              password: password,
              confirmPassword: password2,
              tokenFMC: register,
            );
            var jsonResponse = jsonDecode(response.body);
            printInfo(info: jsonResponse.toString());
            if (jsonResponse['access_token'] != null) {
              _textValidateEmail = null;
              _accessTokenID = jsonResponse['access_token'];
              prefs.setString('accessTokenID', _accessTokenID!);

              validateUserInit(_accessTokenID!);
              _isLoading = false;
              resetPhotoTaked();
              update();
              return true;
            } else if (response.statusCode == 500) {
              _textValidateEmail = 'Hubo un error interno';
              _isLoading = false;
              update();
              return false;
            } else if (response.statusCode == 400) {
              _textValidatePassword = 'Contraseña incorrecta';
              _isLoading = false;
              update();
              return false;
            } else if (response.body ==
                '{"message":"Error creando el usuario"}') {
              printInfo(info: response.body.runtimeType.toString());
              _textValidateEmail = 'Este correo ya fue registrado';
              _isLoading = false;
              update();
              return false;
            } else {
              printInfo(info: response.body.toString());
              _textValidateEmail = 'Dirección de correo o contraseña inválida';
              _isLoading = false;
              update();
              return false;
            }
          } else {
            Get.showSnackbar(
              const GetSnackBar(
                message: 'Hubo un error al subir tu foto de perfil',
                duration: Duration(seconds: 2),
              ),
            );
            return false;
          }
        } catch (e) {
          _isLoading = false;

          printError(
            info: '$e hola',
          );
          return false;
        }
      } else {
        _isLoading = false;
        _textConfirmPassword = 'Las contraseñas no coinciden';
        update();
        return false;
      }
    } else {
      _isLoading = false;
      return false;
    }
  }

  uploadPhotoProfile() async {
    Get.back();
    var piker = ImagePicker();
    var res = await piker.pickImage(
      source: ImageSource.gallery,
    );
    var foto = File(res!.path);
    _photoProfile = foto;
    printInfo(info: 'INfo foto $_photoProfile');
    update();
    // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // var foto = File(image!.path);
    // _photoProfile = foto;
  }

  uploadProfile() {
    Get.back();
    _photoProfile = _photoTaked;
    update();
    Timer(
      const Duration(milliseconds: 500),
      () {
        _photoTaked = null;
      },
    );
  }

  takePicture(XFile photo) async {
    var newPhoto = File(photo.path);
    _photoTaked = newPhoto;
    update();
  }

  takeAgain() {
    _photoTaked = null;
    update();
  }

  resetPhotoTaked() {
    _photoTaked = null;
    _photoProfile = null;
  }

  Future<dynamic> addPhotoServer(File photo) async {
    try {
      var response = await serviceUp.uploadFIle(photo);
      var jsonResponse = jsonDecode(response.toString());
      return jsonResponse;
    } catch (e) {
      printError(info: 'Error upload image $e');
      throw Exception(e);
    }
  }

  // Recovery password
  int? codeRecovery = 0;
  String? emailError;
  bool? enableEmailInput = false;

  bool? isOtpMode = false;
  bool? isSendEmailVer = false;

  void validateInputEmail(String email) {
    var emailV = validateEmail(email);
    printInfo(info: 'SOy $emailV');
    if (emailV) {
      enableEmailInput = true;
      update();
    } else {
      enableEmailInput = false;
      update();
    }
  }

  int generateCodeRandom() {
    var codeAlt = Random().nextInt(8999) + 1000;

    if (codeAlt.toString().length == 4 && !codeAlt.isNegative) {
      return codeAlt;
    } else {
      var codeAlt2 = Random().nextInt(8999) + 1000;
      return codeAlt2;
    }
  }

  void validateEmailForRecovery(String email) async {
    isSendEmailVer = true;
    enableEmailInput = false;
    update();
    var codeGen = generateCodeRandom();
    printInfo(info: 'El codigo es $codeGen');
    var response = await getService.findEmailforRecovery(
      email,
      codeGen.toString(),
    );
    var respJson = jsonDecode(response.body);
    printInfo(info: respJson.toString());
    printInfo(info: 'error? ${!respJson['error']}');

    if (!respJson['error']) {
      isSendEmailVer = false;
      isOtpMode = true;
      codeRecovery = codeGen;
      emailError = null;
      update();
    } else {
      isSendEmailVer = false;
      emailError = respJson['message'];
      enableEmailInput = true;
      update();
    }
  }

  bool? isRecoveryMode = false;
  String? otpCodeError;

  void compareOtpCode(String code) {
    var compare = code.compareTo(codeRecovery!.toString());
    printInfo(info: 'Se parecen? $compare');
    if (compare == 0) {
      isRecoveryMode = true;
      otpCodeError = null;
      update();
    } else {
      otpCodeError = 'Código incorrecto';
      update();
    }
  }

  bool? isResponseMode = false;
  String? errorPasswordChange;

  void changePassword(
    String email,
    String password,
    String password2,
  ) async {
    var pass2Validator = comparePassword(password, password2);

    if (pass2Validator) {
      var responsePass = await getService.changePassword(email, password);
      var respJsonPass = jsonDecode(responsePass.body);
      printInfo(info: 'Combio $pass2Validator');
      if (!respJsonPass['error']) {
        errorPasswordChange = null;
        isResponseMode = true;
        update();
      }
    } else {
      errorPasswordChange = 'Las contraseñas no coinciden';
      update();
    }
  }

  void initialSesion() {
    isOtpMode = false;
    isRecoveryMode = false;
    isResponseMode = false;
    update();
    Get.off(() => const LoginPage());
  }
}
