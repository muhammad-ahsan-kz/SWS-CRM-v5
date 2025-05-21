import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sws_crm_v5/utils/asset_paths.dart';

class LoadingAnimationWidget extends StatelessWidget {
  final double height;
  final double width;
  const LoadingAnimationWidget({
    super.key,
    this.height = 200,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        AssetPaths.loadingAnimation,
        height: height,
        width: width,
      ),
    );
  }
}
