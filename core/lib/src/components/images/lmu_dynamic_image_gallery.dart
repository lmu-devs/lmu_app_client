import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/src/api/api.dart';
import 'package:flutter/widgets.dart';

class LmuDynamicImageGallery extends StatelessWidget {
  const LmuDynamicImageGallery({
    super.key,
    required this.images,
  });

  final List<ImageModel> images;

  int get imageCount => images.length;

  @override
  Widget build(BuildContext context) {
    if (imageCount == 0) {
      return const SizedBox.shrink();
    }
    if (imageCount == 1) {
      return Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(LmuSizes.size_12),
          child: LmuCachedNetworkImage(
            imageUrl: images.first.url,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return SizedBox(
      height: 150,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(LmuSizes.size_16),
            itemCount: imageCount,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final imageUrl = images[index].url;
              return ClipRRect(
                borderRadius: BorderRadius.circular(LmuSizes.size_12),
                child: LmuCachedNetworkImage(
                  imageUrl: imageUrl,
                  width: (constraints.maxWidth / 2) - 20,
                  fit: BoxFit.fitWidth,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
