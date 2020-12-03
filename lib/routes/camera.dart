import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

List<CameraDescription> cameras;

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    availableCameras().then((result) {
      setState(() {
        cameras = result;
        controller = CameraController(cameras[0], ResolutionPreset.high);
      });
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Scaffold();
    } else {
      print(controller);
      if (!controller.value.isInitialized) {
        return Container();
      }
      return Column(
        children: [
          Stack(alignment: Alignment.center, children: [
            AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
            // Positioned.fromRect(rect: Rect.fromLTRB(100.0, 100.0, 100.0, 100.0), child: Container(color: Colors.pink))
            Container(
              child: CustomPaint(),
              width: 400.0,
              height: 50.0,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
            )
          ]),
          Container(
            child: Center(
              child: RaisedButton(
                child: Icon(Icons.camera),
                onPressed: () async {
                  try {
                    final path = join(
                      // Store the picture in the temp directory.
                      // Find the temp directory using the `path_provider` plugin.
                      (await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png',
                    );
                    await controller.takePicture(path);

                    File fileImage = File(path);
                    FirebaseVisionImage visionImage =
                        FirebaseVisionImage.fromFile(fileImage);

                    final TextRecognizer textRecognizer =
                        FirebaseVision.instance.textRecognizer();
                    final VisionText visionText =
                        await textRecognizer.processImage(visionImage);

                    // String text = visionText.text;

                    for (TextBlock block in visionText.blocks) {
                      final Rect boundingBox = block.boundingBox;
                      final List<Offset> cornerPoints = block.cornerPoints;
                      final String text = block.text;
                      print(text);
                      print(cornerPoints);
                      for (TextLine line in block.lines) {
                        // Same getters as TextBlock
                        for (TextElement element in line.elements) {
                          // Same getters as TextBlock
                        }
                      }
                    }

                    // List<TextBlock> blocks = visionText.blocks;
                    // for (var i = 0; i < blocks.length; i++) {
                    //   for (var j = 0; j < blocks[i].lines.length; j++) {
                    //     for (var k = 0;
                    //         k < blocks[i].lines[j].text.length;
                    //         k++) {
                    //       print(blocks[i].lines[j].text);
                    //     }
                    //   }
                    // }

                  } catch (err) {
                    print(err);
                  }
                },
              ),
            ),
          )
        ],
      );
    }
  }
}