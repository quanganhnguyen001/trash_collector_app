/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/alert_password.png
  AssetGenImage get alertPassword =>
      const AssetGenImage('assets/images/alert_password.png');

  /// File path: assets/images/bg_login.png
  AssetGenImage get bgLogin =>
      const AssetGenImage('assets/images/bg_login.png');

  /// File path: assets/images/bg_reset_pass.png
  AssetGenImage get bgResetPass =>
      const AssetGenImage('assets/images/bg_reset_pass.png');

  /// File path: assets/images/bg_setting.png
  AssetGenImage get bgSetting =>
      const AssetGenImage('assets/images/bg_setting.png');

  /// File path: assets/images/bg_signup.png
  AssetGenImage get bgSignup =>
      const AssetGenImage('assets/images/bg_signup.png');

  /// File path: assets/images/chat_logo.png
  AssetGenImage get chatLogo =>
      const AssetGenImage('assets/images/chat_logo.png');

  /// File path: assets/images/check.png
  AssetGenImage get check => const AssetGenImage('assets/images/check.png');

  /// File path: assets/images/gift_box_ic.png
  AssetGenImage get giftBoxIc =>
      const AssetGenImage('assets/images/gift_box_ic.png');

  /// File path: assets/images/green_natural_img.png
  AssetGenImage get greenNaturalImg =>
      const AssetGenImage('assets/images/green_natural_img.png');

  /// File path: assets/images/history_ic.png
  AssetGenImage get historyIc =>
      const AssetGenImage('assets/images/history_ic.png');

  /// File path: assets/images/ic_trash.png
  AssetGenImage get icTrash =>
      const AssetGenImage('assets/images/ic_trash.png');

  /// File path: assets/images/launcher_icon.png
  AssetGenImage get launcherIcon =>
      const AssetGenImage('assets/images/launcher_icon.png');

  /// File path: assets/images/password_hide.png
  AssetGenImage get passwordHide =>
      const AssetGenImage('assets/images/password_hide.png');

  /// File path: assets/images/password_show.png
  AssetGenImage get passwordShow =>
      const AssetGenImage('assets/images/password_show.png');

  /// File path: assets/images/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.png');

  /// File path: assets/images/recycle_trash_img.png
  AssetGenImage get recycleTrashImg =>
      const AssetGenImage('assets/images/recycle_trash_img.png');

  /// File path: assets/images/schedule_ic.png
  AssetGenImage get scheduleIc =>
      const AssetGenImage('assets/images/schedule_ic.png');

  /// File path: assets/images/trash_collector_img.png
  AssetGenImage get trashCollectorImg =>
      const AssetGenImage('assets/images/trash_collector_img.png');

  /// File path: assets/images/wheel 1.png
  AssetGenImage get wheel1 => const AssetGenImage('assets/images/wheel 1.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        alertPassword,
        bgLogin,
        bgResetPass,
        bgSetting,
        bgSignup,
        chatLogo,
        check,
        giftBoxIc,
        greenNaturalImg,
        historyIc,
        icTrash,
        launcherIcon,
        passwordHide,
        passwordShow,
        profile,
        recycleTrashImg,
        scheduleIc,
        trashCollectorImg,
        wheel1
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const String labels = 'assets/labels.txt';
  static const String modelUnquant = 'assets/model_unquant.tflite';
  static const String modelUnquantTflite = 'assets/model_unquant.tflite.abk';

  /// List of all assets
  List<String> get values => [labels, modelUnquant, modelUnquantTflite];
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
