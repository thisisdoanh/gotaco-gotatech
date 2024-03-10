import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_color.dart';

class AppImageWidget extends StatelessWidget {
  final String path;
  bool isAsset = false;
  Widget? placeholder;
  Widget? errorWidget;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  double? loadingSize;

  AppImageWidget.asset({
    super.key,
    required this.path,
    this.isAsset = true,
    this.fit,
    this.width,
    this.height,
    this.color,
  });

  AppImageWidget.network({
    super.key,
    required this.path,
    this.isAsset = false,
    this.placeholder,
    this.errorWidget,
    this.fit,
    this.width,
    this.height,
    this.loadingSize,
    this.color,
  });

  Widget get _placeholder {
    return Center(
        child: SizedBox(
      width: loadingSize ?? 20.0.sp,
      height: loadingSize ?? 20.0.sp,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
        strokeWidth: 2,
      ),
    ));
  }

  Widget get _errorWidget {
    return const Icon(Icons.error);
  }

  Widget _buildSvgImageWidget() {
    if (isAsset) {
      return SvgPicture.asset(
        path,
        fit: fit ?? BoxFit.contain,
        width: width,
        height: height,
        color: color,
      );
    }
    return SvgPicture.network(
      path,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      color: color,
      placeholderBuilder: (context) => placeholder ?? _placeholder,
    );
  }

  Widget _buildNormalImageWidget() {
    if (isAsset) {
      return Image.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );
    }
    return CachedNetworkImage(
      imageUrl: path,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => placeholder ?? _placeholder,
      errorWidget: (context, url, error) {
        return errorWidget ?? _errorWidget;
      },
      cacheManager: CacheManager(
        Config(
          'ImageCacheKey',
          stalePeriod: const Duration(days: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case ImageType.svg:
        return _buildSvgImageWidget();
      default:
        return _buildNormalImageWidget();
    }
  }

  ImageType get imageType {
    int length = path.length;
    String lastString = path.substring(length - 5).toUpperCase();
    if (lastString.contains('.json'.toUpperCase())) {
      return ImageType.lottie;
    } else if (lastString.contains('.svg'.toUpperCase())) {
      return ImageType.svg;
    } else {
      return ImageType.image;
    }
  }
}

enum ImageType { svg, image, lottie }
