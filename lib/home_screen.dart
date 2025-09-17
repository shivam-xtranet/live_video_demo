import 'dart:io';

import 'package:camera_id_demo_android/camera_preview_screen.dart';
import 'package:camera_id_demo_android/profile_view.dart';
import 'package:camera_id_demo_android/widgets/profile_card_2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widgets/live_stream_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _capturedImage;
  // final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> requestCameraPermissionAndOpenCamera() async {
    var status = await Permission.camera.status;

    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      _captureImage();
    } else if (status.isDenied) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Camera permission denied")));
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Permission permanently denied. Open settings."),
          action: SnackBarAction(
            label: "Settings",
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    }
  }

  Future<void> _captureImage() async {
    // try {
    //   final XFile? image = await Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return CameraPreviewScreen();
    //       },
    //     ),
    //   );
    //
    //   if (image != null) {
    //     setState(() {
    //       _capturedImage = File(image.path);
    //     });
    //     debugPrint('✅ Image captured: ${image.path}');
    //   } else {
    //     debugPrint('⚠️ Image capture canceled.');
    //   }
    // } catch (e) {
    //   debugPrint('❌ Error capturing image: $e');
    // }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LiveStreamPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome',
          style: TextStyle(color: Color(0xFF031273)),
        ),
        centerTitle: false,
        // backgroundColor: Color(0xFF031273),
        elevation: 0,
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: 150,
                width: double.infinity,
                margin: EdgeInsets.only(top: 24),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  // color: Color(0xFF031273),
                  gradient: LinearGradient(
                    colors: [Color(0xFF031273), Colors.blue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Hello John!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Please capture image to create your ID',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    // Container(
                    //   width: 50,
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: [Colors.teal.shade300, Colors.teal],
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.bottomRight,
                    //     ),
                    //     shape: BoxShape.circle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.teal.shade200,
                    //         blurRadius: 10,
                    //         offset: const Offset(0, 5),
                    //       ),
                    //     ],
                    //   ),
                    //   child: const Icon(
                    //     Icons.camera,
                    //     color: Colors.white,
                    //     size: 32,
                    //   ),
                    // ),
                    // const Icon(
                    //   Icons.arrow_forward_ios,
                    //   color: Colors.white,
                    //   size: 24,
                    // ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              // Image Preview Widget
              if (_capturedImage != null)
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: (_capturedImage != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _capturedImage!,
                            width: 300,
                            height: 300,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          size: 80,
                          color: Colors.grey,
                        ),
                ),
              const SizedBox(height: 15),

              // Capture Photo Button
              if (_capturedImage == null) ...[
                GestureDetector(
                  onTap: requestCameraPermissionAndOpenCamera,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal.shade300, Colors.teal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Capture Photo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],

              const SizedBox(height: 20),
              // Upload Button
              if (_capturedImage != null)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileView(
                                filePath: _capturedImage?.path,
                              );
                            },
                          ),
                        );
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF031273), Colors.blue],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white60)
                            : const Text(
                                'Upload',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),

              // const Text(
              //   'Capture Employee Image',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 24),
              // ElevatedButton.icon(
              //   onPressed: requestCameraPermissionAndOpenCamera,
              //   icon: const Icon(Icons.camera_alt),
              //   label: const Text('Capture Image'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //     foregroundColor: Colors.white,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 24,
              //       vertical: 16,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 30),
              // if (_capturedImage != null) ...[
              //   const Text(
              //     'Captured Image:',
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //   ),
              //   const SizedBox(height: 10),
              //   Image.file(
              //     _capturedImage!,
              //     width: 300,
              //     height: 300,
              //     fit: BoxFit.cover,
              //   ),
              // ] else
              //   const Text('No image captured yet.'),

              // SizedBox(height: 30),

              // if (_capturedImage != null)
              //   ElevatedButton.icon(
              //     onPressed: () {
              //       Future.delayed(Duration(seconds: 1)).then((value) {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return IdCard(filePath: _capturedImage?.path);
              //             },
              //           ),
              //         );
              //       });
              //     },
              //     icon: const Icon(Icons.public_sharp),
              //     label: const Text('Show Card'),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.blue,
              //       foregroundColor: Colors.white,
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 24,
              //         vertical: 16,
              //       ),
              //     ),
              //   ),

              // ProfileCard(filePath: _capturedImage?.path,)
            ],
          ),
        ),
      ),
    );
  }
}
