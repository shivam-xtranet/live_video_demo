import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'main.dart';

class CameraPreviewScreen extends StatefulWidget {

  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  CameraController? _controller;
  XFile? capturedImage;
  CameraDescription? frontCamera;

  final resolutionPresets = ResolutionPreset.values;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  bool _isInitializing = true;
  bool _cameraError = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    setState(() {
      _isInitializing = true;
      _cameraError = false;
    });

    try {

      frontCamera = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      await onNewCameraSelected(frontCamera!);
    } catch (e) {
      if (kDebugMode) print('Camera initialization error: $e');
      setState(() => _cameraError = true);
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    // Dispose previous controller safely
    if (_controller != null) {
      try {
        await _controller!.dispose();
      } catch (_) {}
    }

    final cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _controller = cameraController;

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      if (kDebugMode) print('Camera error: $e');
      setState(() => _cameraError = true);
    }

    if (mounted) {
      setState(() {
        _isInitializing = false;
      });
    }
  }

  Future<void> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final XFile picture = await _controller!.takePicture();
      setState(() {
        capturedImage = picture;
      });
    } catch (e) {
      if (kDebugMode) print('Take picture error: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 20),
              const Text("Failed to initialize camera"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: initializeCamera,
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    if (_isInitializing || _controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final controller = _controller!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF031273)),
        ),
        title: const Text("Camera", style: TextStyle(color: Color(0xFF031273))),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Camera preview
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),

          // Capture button
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CameraButton(icon: Icons.camera_alt, onPressed: takePicture),
            ),
          ),

          // Resolution dropdown
          Align(
            alignment: Alignment.topRight,
            child: DropdownButton<ResolutionPreset>(
              dropdownColor: Colors.white,
              underline: Container(),
              value: currentResolutionPreset,
              items: [
                for (ResolutionPreset preset in resolutionPresets)
                  DropdownMenuItem(
                    value: preset,
                    child: Text(
                      preset.toString().split('.').last.toUpperCase(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
              ],
              onChanged: (value) async {
                if (value != null && controller.description != null) {
                  setState(() {
                    currentResolutionPreset = value;
                    _isInitializing = true;
                  });
                  await onNewCameraSelected(controller.description);
                }
              },
            ),
          ),

          // Blur and captured image preview
          if (capturedImage != null)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          if (capturedImage != null)
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(capturedImage!.path),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CameraButton(
                        icon: Icons.close_rounded,
                        onPressed: () => setState(() => capturedImage = null),
                      ),
                      const SizedBox(width: 20),
                      CameraButton(
                        icon: Icons.check,
                        onPressed: () => Navigator.pop(context, capturedImage),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CameraButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CameraButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300, width: 4),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: Icon(icon, size: 32, color: Colors.black87)),
      ),
    );
  }
}
