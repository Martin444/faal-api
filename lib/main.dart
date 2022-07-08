import 'package:faal/controllers/cart_list_controller.dart';
import 'package:faal/controllers/products_controller.dart';
import 'package:faal/controllers/scroll_controllers.dart';
import 'package:faal/controllers/search_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controllers/categories_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/order_controller.dart';
import 'controllers/upload_controller.dart';
import 'views/home/home_page.dart';

Future<void> _firebaseMessaginBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessaginBackgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: true,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<ProductsController>(ProductsController());

    Get.put<ScrollControllers>(ScrollControllers());

    Get.put<CartListController>(CartListController());

    Get.put<SearchController>(SearchController());

    Get.put<LoginController>(LoginController());

    Get.put<UploadController>(UploadController());

    Get.put<CategoriesController>(CategoriesController());

    Get.put<OrderController>(OrderController());

    return const GetMaterialApp(
      title: 'F.A.A.L',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
