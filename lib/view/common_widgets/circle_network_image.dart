import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../const/const_value.dart';

class CircleNetworkImage extends StatelessWidget {
  const CircleNetworkImage({super.key, this.url, required this.size});
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      imageBuilder: (context, imageProvider) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: size,
        height: size,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Image.asset(
        ImagesPath.error,
        fit: BoxFit.contain,
      ),
    );
  }
}
