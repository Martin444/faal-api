import 'package:faal/utils/styles_context.dart';
import 'package:faal/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/address_controller.dart';
import '../../../utils/colors.dart';
import '../../../widgets/anim/delayed_reveal.dart';
import '../../../widgets/button_primary.dart';
import '../../../widgets/text_input_field.dart';

class CreateAddressPage extends StatefulWidget {
  const CreateAddressPage({Key? key}) : super(key: key);

  @override
  State<CreateAddressPage> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: systemDart,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Crear dirección',
              style: titleAppBar,
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _.useMyLocation();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/location-marker.svg',
                              color: kpurplecolor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Usar mi ubicación actual',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kpurplecolor,
                              ),
                            ),
                          ],
                        ),
                        // RichText(
                        //   text: const TextSpan(
                        //     text: 'Agrega una dirección',
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                DelayedReveal(
                  delay: const Duration(milliseconds: 300),
                  child: TextInputField(
                    labelText: 'País',
                    controller: _.countryController,
                    inputType: TextInputType.name,
                    errorText: _.countryErrorText,
                    functionSubmited: (value) {
                      // _.searchAddress(value);
                    },
                    visibleText: false,
                    isPass: false,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 10),
                DelayedReveal(
                  delay: const Duration(milliseconds: 400),
                  child: TextInputField(
                    labelText: 'Ciudad',
                    controller: _.cityController,
                    inputType: TextInputType.name,
                    errorText: _.cityErrorText,
                    functionSubmited: (value) {
                      // _.searchAddress(value);
                    },
                    visibleText: false,
                    isPass: false,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 10),
                DelayedReveal(
                  delay: const Duration(milliseconds: 500),
                  child: TextInputField(
                    labelText: 'Dirección y altura',
                    controller: _.addressController,
                    inputType: TextInputType.streetAddress,
                    errorText: _.addressErrorText,
                    functionSubmited: (value) {
                      // _.searchAddress(value);
                    },
                    visibleText: false,
                    isPass: false,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 10),
                DelayedReveal(
                  delay: const Duration(milliseconds: 600),
                  child: TextInputField(
                    labelText: 'Código postal',
                    controller: _.postalCodeController,
                    inputType: TextInputType.number,
                    errorText: _.postalCodeErrorText,
                    functionSubmited: (value) {
                      // _.searchAddress(value);
                    },
                    visibleText: false,
                    isPass: false,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 20),
                // const DelayedReveal(
                //   delay: Duration(milliseconds: 700),
                //   child: MapViewer(),
                // ),
                const Spacer(),
                DelayedReveal(
                  delay: const Duration(milliseconds: 800),
                  child: _.modeSearch
                      ? ButtonPrimary(
                          title: 'Buscar dirección',
                          onPressed: () {
                            _.searchAddress(
                              '${_.countryController.text} ${_.cityController.text} ${_.addressController.text}',
                            );
                          },
                          load: false,
                        )
                      : ButtonPrimary(
                          title: 'Guardar dirección',
                          onPressed: () {
                            _.saveAddress();
                          },
                          load: _.isSave,
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
