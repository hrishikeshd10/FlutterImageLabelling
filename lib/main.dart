import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

void main() {
  runApp(CameraApp());
}

class CameraApp extends StatefulWidget {
 
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  
   File image;



  picker() async{
    print('Image Picker called');
   File img = await ImagePicker.pickImage(source: ImageSource.camera);

   if(img != null){
        print(img.path);
image = img;

  setState(() {
    
  });

   }else{
     setState(() {
       
     });
   }

    detetctLabels();
    setState(() {
      
    });

   
  }


 Future<void> detetctLabels() async{
   
   
   final FirebaseVisionImage images = new FirebaseVisionImage.fromFile(image);
   final LabelDetector lableDetector = FirebaseVision.instance.labelDetector();

   final List<Label> lablelList = await lableDetector.detectInImage(images);

   

    for (Label lable in lablelList){
       final  text = lable.label;
       
      
   
         _scaffoldKey.currentState.showSnackBar(SnackBar(
           content: Text(text),
         ));
          }

        
 }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,

          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('Camera App'),
            backgroundColor: Colors.green,
            centerTitle: true,
          ),
          body:  Center(
                  

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              
                child: image==null ?  Text('No Image Selected') : Image.file(image),
              ),


                          ],
                        ),
            ),
          
          floatingActionButton: new FloatingActionButton(
            onPressed: picker,
          backgroundColor: Colors.green,
            child: Icon(Icons.camera_alt),
          ),
        ));
  }
}
