import 'package:camera/camera.dart';
import 'package:example/controller/FortunePathProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Widget CamerePreview(bool isInited, CameraController controller, BuildContext context) {
  return Container(
    height:  MediaQuery.of(context).size.height/2 ,
    child: Center(
      child: Column(
        children: [
          Expanded(
            child: isInited
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  )
                : Container(),
          ),
        ],
      ),
    ),
  );
}
