import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:image/image.dart' as img;

import 'main.dart';

const String SERVER_URL = "ws://127.0.0.1:8000/ws/stream";

class LiveWebSocketStream extends StatefulWidget {
  const LiveWebSocketStream({super.key});

  @override
  State<LiveWebSocketStream> createState() => _LiveWebSocketStreamState();
}

class _LiveWebSocketStreamState extends State<LiveWebSocketStream> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  late WebSocketChannel _channel;
  bool _processing = false;
  Uint8List? _finalImage;

  @override
  void initState() {
    super.initState();
    _initCameraAndSocket();
  }

  Future<void> _initCameraAndSocket() async {


    final camera = cameras.firstWhere(
          (c) {
        if (kIsWeb) {
          return c.lensDirection == CameraLensDirection.front;
        } else {
          return c.lensDirection == CameraLensDirection.front;
        }
      },
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(camera, ResolutionPreset.medium);
    await _cameraController.initialize();

    setState(() {
      _isCameraInitialized = true;
    });

    _channel = WebSocketChannel.connect(Uri.parse(SERVER_URL));

    // Start streaming frames
    _cameraController.startImageStream((CameraImage image) {
      if (!_processing) {
        _processing = true;
        _handleCameraImage(image);
      }
    });

    // Listen for server responses
    _channel.stream.listen((message) {
      final data = jsonDecode(message);
      print("📢 Server response: $data");

      if (data["status"] == "perfect") {
        final decodedImage = base64Decode(data["final_image"]);
        setState(() {
          _finalImage = decodedImage;
        });
        // Optionally stop streaming
        _cameraController.stopImageStream();
      }
    });
  }

  Future<void> _handleCameraImage(CameraImage image) async {
    try {
      // Convert CameraImage to JPEG
      final jpegBytes = await convertYUV420toJpeg(image);
      final base64Img = base64Encode(jpegBytes);

      _channel.sink.add(base64Img);
    } catch (e) {
      print("Error converting frame: $e");
    } finally {
      _processing = false;
    }
  }

  /// Converts YUV420 (Android) image to JPEG using the `image` package
  Future<Uint8List> convertYUV420toJpeg(CameraImage image) async {
    final int width = image.width;
    final int height = image.height;

    final img.Image rgbImage = img.Image(width: width, height: height);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int uvIndex = (y >> 1) * (width >> 1) + (x >> 1);
        final int yp = y * width + x;

        final int yVal = image.planes[0].bytes[yp];
        final int uVal = image.planes[1].bytes[uvIndex];
        final int vVal = image.planes[2].bytes[uvIndex];

        final r = (yVal + (1.370705 * (vVal - 128))).clamp(0, 255).toInt();
        final g = (yVal - (0.337633 * (uVal - 128)) - (0.698001 * (vVal - 128)))
            .clamp(0, 255)
            .toInt();
        final b = (yVal + (1.732446 * (uVal - 128))).clamp(0, 255).toInt();

        rgbImage.setPixelRgb(x, y, r, g, b);
      }
    }

    final jpeg = img.encodeJpg(rgbImage, quality: 70);
    return Uint8List.fromList(jpeg);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WebSocket Camera Stream")),
      body: Column(
        children: [
          Expanded(
            child: _finalImage != null
                ? Image.memory(_finalImage!)
                : (_cameraController.value.isInitialized
                      ? _isCameraInitialized
                            ? CameraPreview(_cameraController)
                            : Center(child: CircularProgressIndicator())
                      : const Center(child: CircularProgressIndicator())),
          ),
        ],
      ),
    );
  }
}
