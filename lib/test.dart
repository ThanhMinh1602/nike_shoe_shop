// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:nike_shoe_shop/services/firebase_options.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialise();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload to Firebase Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return UploadScreen();
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? imageUrl;
  bool isLoading = false;

  Future<String?> _uploadFile(html.File file) async {
    try {
      var storageRef = _storage.ref().child('images/${file.name}');
      var uploadTask = storageRef.putBlob(file);
      var snapshot = await uploadTask;
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                html.FileUploadInputElement uploadInput =
                    html.FileUploadInputElement();
                uploadInput.click();

                uploadInput.onChange.listen((e) async {
                  setState(() {
                    isLoading = true;
                  });
                  final files = uploadInput.files;
                  if (files?.length == 1) {
                    var url = await _uploadFile(files![0]);
                    setState(() {
                      imageUrl = url;
                      isLoading = false;
                    });
                  }
                });
              },
              child: const Text('Select Image'),
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else if (imageUrl != null)
              Text(imageUrl.toString())
          ],
        ),
      ),
    );
  }
}
// import 'dart:html' as html;
// import 'dart:typed_data';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Upload to Firebase Storage',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: UploadScreen(),
//     );
//   }
// }

// class UploadScreen extends StatefulWidget {
//   @override
//   _UploadScreenState createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   Uint8List? imageData;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Image'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 html.FileUploadInputElement uploadInput =
//                     html.FileUploadInputElement();
//                 uploadInput.click();

//                 uploadInput.onChange.listen((e) async {
//                   final files = uploadInput.files;
//                   if (files != null && files.length == 1) {
//                     final reader = html.FileReader();
//                     reader.readAsArrayBuffer(files[0]);
//                     reader.onLoad.listen((event) {
//                       setState(() {
//                         imageData =
//                             Uint8List.fromList(reader.result as List<int>);
//                       });
//                     });
//                   }
//                 });
//               },
//               child: const Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             if (imageData != null)
//               Image.memory(
//                 imageData!,
//                 width: 300,
//                 height: 300,
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }
