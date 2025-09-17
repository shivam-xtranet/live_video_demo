import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CameraWebRTCPage extends StatefulWidget {
  const CameraWebRTCPage({super.key});

  @override
  State<CameraWebRTCPage> createState() => _CameraWebRTCPageState();
}

class _CameraWebRTCPageState extends State<CameraWebRTCPage> {
  CameraController? _cameraController;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  bool _isInitializing = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initCameraAndWebRTC();
  }

  Future<void> _initCameraAndWebRTC() async {
    try {
      // Initialize WebRTC renderer
      await _localRenderer.initialize();

      // Get cameras
      final cameras = await availableCameras();
      final camera = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      // Initialize CameraController
      _cameraController = CameraController(
        camera,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _cameraController!.initialize();

      // Create MediaStream from CameraController
      final stream = await navigator.mediaDevices.getUserMedia({
        'audio': false,
        'video': {
          'facingMode': 'user',
          'width': _cameraController!.value.previewSize!.width.toInt(),
          'height': _cameraController!.value.previewSize!.height.toInt(),
        },
      });

      _localRenderer.srcObject = stream;

      setState(() {
        _isInitializing = false;
      });

      // TODO: send stream to your WebRTC signaling server
    } catch (e) {
      debugPrint('Error initializing camera + WebRTC: $e');
      setState(() {
        _hasError = true;
        _isInitializing = false;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _localRenderer.srcObject?.getTracks().forEach((track) => track.stop());
    _localRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    if (_hasError) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Failed to initialize camera/stream', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Show WebRTC stream
          Center(
            child: RTCVideoView(
              _localRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),

          // Optional: Local preview overlay from CameraController
          if (_cameraController != null && _cameraController!.value.isInitialized)
            Positioned(
              bottom: 20,
              right: 20,
              width: 120,
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CameraPreview(_cameraController!),
              ),
            ),
        ],
      ),
    );
  }
}
