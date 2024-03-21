/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/adidas_icon.svg
  String get adidasIcon => 'assets/icons/adidas_icon.svg';

  /// File path: assets/icons/converse_icon.svg
  String get converseIcon => 'assets/icons/converse_icon.svg';

  /// File path: assets/icons/fuma_icon.svg
  String get fumaIcon => 'assets/icons/fuma_icon.svg';

  /// File path: assets/icons/nike_icon.svg
  String get nikeIcon => 'assets/icons/nike_icon.svg';

  /// File path: assets/icons/under_armour_icon.svg
  String get underArmourIcon => 'assets/icons/under_armour_icon.svg';

  /// List of all assets
  List<String> get values =>
      [adidasIcon, converseIcon, fumaIcon, nikeIcon, underArmourIcon];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/image_error.png
  AssetGenImage get imageError =>
      const AssetGenImage('assets/images/image_error.png');

  /// File path: assets/images/onboard1.svg
  String get onboard1 => 'assets/images/onboard1.svg';

  /// File path: assets/images/onboard2.svg
  String get onboard2 => 'assets/images/onboard2.svg';

  /// File path: assets/images/onboard3.svg
  String get onboard3 => 'assets/images/onboard3.svg';

  /// File path: assets/images/onboard_nike.svg
  String get onboardNike => 'assets/images/onboard_nike.svg';

  /// List of all assets
  List<dynamic> get values =>
      [imageError, onboard1, onboard2, onboard3, onboardNike];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
