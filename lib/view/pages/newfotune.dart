import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/controller/FortunePathProvider.dart';
import 'package:example/util/cameraPreview.dart';
import 'package:example/values/theme.dart';
import 'package:example/view/dialogs.dart';
import 'package:example/view/loadingOverlay.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class NewFortuneTabWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NewFortuneTabState();
  }
}

class NewFortuneTabState extends State<NewFortuneTabWidget>
    with AutomaticKeepAliveClientMixin {
  List<CameraDescription> cameras;
  CameraController _controller;
  bool _isInited = false;
  var _provider;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _setupCameras();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        _setupCameras();
      }
    }
  }

  void _setupCameras() async {
    try {
      cameras = await availableCameras();
      _controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await _controller.initialize();
      _controller.initialize().then((value) => {
            setState(() {
              _isInited = true;
            })
          });
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) return;
    setState(() {
      _isInited = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    this._provider = Provider.of<FortunePathProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _fortuneBtn(context, _provider, 1),
                  _fortuneBtn(context, _provider, 2),
                  _fortuneBtn(context, _provider, 3),
                ],
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(lightpink),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white)))),
                  onPressed: () async {
                    uploadImageToFirebase(context);
                  },
                  child: const Text(
                    'send',
                    style: TextStyle(color: white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _fortuneBtn(
      BuildContext context, FortunePathProvider provider, int id) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            border: Border.all()),
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 3,
        child: IconButton(
          icon: (_provider.fortunePath(id).toString().isNotEmpty)
              ? Image.file(File(_provider.fortunePath(id)))
              : const Icon(
                  Icons.add,
                  color: Colors.cardBlueValue,
                ),
          iconSize: MediaQuery.of(context).size.width / 6,
          onPressed: () {
            _buildPopupDialog(context, id);
          },
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: bckgroundColor_blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: cardBlue, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: const Text('Kahveeee',
                              style: TextStyle(color: white)))),
                  CamerePreview(_isInited, _controller, context),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: new TextButton(
                      onPressed: () async {
                        await _controller.takePicture().then((value) {
                          _provider.setImagePath(value.path, id);
                          Navigator.of(context).pop();
                          setState(() {});
                        });
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName;
    final overlay = LoadingOverlay.of(context);
    List<String> imagePathList = _provider.imagePaths();
    if (imagePathList.contains('')) {
      alertMissingImageDialog(context);
    } else {
      overlay.show();
      String firebaseDataName = 'fortunes/' +
          _provider.getUserPhoneId().toString() +
          '_' +
          DateTime.now().toString();
      for (int i = 0; i < 3; i++) {
        fileName = basename(File(imagePathList[i]).path);
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(firebaseDataName + '/$fileName');
        TaskSnapshot snapshot = await ref.putFile(File(imagePathList[i]));
        if (snapshot.state == TaskState.success && i == 2) {
          overlay.showAlertSucces(context);
          if (_provider.imagePaths() != null &&
              _provider.imagePaths().length > 0 &&
              !_provider.imagePaths().contains('')) {
            _provider.setFortunePathEmpty();
          }
        }
      }
    }
  }
}
