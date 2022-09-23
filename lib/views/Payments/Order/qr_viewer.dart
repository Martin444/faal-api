import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Models/order_model.dart';

// ignore: must_be_immutable
class QrViewerData extends StatelessWidget {
  OrderModel? orde;

  QrViewerData({
    Key? key,
    required this.orde,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(250),
      painter: QrPainter(
        data: orde!.id!,
        version: QrVersions.auto,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Colors.black,
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Colors.black,
        ),
        // size: 320.0,
        // embeddedImage: snapshot.data,
        // embeddedImageStyle: QrEmbeddedImageStyle(
        //   size: Size.square(60),
        // ),
      ),
    );
  }
}
