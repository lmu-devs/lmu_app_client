import 'package:cached_network_image/cached_network_image.dart';

class LmuCachedNetworkImageProvider extends CachedNetworkImageProvider {
  const LmuCachedNetworkImageProvider(
    String url, {
    int? maxHeight,
    int? maxWidth,
    double scale = 1.0,
  }) : super(
          url,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          scale: scale,
        );
}
