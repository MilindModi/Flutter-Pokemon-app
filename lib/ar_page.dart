import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:camera/camera.dart';

class HelloWorld extends StatefulWidget {
  List<CameraDescription> cameras;

  String name;
  HelloWorld(this.cameras,this.name);

  @override
  _HelloWorldState createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  CameraController controller;

  @override
  void initState() {
    super.initState();

    controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: [
            Positioned(
                height: MediaQuery.of(context).size.height   ,
                width: MediaQuery.of(context).size.width ,
                child: CameraPreview(controller)
            ),
            Cube(
              onSceneCreated: (Scene scene) {
                scene.world.add(Object(fileName: "assets/"+widget.name+"/model.obj"));
                scene.camera.zoom = 5;
              },
            ),
          ],
        ));
  }
// return Scaffold(
//   body: Center(
//     child:CameraPreview(controller),
//     // Cube(
//     //   onSceneCreated: (Scene scene) {
//     //     scene.world.add(Object(fileName: 'assets/poke1/model.obj'));
//     //     scene.camera.zoom = 5;
//     //   },
//     // ),
//   ),
// );
}

// }
