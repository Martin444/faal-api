import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/anim/delayed_reveal.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/button_with_line_black.dart';

class SimpleCamera extends StatefulWidget {
  const SimpleCamera({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SimpleCameraState createState() => _SimpleCameraState();
}

class _SimpleCameraState extends State<SimpleCamera> {
  CameraController? _controller;

  @override
  initState() {
    super.initState();
    // Trae y selecciona la primera camara disponible
    availableCameras().then((cameras) {
      printInfo(info: cameras.toString());
      if (cameras.isEmpty) {
      } else {
        _controller = CameraController(
          cameras[1],
          ResolutionPreset.medium,
          enableAudio: false,
        );
        _controller!.initialize().then((_) {
          if (!mounted) {
            return;
          }
          _controller!.setFlashMode(FlashMode.off);
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold();
    } else {
      return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          // Si no tomo la foto muesta vista de visualizacion sino la camara para tomar la foto
          if (_.photoTaked == null) {
            return Scaffold(
              appBar: AppBar(
                // automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Builder(
                    builder: (context) => const Text(
                      'Tomate una selfie',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                backgroundColor: Colors.black,
                elevation: 0,
                centerTitle: false,
                titleSpacing: 0,
              ),
              body: SizedBox(
                height: Get.height - 80,
                child: Stack(
                  // alignment: Alignment(8.0, 1.0),
                  children: [
                    CameraPreview(_controller!),
                    Positioned(
                      width: Get.width,
                      bottom: 0,
                      child: Container(
                        color: Colors.black,
                        height: 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: ShapeDecoration(
                                color: kredDesensa,
                                shape: const CircleBorder(),
                              ),
                              child: IconButton(
                                iconSize: 35,
                                color: Colors.white,
                                icon: const Icon(Icons.camera_alt),
                                onPressed: () {
                                  _controller!.takePicture().then(
                                        (value) => {
                                          _.takePicture(value),
                                        },
                                      );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Builder(
                    builder: (context) => Row(
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            "assets/back.svg",
                            height: 45,
                            width: 44,
                            color: Colors.black87,
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: false,
                titleSpacing: 0,
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    DelayedReveal(
                      delay: const Duration(milliseconds: 200),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Hero(
                          tag: 'photoTaked',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _.photoTaked!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DelayedReveal(
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        '¿Que te parece?',
                        style: titleSecundary,
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    DelayedReveal(
                      delay: const Duration(milliseconds: 400),
                      child: ButtonPrimary(
                        title: 'Continuar',
                        onPressed: () {
                          _.uploadProfile();
                        },
                        load: false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DelayedReveal(
                      delay: const Duration(milliseconds: 500),
                      child: ButtonWithLine(
                        title: 'Volver a tomar',
                        onPressed: () {
                          _.takeAgain();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    }
  }
}
