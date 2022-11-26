import 'package:faal_new2/controllers/navigations_controller.dart';
import 'package:faal_new2/views/index_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controllers/address_controller.dart';
import 'controllers/cart_list_controller.dart';
import 'controllers/categories_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/notifications_controllers.dart';
import 'controllers/order_controller.dart';
import 'controllers/products/products_controller.dart';
import 'controllers/scroll_controllers.dart';
import 'controllers/search_controller.dart';
import 'controllers/upload_controller.dart';

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
    Get.put<NavigationsControllers>(NavigationsControllers());

    Get.put<ScrollControllers>(ScrollControllers());

    Get.put<CartListController>(CartListController());

    Get.put<SearchController>(SearchController());

    Get.put<NotificationsControllers>(NotificationsControllers());

    Get.put<LoginController>(LoginController());

    Get.put<AddressController>(AddressController());

    Get.put<UploadController>(UploadController());

    Get.put<CategoriesController>(CategoriesController());

    Get.put<OrderController>(OrderController());

    return const GetMaterialApp(
      title: 'F.A.A.L',
      debugShowCheckedModeBanner: false,
      home: IndexView(),
    );
  }
}
