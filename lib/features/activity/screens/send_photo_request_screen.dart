import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pro_matrimony/utils/utils.dart';
import 'package:pro_matrimony/utils/api_urls.dart';
import 'package:pro_matrimony/widgets/glassmorphic_background.dart';
import 'package:pro_matrimony/widgets/image_widget.dart';
import 'package:pro_matrimony/features/common/data/repositories/action_repository.dart';

class SendPhotoRequestScreen extends ConsumerStatefulWidget {
  final String receiverMemberId;
  final String name;
  final String? profileTitle;
  final dynamic age;
  final String city;
  final String height;
  final String? imageUrl;
  final String matchPercentage;
  final bool isVerified;
  final int? photosCount;
  final bool isPhotoRequestSent;

  const SendPhotoRequestScreen({
    super.key,
    required this.receiverMemberId,
    this.name = "",
    this.profileTitle,
    this.age = 0,
    this.city = "",
    this.height = "",
    this.imageUrl,
    this.matchPercentage = "",
    this.isVerified = true,
    this.photosCount,
    this.isPhotoRequestSent = false,
  });

  @override
  ConsumerState<SendPhotoRequestScreen> createState() => _SendPhotoRequestScreenState();
}

class _SendPhotoRequestScreenState extends ConsumerState<SendPhotoRequestScreen> {
  bool _isLoading = false;
  late bool _isSent;

  String get _displayTitle {
    final title = widget.profileTitle?.trim();
    if (title != null && title.isNotEmpty) {
      return title;
    }
    if (widget.name.trim().isNotEmpty) {
      return widget.name.trim();
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    _isSent = widget.isPhotoRequestSent;
  }

  Future<void> _submitRequest() async {
    if (_isSent) return;
    setState(() => _isLoading = true);
    try {
      final response = await ref.read(actionRepositoryProvider).postRequest(
        sendPhotoRequestApi,
        {"receiver_member_id": widget.receiverMemberId},
      );
      showToast(response.message);
      if (mounted) {
        if (response.status == "success" || response.message.toLowerCase().contains("already sent")) {
          setState(() {
            _isSent = true;
          });
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) {
              Navigator.pop(context);
            }
          });
        }
      }
    } catch (e) {
      if (mounted) {
        showToast("Error sending photo request");
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassmorphicBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, isDark),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    _buildBlurredProfileCard(isDark),
                    const Gap(24),
                    _buildUnlockPhotosCard(isDark),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(isDark),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _glassIconButton(
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.secondary,
              size: 22,
            ),
            isDark: isDark,
            onTap: () => Navigator.pop(context),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Send ',
                style: AppFont.font(
                  color: isDark ? Colors.white : premiumDarkText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Request',
                style: AppFont.font(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          _glassIconButton(
            child: SvgPicture.asset(
              AppAssets.figmaNotifications,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
            isDark: isDark,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredProfileCard(bool isDark) {
    final formattedUrl = formatImageUrl(widget.imageUrl);
    final imageProvider = (formattedUrl.isNotEmpty &&
            (formattedUrl.startsWith("http://") ||
                formattedUrl.startsWith("https://")))
        ? CachedNetworkImageProvider(formattedUrl) as ImageProvider
        : const AssetImage(AppAssets.femalePlaceholderPng);

    return GestureDetector(
      onTap: _isSent ? null : _submitRequest,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
        height: 340,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Backdrop Blur layer to blur the profile background image
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.18),
                ),
              ),
            ),
            // Card Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Row Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Verified Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 14),
                            const Gap(6),
                            Text(
                              'Verified',
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Match Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.favorite_rounded, color: Colors.white, size: 14),
                            const Gap(6),
                            Text(
                              widget.matchPercentage,
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Center Lock Circle
                  Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.icProtectedLock,
                        width: 32,
                        height: 32,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  // Bottom Profile Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              _displayTitle,
                              style: AppFont.font(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Gap(8),
                          if (widget.isVerified)
                            const Icon(Icons.verified, color: Color(0xFF22C55E), size: 20),
                        ],
                      ),
                      const Gap(4),
                      Builder(
                        builder: (context) {
                          final details = [
                            if (widget.age != null &&
                                widget.age.toString().trim().isNotEmpty &&
                                widget.age.toString().trim() != '0')
                              '${widget.age} yrs',
                            if (widget.city.trim().isNotEmpty) widget.city.trim(),
                            if (widget.height.trim().isNotEmpty) widget.height.trim(),
                          ];
                          if (details.isEmpty) return const SizedBox.shrink();
                          return Text(
                            details.join(' • '),
                            style: AppFont.font(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildUnlockPhotosCard(bool isDark) {
    return _card(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'unlock_private_photos'.tr,
            style: AppFont.font(
              color: isDark ? Colors.white : premiumDarkText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(4),
          Text(
            'send_photo_request_gallery_sub'.tr,
            style: AppFont.font(
              color: isDark ? Colors.white38 : premiumSubtitle,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(20),
          // Features List
          _buildFeatureRow(
            icon: AppAssets.figmaCamera,
            title: widget.photosCount != null && widget.photosCount! > 0
                ? '${widget.photosCount} ${'private_photos'.tr}'
                : 'private_photos'.tr,
            subtitle: 'full_hd_gallery_access'.tr,
            isDark: isDark,
          ),
          const Gap(16),
          _buildFeatureRow(
            icon: AppAssets.figmaVerified,
            title: 'verified_profile_title'.tr,
            subtitle: 'verified_profile_sub'.tr,
            isDark: isDark,
          ),
          const Gap(16),
          _buildFeatureRow(
            icon: AppAssets.icProtectedLock,
            title: 'private_and_secure'.tr,
            subtitle: 'approve_request_sub'.tr,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow({
    required String icon,
    required String title,
    required String subtitle,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFF3EEF7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const Gap(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFont.font(
                  color: isDark ? Colors.white : premiumDarkText,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(2),
              Text(
                subtitle,
                style: AppFont.font(
                  color: isDark ? Colors.white38 : premiumSubtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0C0D16) : const Color(0xFFF5F7FC),
      ),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: _isSent ? null : _submitRequest,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: _isSent
                      ? LinearGradient(
                          colors: isDark
                              ? [const Color(0xFF2D2E3D), const Color(0xFF2D2E3D)]
                              : [const Color(0xFF9CA3AF), const Color(0xFF6B7280)],
                        )
                      : LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).primaryColor,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: _isSent
                      ? []
                      : [
                          BoxShadow(
                            color: Theme.of(context)
                                .primaryColor
                                .withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: _isSent ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            _isSent ? AppAssets.figmaVerified : AppAssets.figmaCamera,
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            _isSent
                                ? ('photo_request_already_sent'.tr == 'photo_request_already_sent'
                                    ? 'Photo Request Already Sent'
                                    : 'photo_request_already_sent'.tr)
                                : 'Send Photo Request',
                            style: AppFont.font(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (!_isSent)
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _card({
    required bool isDark,
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20),
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13141F) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.06) : const Color(0xFFF0F0F5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _glassIconButton({
    required Widget child,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.10) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
