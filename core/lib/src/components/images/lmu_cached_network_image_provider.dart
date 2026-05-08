import 'package:cached_network_image/cached_network_image.dart';

class LmuCachedNetworkImageProvider extends CachedNetworkImageProvider {
  const LmuCachedNetworkImageProvider(
    super.url, {
    super.maxHeight,
    super.maxWidth,
    super.scale,
  });
}
