import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/utils/app_debug.dart';
import 'package:pro_matrimony/utils/utils.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final bool isYoutube;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.isYoutube,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _videoController;
  WebViewController? _webViewController;

  bool _isVideoInitialized = false;
  bool _hasVideoError = false;
  bool _hasYoutubeError = false;
  bool _showWebView = false;
  bool _isWebViewLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isYoutube) {
      _initYoutubePlayer();
    } else {
      _initializeVideoPlayer();
    }
  }

  void _initYoutubePlayer() {
    setState(() {
      _hasYoutubeError = false;
      _showWebView = false;
    });

    final videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl);
    if (videoId != null && videoId.isNotEmpty) {
      _youtubeController?.close();
      _youtubeController = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: true,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          mute: false,
        ),
      );
    } else {
      if (mounted) {
        setState(() {
          _hasYoutubeError = true;
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant VideoPlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _showWebView = false;
      if (widget.isYoutube) {
        _initYoutubePlayer();
      } else {
        _videoController?.removeListener(_videoPlayerListener);
        _videoController?.dispose();
        _videoController = null;
        _isVideoInitialized = false;
        _hasVideoError = false;
        _initializeVideoPlayer();
      }
    }
  }

  String _formatMediaUrl(String? url) {
    if (url == null || url.trim().isEmpty || url.trim() == "null") {
      return "";
    }
    String formatted = url.trim();

    // If path is a relative URL (e.g. /storage/... or storage/...)
    if (!formatted.startsWith('http://') &&
        !formatted.startsWith('https://') &&
        !formatted.startsWith('file://') &&
        !formatted.startsWith('content://') &&
        !formatted.startsWith('assets/')) {
      Uri baseUri = Uri.parse(baseUrl);
      String host =
          "${baseUri.scheme}://${baseUri.host}${baseUri.hasPort ? ':${baseUri.port}' : ''}";
      if (!formatted.startsWith('/')) {
        formatted = "/$formatted";
      }
      formatted = "$host$formatted";
    }

    // Normalize localhost/127.0.0.1 if baseUrl uses local IP
    if (formatted.contains("localhost") || formatted.contains("127.0.0.1")) {
      Uri baseUri = Uri.parse(baseUrl);
      String host =
          "${baseUri.scheme}://${baseUri.host}${baseUri.hasPort ? ':${baseUri.port}' : ''}";
      formatted = formatted
          .replaceFirst(RegExp(r'http://localhost(:\d+)?'), host)
          .replaceFirst(RegExp(r'http://127\.0\.0\.1(:\d+)?'), host);
    }

    return formatted;
  }

  Future<void> _initializeVideoPlayer() async {
    if (widget.videoUrl.trim().isEmpty) {
      if (mounted) setState(() => _hasVideoError = true);
      return;
    }

    try {
      if (mounted) {
        setState(() {
          _hasVideoError = false;
          _isVideoInitialized = false;
          _showWebView = false;
        });
      }

      final path = _formatMediaUrl(widget.videoUrl);
      printLog("Initializing VideoPlayerScreen with path: $path");

      final isNetwork = path.startsWith('http://') || path.startsWith('https://');
      final isContentUri = path.startsWith('content://');

      if (isNetwork) {
        _videoController = VideoPlayerController.networkUrl(Uri.parse(path));
      } else if (isContentUri) {
        _videoController = VideoPlayerController.contentUri(Uri.parse(path));
      } else {
        String cleanPath = path;
        if (cleanPath.startsWith('file://')) {
          cleanPath = cleanPath.replaceFirst('file://', '');
        }
        final file = File(cleanPath);
        if (!file.existsSync()) {
          throw Exception("Video file does not exist on device path: $cleanPath");
        }
        _videoController = VideoPlayerController.file(file);
      }

      await _videoController!.initialize().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception('Video load timed out.');
        },
      );

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController!.play();
      }

      _videoController!.addListener(_videoPlayerListener);
    } catch (e) {
      printLog("VideoPlayerScreen initialization failed: $e");
      if (mounted) {
        setState(() {
          _hasVideoError = true;
        });
      }
    }
  }

  void _videoPlayerListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _initWebViewController() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _isWebViewLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isWebViewLoading = false);
          },
        ),
      );

    if (widget.isYoutube) {
      final videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl);
      if (videoId != null && videoId.isNotEmpty) {
        _webViewController!.loadHtmlString(_getYoutubeHtml(videoId));
      } else {
        _webViewController!.loadRequest(Uri.parse(widget.videoUrl));
      }
    } else {
      final path = _formatMediaUrl(widget.videoUrl);
      _webViewController!.loadHtmlString(_getVideoHtml(path));
    }
  }

  String _getVideoHtml(String videoUrl) {
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body {
      width: 100%;
      height: 100%;
      background-color: #000000;
      display: flex;
      justify-content: center;
      align-items: center;
      overflow: hidden;
    }
    video {
      width: 100%;
      height: 100%;
      max-height: 100%;
      object-fit: contain;
    }
    video::-internal-media-controls-download-button {
      display: none !important;
    }
    video::-webkit-media-controls-download-button {
      display: none !important;
    }
  </style>
</head>
<body>
  <video controls controlsList="nodownload" autoplay playsinline webkit-playsinline>
    <source src="$videoUrl" type="video/mp4">
    Your browser does not support HTML5 video.
  </video>
</body>
</html>
''';
  }

  String _getYoutubeHtml(String videoId) {
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body {
      width: 100%;
      height: 100%;
      background-color: #000000;
      display: flex;
      justify-content: center;
      align-items: center;
      overflow: hidden;
    }
    iframe {
      width: 100%;
      height: 100%;
      border: none;
    }
  </style>
</head>
<body>
  <iframe src="https://www.youtube.com/embed/$videoId?autoplay=1&playsinline=1" allow="autoplay; encrypted-media; picture-in-picture" allowfullscreen></iframe>
</body>
</html>
''';
  }

  @override
  void dispose() {
    _youtubeController?.close();
    _videoController?.removeListener(_videoPlayerListener);
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: _showWebView
            ? _buildWebViewContent()
            : widget.isYoutube
            ? (_hasYoutubeError || _youtubeController == null
            ? _buildErrorContent()
            : YoutubePlayer(
          controller: _youtubeController!,
          aspectRatio: 16 / 9,
        ))
            : _hasVideoError
            ? _buildErrorContent()
            : _isVideoInitialized && _videoController != null
            ? AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio > 0
              ? _videoController!.value.aspectRatio
              : 16 / 9,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(_videoController!),
              _VideoControlsOverlay(controller: _videoController!),
            ],
          ),
        )
            : const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildWebViewContent() {
    if (_webViewController == null) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      );
    }
    return Stack(
      children: [
        WebViewWidget(controller: _webViewController!),
        if (_isWebViewLoading)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
      ],
    );
  }

  Widget _buildErrorContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 48),
          const SizedBox(height: 16),
          Text(
            'failed_to_load_video'.tr.isNotEmpty
                ? 'failed_to_load_video'.tr
                : 'Failed to load video',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 24),

          // Option 1: Play in Web Player
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {
              setState(() {
                _showWebView = true;
              });
              _initWebViewController();
            },
            icon: const Icon(Icons.language_rounded, size: 20),
            label: const Text(
              'Play in Web Player',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 12),

          // Option 2: Retry Button
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: const BorderSide(color: Colors.white30),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {
              if (widget.isYoutube) {
                _initYoutubePlayer();
              } else {
                _initializeVideoPlayer();
              }
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text(
              'retry'.tr.isNotEmpty ? 'retry'.tr : 'Retry',
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoControlsOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  const _VideoControlsOverlay({required this.controller});

  @override
  State<_VideoControlsOverlay> createState() => _VideoControlsOverlayState();
}

class _VideoControlsOverlayState extends State<_VideoControlsOverlay> {
  bool _showControls = true;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.controller.value;
    final isEnded = value.position >= value.duration && value.duration > Duration.zero;

    return GestureDetector(
      onTap: () {
        setState(() {
          _showControls = !_showControls;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: _showControls ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: Container(
              color: Colors.black38,
              child: Stack(
                children: [
                  // Center play / pause / replay button
                  Center(
                    child: IconButton(
                      iconSize: 56,
                      icon: Icon(
                        isEnded
                            ? Icons.replay_circle_filled_rounded
                            : (value.isPlaying
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_filled_rounded),
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (value.isPlaying) {
                            widget.controller.pause();
                          } else {
                            if (isEnded) {
                              widget.controller.seekTo(Duration.zero);
                            }
                            widget.controller.play();
                          }
                        });
                      },
                    ),
                  ),

                  // Bottom duration and scrub bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  _formatDuration(value.position),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  _formatDuration(value.duration),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        VideoProgressIndicator(
                          widget.controller,
                          allowScrubbing: true,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          colors: const VideoProgressColors(
                            playedColor: AppColors.primary,
                            bufferedColor: Colors.white24,
                            backgroundColor: Colors.white12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
