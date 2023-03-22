import 'package:flutter/material.dart';
import 'package:ninjafood/app/features/upload_preview/presentation/layout/mobile/upload_review_mobile_view.dart';
import 'package:ninjafood/app/theme/core_widget/core_widget.dart';

class UploadPreviewScreen extends StatelessWidget {
  const UploadPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppViewLayout(
      mobileView: UploadPreviewMobileView(),
    );
  }
}
