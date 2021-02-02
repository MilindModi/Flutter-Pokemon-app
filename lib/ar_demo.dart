import 'dart:math';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/services.dart';
class ARDemo extends StatefulWidget {
  @override
  _ARDemoState createState() => _ARDemoState();
}

class _ARDemoState extends State<ARDemo> {
  ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
        enablePlaneRenderer: true,
      ),
    );
  }
  _onArCoreViewCreated(ArCoreController localController) {
    arCoreController = localController;

    arCoreController.onPlaneTap = _onPlaneTap;
  }

  _onPlaneTap(List<ArCoreHitTestResult> hits) => _onHitDetected(hits.first);

  _onHitDetected(ArCoreHitTestResult plane) {
    arCoreController.addArCoreNodeWithAnchor(
      ArCoreReferenceNode(
        name: 'abc',
        object3DFileName:  "sceneModel.sfb",
        position: vector.Vector3(0.0, -0.5, -2.0),
        rotation: plane.pose.rotation,
      ),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}