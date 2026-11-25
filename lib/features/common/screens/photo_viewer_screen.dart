import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_matrimony/app_theme/app_theme.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/widgets/photo_watermark_overlay.dart';

class PhotoViewerScreen extends ConsumerStatefulWidget {
  final List<String> imageList;
  final int initialIndex;

  const PhotoViewerScreen({
    super.key,
    required this.imageList,
    this.initialIndex = 0,
  });

  @override
  ConsumerState<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends ConsumerState<PhotoViewerScreen> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // Image PageView
              _buildPageView(),
              // Back Button (Top-Left)
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: const Color(0x33000000),
                    border: Border.all(width: 1, color: const Color(0x33FFFFFF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(getProportionateScreenWidth(50)),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: getProportionateScreenWidth(20),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Close Button (Top-Right)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: const Color(0x33000000),
                    border: Border.all(width: 1, color: const Color(0x33FFFFFF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(getProportionateScreenWidth(50)),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      size: getProportionateScreenWidth(22),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Page Indicator
              if (widget.imageList.length > 1)
                Positioned(
                  bottom: getProportionateScreenWidth(10),
                  left: 0,
                  right: 0,
                  child: _buildIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageList.length,
      physics: widget.imageList.isNotEmpty
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      onPageChanged: (v) => setState(() => _currentPage = v),
      itemBuilder: (context, index) {
        return InteractiveViewer(
          minScale: 1.0,
          maxScale: 4.0,
          child: Center(
            child: SizedBox(
              width: screenWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    child: getImageWidget(
                      url: widget.imageList[index],
                      boxFit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                      imageWidth: screenWidth,
                      imageHeight: screenHeight,
                    ),
                  ),
                  const PhotoWatermarkOverlay(isFullScreen: true),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.imageList.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(3)),
          height: _currentPage == index
              ? getProportionateScreenWidth(10)
              : getProportionateScreenWidth(7),
          width: _currentPage == index
              ? getProportionateScreenWidth(10)
              : getProportionateScreenWidth(7),
          decoration: BoxDecoration(
            gradient: _currentPage == index ? gradientPrimary : gradientLike,
            borderRadius: BorderRadius.circular(getProportionateScreenWidth(10)),
          ),
        ),
      ),
    );
  }
}
