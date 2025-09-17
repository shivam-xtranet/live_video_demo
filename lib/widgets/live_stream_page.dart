import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class LiveStreamPage extends StatefulWidget {
  const LiveStreamPage({super.key});

  @override
  LiveStreamPageState createState() => LiveStreamPageState();
}

class LiveStreamPageState extends State<LiveStreamPage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  bool _isInitializing = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _setupRenderer();
  }

  Future<void> _setupRenderer() async {
    try {
      await _localRenderer.initialize();

      final mediaStream = await navigator.mediaDevices.getUserMedia({
        'audio': false,
        'video': {'facingMode': 'user'},
      });

      _localRenderer.srcObject = mediaStream;

      setState(() {
        _isInitializing = false;
      });

      // TODO: send stream to signaling server for WebRTC
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isInitializing = false;
        });
      }
      debugPrint('Error initializing camera stream: $e');
    }
  }

  @override
  void dispose() {
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
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Failed to start camera stream', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RTCVideoView(
          _localRenderer,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        ),
      ),
    );
  }
}
