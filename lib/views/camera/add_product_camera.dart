import 'package:camera/camera.dart';
import 'package:faal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/upload_controller.dart';
import '../../widgets/anim/delayed_reveal.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/button_with_line_black.dart';

class AddProductCamera extends StatefulWidget {
  const AddProductCamera({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddProductCameraState createState() => _AddProductCameraState();
}

class _AddProductCameraState extends State<AddProductCamera> {
  CameraController? _controller;

  @override
  initState() {
    super.initState();
    availableCameras().then((cameras) {
      if (cameras.isEmpty) {
      } else {
        _controller = CameraController(
          cameras[0],
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
      return GetBuilder<UploadController>(
        init: UploadController(),
        builder: (_) {
          if (_.photoTaked == null) {
            return Scaffold(
              appBar: AppBar(
                // automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Builder(
                    builder: (context) => const Text(
                      'Toma una foto',
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
                                color: Colors.black,
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
                            "assets/backicon.svg",
                            height: 15,
                            width: 34,
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
                    const Spacer(
                      flex: 1,
                    ),
                    DelayedReveal(
                      delay: const Duration(milliseconds: 200),
                      child: SizedBox(
                        height: 400,
                        width: Get.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _.photoTaked!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DelayedReveal(
                      delay: Duration(milliseconds: 300),
                      child: Text(
                        '¿Se ve bien?',
                        style: TextStyle(
                          fontSize: 21,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    DelayedReveal(
                      delay: const Duration(milliseconds: 400),
                      child: ButtonPrimary(
                        title: 'Guardar',
                        onPressed: () {
                          _.addPhotoToList();
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
