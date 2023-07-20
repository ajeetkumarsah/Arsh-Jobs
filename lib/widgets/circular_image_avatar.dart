import 'package:cached_network_image/cached_network_image.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularImageAvatar extends StatelessWidget {
  CircularImageAvatar({Key? key, this.image, this.height, this.width})
      : super(key: key);
  String? image;
  double? height, width;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: image == null
            ? Image.asset(
                AppConstants.defaultResumeImage,
                height: height,
                width: width,
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: image!,
                height: height,
                width: width,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Image.asset(
                  AppConstants.defaultResumeImage,
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ));
  }
}
