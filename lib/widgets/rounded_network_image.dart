import 'package:cached_network_image/cached_network_image.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedNetworkImage extends StatelessWidget {
  RoundedNetworkImage(
      {Key? key,
      this.image,
      this.height,
      this.width,
      this.fit,
      this.defaultImage = AppConstants.defaultImage,
      this.radius = defualtRadius})
      : super(key: key);
  String? image, defaultImage;
  double? height, width, radius;
  BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: image != null && image != ''
          ? CachedNetworkImage(
              imageUrl: image!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Image.asset(
                defaultImage!,
                height: height,
                width: width,
                fit: fit ?? BoxFit.cover,
              ),
            )
          : Image.asset(
              defaultImage!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
            ),
    );
  }
}
