// // ignore_for_file: non_constant_identifier_names

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:nike_shoe_shop/services/firebase_options.dart';
// import 'package:nike_shoe_shop/services/local/share_pref.dart';
// import 'package:http/http.dart' as http;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SharedPrefs.initialise();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Upload to Firebase Storage',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FutureBuilder(
//         future: _firebaseApp,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return UploadScreen();
//           }
//           return const CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }

// class UploadScreen extends StatefulWidget {
//   @override
//   _UploadScreenState createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   // final FirebaseStorage _storage = FirebaseStorage.instance;
//   String? imageUrl;
//   final service_id = 'service_hxlrx5p';
//   final template_id = 'template_9nlwl05';
//   final user_id = 'KdpZ791XcZaAbvLoJ';
//   bool isLoading = false;
//   Future<void> sendMail(
//       {required String name,
//       required String email,
//       required String subject,
//       required String message}) async {
//     final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'service_id': service_id,
//         'template_id': template_id,
//         'user_id': user_id,
//         'template_params': {
//           'user_name': name,
//           'user_email': email,
//           'user_subject': subject,
//           'user_message': message
//         }
//       }),
//     );
//     print(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('send mail'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 await sendMail(
//                     email: 'ntminh16201@gmail.com',
//                     message: 'Hello Thanh MInh',
//                     subject: 'Xin chao',
//                     name: 'abc');
//               },
//               child: const Text('send mail'),
//             ),
//             const SizedBox(height: 20),
//             if (isLoading)
//               const CircularProgressIndicator()
//             else if (imageUrl != null)
//               Text(imageUrl.toString())
//           ],
//         ),
//       ),
//     );
//   }
// }
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
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An email with reset instructions has been sent to ${_emailController.text}'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send reset email: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _resetPassword(context),
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
