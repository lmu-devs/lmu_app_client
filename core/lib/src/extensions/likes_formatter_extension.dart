import 'package:core/models.dart';

extension LikeFormatter on int {
  String get formattedLikes {
    if (this >= 1000) {
      return "${(this / 1000).toStringAsFixed(1)}K";
    }
    return toString();
  }
}

extension LikeCountCalculator on RatingModel {
  String calculateLikeCount(bool isFavorite) {
    final likes = likeCount;
    final unsyncedLike = isFavorite && !isLiked ? 1 : 0;
    final removedLike = !isFavorite && isLiked ? -1 : 0;
    return (likes + unsyncedLike + removedLike).formattedLikes;
  }
}
