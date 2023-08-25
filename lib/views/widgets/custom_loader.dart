import 'package:flutter/material.dart';

import '../../resources/color_resource.dart';

class CustomLoader extends StatelessWidget {
  final Widget? child;
  final bool loading;
  final double? opacity;

  const CustomLoader({
    super.key,
    this.child,
    this.opacity,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider

    return Opacity(
      opacity: loading ? opacity ?? 0.5 : 1.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IgnorePointer(ignoring: loading, child: child!),
          loading
              ? Center(
            child: CircularProgressIndicator(
              color: ColorResource.appColor,
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}
