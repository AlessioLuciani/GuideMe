import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ImageLoader extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return ImageLoaderState();
  }

}

class ImageLoaderState extends State<ImageLoader>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AddImageButtonPicker(),
          AddImageButtonPicker(),
          AddImageButtonPicker(),
        ],
      )
    );
  }
}

class AddImageButtonPicker extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddImageButtonPickerState();
  }

}


class AddImageButtonPickerState extends State<AddImageButtonPicker>{

  File _image;

  Future<bool> checkAndRequestCameraPermissions() async {
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.camera]);
      return permissions[PermissionGroup.camera] == PermissionStatus.granted;
    } else {
      return true;
    }
  }

  Future getImage() async {

    if (await checkAndRequestCameraPermissions()) {
      //var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
      //var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 100, maxHeight: 100);
      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery, 
          maxHeight: 120, 
          maxWidth: 120);
      setState(() {
        _image = image;
      });
    
    }

  }

  @override
  Widget build(BuildContext context) {
    if(this._image == null) {
      return IconButton(
          icon: Icon(Icons.add_a_photo),
          iconSize: 35,
          onPressed: getImage,
          tooltip: 'Pick Image',
        );
    }

    return Container(
      height: 200,
      width: 200,
      margin: EdgeInsets.only(top:5,bottom: 5),
      child: GestureDetector(
        onTap: getImage,
        child: Image.file(
          this._image,
          
          width: MediaQuery.of(context).size.width/2,

        ),
      ),
    );
  }
}