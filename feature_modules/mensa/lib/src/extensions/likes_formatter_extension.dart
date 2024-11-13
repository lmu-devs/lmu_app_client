extension LikeFormatter on int {
  String get formattedLikes {
    if (this >= 1000) {
      return "${(this / 1000).toStringAsFixed(1)}K";
    }
    return toString();
  }
}
