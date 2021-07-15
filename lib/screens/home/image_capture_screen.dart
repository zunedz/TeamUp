import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File? _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File? cropped = await ImageCropper.cropImage(
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: CropStyle.circle,
      sourcePath: _imageFile!.path,
      androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.purpleAccent,
          toolbarWidgetColor: Colors.white,
          toolbarTitle: 'Crop It'),
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    PickedFile? tempSelected = await ImagePicker().getImage(source: source);
    if (tempSelected != null) {
      File? selected = File(tempSelected.path);

      setState(() {
        _imageFile = selected;
      });

      _cropImage();
    }
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick a photo"),
      ),
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),

      // Preview the image and crop it
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ListView(
          children: <Widget>[
            if (_imageFile == null) ...[
              Image.asset('assets/images/default.png')
            ],
            if (_imageFile != null) ...[
              Image.file(_imageFile!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    child: Icon(Icons.delete),
                    onPressed: _clear,
                  ),
                ],
              ),
              Uploader(_imageFile!)
            ]
          ],
        ),
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;
  Uploader(this.file);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask? _uploadTask;

  /// Starts an upload task
  void _startUpload() {
    /// Unique file name for the file
    String filePath =
        'avatarImages/${FirebaseAuth.instance.currentUser!.uid}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      String filePath =
          'avatarImages/${FirebaseAuth.instance.currentUser!.uid}.png';

      /// Manage the task state and event subscription with a StreamBuilder
      return FutureBuilder(
          future: _storage.ref().child(filePath).getDownloadURL(),
          builder: (ctx, AsyncSnapshot<String> urlSnapshot) {
            return StreamBuilder(
                stream: _uploadTask!.snapshotEvents,
                builder: (_, AsyncSnapshot<TaskSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  var event = snapshot.data;
                  // print(event!.bytesTransferred / event.totalBytes);
                  double progressPercent = event != null
                      ? event.bytesTransferred / event.totalBytes
                      : 0;

                  if (snapshot.data!.state == TaskState.success &&
                      urlSnapshot.hasData) {
                    String avatarUrl = urlSnapshot.data!;
                    print(avatarUrl);
                    FirebaseFirestore.instance
                        .collection('appUser')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({'avatarUrl': avatarUrl});
                  }

                  return Column(
                    children: [
                      if (snapshot.data!.state == TaskState.success)
                        Text('Photo Uploaded!')
                      else if (snapshot.data!.state == TaskState.paused)
                        TextButton(
                          child: Icon(Icons.play_arrow),
                          onPressed: _uploadTask!.resume,
                        )
                      else if (snapshot.data!.state == TaskState.running)
                        TextButton(
                          child: Icon(Icons.pause),
                          onPressed: _uploadTask!.pause,
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      // Progress bar
                      LinearProgressIndicator(value: progressPercent),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${(progressPercent * 100).toStringAsFixed(0)} % '),
                    ],
                  );
                });
          });
    } else {
      // Allows user to decide when to start the upload
      return IconButton(
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
