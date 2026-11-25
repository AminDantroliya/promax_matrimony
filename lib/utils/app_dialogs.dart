import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/utils/utils.dart';
import '../widgets/app_text_field.dart';

/// Centralised dialog helpers — use these instead of writing `showDialog` +
/// `AlertDialog` inline. Changing text/style here updates every dialog at once.
class AppDialogs {
  AppDialogs._();

  // ─── Generic Confirm Dialog (Now Bottom Sheet) ──────────────────────────────

  /// Shows a theme-aware confirmation bottom sheet with Cancel / Confirm buttons.
  /// Returns `true` when the user taps Confirm, `false` otherwise (including
  /// tapping outside to dismiss).
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String? cancelLabel,
    String? confirmLabel,
    Color? confirmColor,
    List<Color>? gradientColors,
    Widget? customBody,
  }) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final String cancelText = (cancelLabel != null && cancelLabel.trim().isNotEmpty)
        ? cancelLabel.tr
        : 'btn_cancel'.tr;
    final String confirmText = (confirmLabel != null && confirmLabel.trim().isNotEmpty)
        ? confirmLabel.tr
        : 'btn_confirm'.tr;

    final result = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Gap(24),
              // Title
              customTextBoldStyle(
                title.tr, 20, TextAlign.start, theme.colorScheme.onSurface),
              const Gap(12),
              // Message
              customBody ?? customTextNormalStyle(
                message.tr, 15, TextAlign.start,
                theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              const Gap(24),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.12)
                                : const Color(0xFFE2E8F0),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppTheme.getButtonBorderRadius(context),
                          ),
                          foregroundColor: theme.colorScheme.onSurface,
                        ),
                        child: Text(
                          cancelText,
                          style: AppFont.font(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: AppTheme.getButtonBorderRadius(context),
                          gradient: LinearGradient(
                            colors: gradientColors ??
                                (confirmColor != null
                                    ? [confirmColor, confirmColor]
                                    : FigmaColors.primaryGradient(context).colors),
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: (confirmColor ?? theme.primaryColor).withValues(alpha: 0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppTheme.getButtonBorderRadius(context),
                            ),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            confirmText,
                            style: AppFont.font(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return result ?? false;
  }

  // ─── Domain-Specific Wrappers ───────────────────────────────────────────────

  /// Block / unblock confirmation dialog.
  static Future<bool> confirmBlock(
    BuildContext context, {
    required bool isBlocked,
    required String memberName,
  }) =>
      confirm(
        context,
        title: isBlocked ? 'unblock_profile'.tr : 'block_profile'.tr,
        message: isBlocked
            ? 'confirm_unblock_profile_msg'.tr
            : 'confirm_block_profile_msg'.tr,
        confirmLabel: isBlocked ? 'unblock'.tr : 'block'.tr,
      );

  /// Generic delete/remove confirmation dialog.
  static Future<bool> confirmDelete(
    BuildContext context, {
    required String title,
    required String message,
  }) =>
      confirm(context, title: title, message: message, confirmLabel: 'delete'.tr);

  // ─── Info dialog (Now Bottom Sheet) ─────────────────────────────────────────

  /// Simple info / ok dialog (single button).
  static Future<void> info(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final theme = Theme.of(context);
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Gap(24),
              // Title
              customTextBoldStyle(
                title.tr, 20, TextAlign.start, theme.colorScheme.onSurface),
              const Gap(12),
              // Message
              customTextNormalStyle(
                message.tr, 15, TextAlign.start,
                theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              const Gap(24),
              // Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: AppTheme.getButtonBorderRadius(context),
                    gradient: FigmaColors.primaryGradient(context),
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor.withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.getButtonBorderRadius(context),
                      ),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'ok'.tr,
                      style: AppFont.font(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Save Search Dialog (Bottom Sheet) ──────────────────────────────────────

  /// Shows a theme-aware save search bottom sheet with Cancel / Save and Search buttons.
  /// Returns the entered search name string, or `null` if cancelled.
  static Future<String?> showSaveSearch(
    BuildContext context, {
    required String pageName,
  }) async {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Gap(24),
                  // Title
                  customTextBoldStyle(
                    "save_search".tr,
                    20,
                    TextAlign.start,
                    theme.colorScheme.onSurface,
                  ),
                  const Gap(20),
                  // Input field
                  AppTextField(
                    labelText: 'save_search_with_name'.tr,
                    controller: controller,
                    validator: (v) => v?.trim().isEmpty ?? true ? 'This cannot be empty' : null,
                  ),
                  const Gap(24),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.12)
                                    : const Color(0xFFE2E8F0),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppTheme.getButtonBorderRadius(context),
                              ),
                              foregroundColor: theme.colorScheme.onSurface,
                            ),
                            child: Text(
                              'btn_cancel'.tr,
                              style: AppFont.font(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppTheme.getButtonBorderRadius(context),
                              gradient: FigmaColors.primaryGradient(context),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.primaryColor.withValues(alpha: 0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pop(ctx, controller.text.trim());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppTheme.getButtonBorderRadius(context),
                                ),
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                'save_and_search'.tr,
                                style: AppFont.font(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
