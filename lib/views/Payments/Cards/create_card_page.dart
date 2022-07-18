// import 'package:faal/utils/colors.dart';
// import 'package:faal/views/responses/wait_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:get/get.dart';

// import '../../../controllers/order_controller.dart';
// import '../../../widgets/anim/delayed_reveal.dart';
// import '../../../widgets/button_primary.dart';

// class CreateCardPage extends StatefulWidget {
//   const CreateCardPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _CreateCardPageState createState() => _CreateCardPageState();
// }

// class _CreateCardPageState extends State<CreateCardPage> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   void onCreditCardModelChange(CreditCardModel? creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel!.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OrderController>(
//       builder: (_) {
//         if (_.isLoadCard!) {
//           return Scaffold(
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Center(
//                   child: DelayedReveal(
//                     delay: Duration(milliseconds: 100),
//                     child: WaitPage(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 DelayedReveal(
//                   delay: Duration(milliseconds: 200),
//                   child: Text('Espera un momento'),
//                 )
//               ],
//             ),
//           );
//         } else {
//           return Scaffold(
//             appBar: AppBar(
//               systemOverlayStyle: const SystemUiOverlayStyle(
//                 statusBarBrightness: Brightness.dark,
//                 statusBarIconBrightness: Brightness.dark,
//                 statusBarColor: Colors.transparent,
//                 systemNavigationBarContrastEnforced: true,
//               ),
//               foregroundColor: Colors.black,
//               backgroundColor: Colors.white,
//               elevation: 0,
//               title: const Text(
//                 'Agrega una tarjeta',
//                 style: TextStyle(
//                     // fontFamily: 'halter',
//                     // fontSize: 16,
//                     // package: 'flutter_credit_card',
//                     ),
//               ),
//               centerTitle: true,
//             ),
//             body: SafeArea(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 290,
//                     child: DelayedReveal(
//                       delay: const Duration(milliseconds: 200),
//                       child: CreditCardWidget(
//                         height: 270,
//                         glassmorphismConfig: useGlassMorphism
//                             ? Glassmorphism.defaultConfig()
//                             : null,
//                         cardNumber: cardNumber,
//                         cardBgColor: kYellow.withOpacity(0.4),
//                         textStyle: const TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'halter',
//                           fontSize: 16,
//                           package: 'flutter_credit_card',
//                         ),
//                         labelCardHolder: 'Nombre del titular',
//                         expiryDate: expiryDate,
//                         cardHolderName: cardHolderName,
//                         cvvCode: cvvCode,
//                         showBackView: isCvvFocused,
//                         obscureCardNumber: true,
//                         obscureCardCvv: true,
//                         isHolderNameVisible: true,
//                         isSwipeGestureEnabled: true,
//                         onCreditCardWidgetChange:
//                             (CreditCardBrand creditCardBrand) {},
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           DelayedReveal(
//                             delay: const Duration(
//                               milliseconds: 300,
//                             ),
//                             child: CreditCardForm(
//                               formKey: _formKey,
//                               obscureCvv: true,
//                               obscureNumber: false,
//                               cardNumber: cardNumber,
//                               cvvCode: cvvCode,
//                               isHolderNameVisible: true,
//                               isCardNumberVisible: true,
//                               isExpiryDateVisible: true,
//                               cardHolderName: cardHolderName,
//                               expiryDate: expiryDate,
//                               themeColor: kredDesensa,
//                               textColor: Colors.black,
//                               cardNumberDecoration: const InputDecoration(
//                                 labelText: 'Número de la tarjeta',
//                                 hintText: 'XXXX XXXX XXXX XXXX',
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 labelStyle: TextStyle(color: Colors.black),
//                               ),
//                               numberValidationMessage:
//                                   'Número de tarjeta inválido',
//                               expiryDateDecoration: InputDecoration(
//                                 hintStyle: const TextStyle(color: Colors.black),
//                                 labelStyle:
//                                     const TextStyle(color: Colors.black),
//                                 focusedBorder: border,
//                                 enabledBorder: border,
//                                 labelText: 'Fecha de expiración',
//                                 hintText: 'XX/XX',
//                               ),
//                               dateValidationMessage:
//                                   'Fecha de expiración inválida',
//                               cvvCodeDecoration: InputDecoration(
//                                 hintStyle: const TextStyle(color: Colors.black),
//                                 labelStyle:
//                                     const TextStyle(color: Colors.black),
//                                 focusedBorder: border,
//                                 enabledBorder: border,
//                                 labelText: 'CVV',
//                                 hintText: 'XXX',
//                               ),
//                               cvvValidationMessage: 'CVV inválido',
//                               cardHolderDecoration: InputDecoration(
//                                 hintStyle: const TextStyle(color: Colors.black),
//                                 labelStyle:
//                                     const TextStyle(color: Colors.black),
//                                 focusedBorder: border,
//                                 enabledBorder: border,
//                                 labelText: 'Nombre del titular',
//                               ),
//                               onCreditCardModelChange: onCreditCardModelChange,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: DelayedReveal(
//                       delay: const Duration(milliseconds: 400),
//                       child: ButtonPrimary(
//                         title: 'Guardar tarjeta',
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             _.tokenizedCard(
//                               cardNumber: cardNumber,
//                               cardExpiryDate: expiryDate,
//                               cardName: cardHolderName,
//                               cardCvv: cvvCode,
//                             );
//                           }
//                         },
//                         load: false,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
