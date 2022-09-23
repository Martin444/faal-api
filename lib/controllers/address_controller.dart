import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/address_model.dart';
import '../services/address_services.dart';
import '../widgets/congrats_modal.dart';
import 'login_controller.dart';

class AddressController extends GetxController {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  var userToken = Get.find<LoginController>();
  @override
  onInit() {
    super.onInit();
    _handlePermission();
  }

  _handlePermission() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
      printInfo(info: serviceEnabled.toString());
      if (!serviceEnabled) {
        permission = await _geolocatorPlatform.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await _geolocatorPlatform.requestPermission();
          printInfo(info: permission.toString());
        }
      }
      Position position = await Geolocator.getCurrentPosition();
      if (position != null) {
        printInfo(info: position.toString());
        addressLocation = LatLng(position.latitude, position.longitude);
        update();
      }
      printInfo(info: position.latitude.toString());
    } catch (e) {
      await _geolocatorPlatform.requestPermission();
      throw Exception(e);
    }
  }

  // DIRECTIONS ¿

  LatLng addressLocation = const LatLng(0, 0);
  GoogleMapController? mycontrollerMap;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var addressService = AddresServices();
  var myAddressSelected = AddressModel();
  bool modeSearch = true;
  bool isSave = false;

  var countryController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();
  var postalCodeController = TextEditingController();

  String? countryErrorText;
  String? cityErrorText;
  String? addressErrorText;
  String? postalCodeErrorText;

  void searchAddress(String? searcher) async {
    var response = await addressService.searchAddressLocations(searcher);
    if (response.isNotEmpty) {
      printInfo(info: mycontrollerMap.toString());
      addressLocation = LatLng(response[0].latitude, response[0].longitude);
      mycontrollerMap?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: addressLocation,
            zoom: 18,
          ),
        ),
      );
      _add();
      update();
    }
    var details = await addressService.searchAddressDetails(response);
    myAddressSelected = AddressModel(
      country: details[0].country,
      city: details[0].locality,
      address: details[0].street,
      codepostal: details[0].postalCode,
      // location: addressLocation,
    );
    modeSearch = false;
    update();
  }

  void _add() {
    const MarkerId markerId = MarkerId('local11');

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: addressLocation,
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );

    // adding a new marker to map
    markers[markerId] = marker;
  }

  void updateMyControllerMap(GoogleMapController? controller) {
    mycontrollerMap = controller;
    update();
  }

  bool getMyLocation = false;

  useMyLocation() async {
    try {
      getMyLocation = true;
      // update();
      Position position = await Geolocator.getCurrentPosition();
      if (position != null) {
        addressLocation = LatLng(position.latitude, position.longitude);
        var mydetail = await addressService.searchDetailsOneLocation(
          addressLocation,
        );
        countryController.text = mydetail[0].country!;
        cityController.text = mydetail[0].locality!;
        addressController.clear();
        if (mydetail[0].locality == 'Tartagal') {
          postalCodeController.text = '4560';
        } else {
          postalCodeController.text = mydetail[0].postalCode!;
        }
        myAddressSelected = AddressModel(
          country: mydetail[0].country,
          city: mydetail[0].locality,
          address: mydetail[0].street,
          codepostal: mydetail[0].postalCode,
          // location: addressLocation,
        );
        modeSearch = false;
        getMyLocation = false;

        // _add();
        update();
      }
    } catch (e) {
      await _geolocatorPlatform.requestPermission();
    }
  }

  void saveAddress() async {
    isSave = true;
    update();
    if (countryController.text.isEmpty) {
      countryErrorText = 'Por favor, ingresa un país válido';
    } else if (cityController.text.isEmpty) {
      cityErrorText = 'Por favor, ingresa una ciudad válida';
    } else if (addressController.text.isEmpty) {
      addressErrorText = 'Por favor, ingerse una dirección válida';
      isSave = false;
    } else if (postalCodeController.text.isEmpty) {
      postalCodeErrorText = 'Por favor, ingrese un código postal';
      update();
    } else {
      countryErrorText = null;
      cityErrorText = null;
      addressErrorText = null;
      postalCodeErrorText = null;
      myAddressSelected = AddressModel(
        country: countryController.text,
        city: cityController.text,
        address: addressController.text,
        codepostal: postalCodeController.text,
        // location: addressLocation,
      );
      update();

      var response = await addressService.saveNewAddress(
        address: myAddressSelected,
        token: userToken.accessTokenID!,
      );
      if (response.statusCode == 201) {
        isSave = false;
        update();
        findMyAddress();
        Get.dialog(CongratsModal(
          message: 'Tu dirección se guardó con éxito',
          onPressed: () {
            Get.back();
            Get.back();
          },
        ));
      }
    }
  }

  // Find my address
  var myAddresses = <AddressModel>[];

  void findMyAddress() async {
    if (userToken.accessTokenID != null) {
      myAddresses = [];
      var response = await addressService.getMyAddress(
        token: userToken.accessTokenID,
      );

      if (response.statusCode == 200) {
        var jsonConver = jsonDecode(response.body);
        jsonConver.forEach((e) {
          printInfo(info: e['id']);
          myAddresses.add(AddressModel(
            id: e['id'],
            country: e['country'],
            city: e['city'],
            address: e['address1'],
            codepostal: e['cpcode'].toString(),
            // location: LatLng(e['lat'], e['long']),
          ));
        });
        update();
      }
    }
  }
}
