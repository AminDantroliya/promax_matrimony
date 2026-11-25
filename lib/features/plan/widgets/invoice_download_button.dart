import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pro_matrimony/core/localization/language_provider.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';

enum DownloadStatus { idle, downloading, completed, error }

class InvoiceDownloadButton extends StatefulWidget {
  final String url;
  final String invoiceId;

  const InvoiceDownloadButton({
    super.key,
    required this.url,
    required this.invoiceId,
  });

  @override
  State<InvoiceDownloadButton> createState() => _InvoiceDownloadButtonState();
}

class _InvoiceDownloadButtonState extends State<InvoiceDownloadButton> {
  DownloadStatus _status = DownloadStatus.idle;
  double _progress = 0.0;
  String _localPath = "";

  @override
  void initState() {
    super.initState();
    _checkFileExists();
  }

  String get _localFileName => "invoice_${widget.invoiceId}.pdf";

  Future<String> _getLocalFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$_localFileName";
  }

  Future<void> _checkFileExists() async {
    try {
      final path = await _getLocalFilePath();
      final file = File(path);
      if (await file.exists()) {
        setState(() {
          _status = DownloadStatus.completed;
          _localPath = path;
        });
      }
    } catch (_) {}
  }

  Future<void> _downloadInvoice() async {
    if (_status == DownloadStatus.downloading) return;

    setState(() {
      _status = DownloadStatus.downloading;
      _progress = 0.0;
    });

    try {
      final path = await _getLocalFilePath();
      final dio = Dio();

      await dio.download(
        widget.url,
        path,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _progress = received / total;
            });
          }
        },
      );

      setState(() {
        _status = DownloadStatus.completed;
        _localPath = path;
      });
    } catch (e) {
      setState(() {
        _status = DownloadStatus.error;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${'failed_to_download_invoice'.tr}: $e")),
        );
      }
    }
  }

  Future<void> _openInvoice() async {
    if (_localPath.isEmpty) return;
    try {
      final result = await OpenFilex.open(_localPath);
      if (result.type != ResultType.done && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${'could_not_open_invoice'.tr}: ${result.message}")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${'error_opening_file'.tr}: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String label = 'download_invoice_lbl'.tr;
    IconData icon = Icons.download_rounded;
    Color buttonColor = Theme.of(context).primaryColor;

    if (_status == DownloadStatus.downloading) {
      final percentage = (_progress * 100).toStringAsFixed(0);
      label = "${'downloading_lbl'.tr} $percentage%";
      icon = Icons.downloading_rounded;
    } else if (_status == DownloadStatus.completed) {
      label = 'open_invoice_lbl'.tr;
      icon = Icons.open_in_new_rounded;
      buttonColor = const Color(0xFF4CAF50);
    } else if (_status == DownloadStatus.error) {
      label = 'download_failed_retry'.tr;
      icon = Icons.error_outline_rounded;
      buttonColor = const Color(0xFFF44336);
    }

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: buttonColor,
        side: BorderSide(color: buttonColor, width: 1.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        minimumSize: const Size(double.infinity, 44),
      ),
      onPressed: () {
        if (_status == DownloadStatus.completed) {
          _openInvoice();
        } else {
          _downloadInvoice();
        }
      },
      icon: _status == DownloadStatus.downloading
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                value: _progress,
                strokeWidth: 2,
                color: buttonColor,
              ),
            )
          : Icon(icon, size: 18),
      label: Text(
        label,
        style: AppFont.font(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
