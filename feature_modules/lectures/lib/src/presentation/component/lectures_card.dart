import 'package:flutter/material.dart';

class LecturesCard extends StatefulWidget {
  final String title;
  final List<String> tags;
  final VoidCallback onTap;

  const LecturesCard({
    super.key,
    required this.title,
    required this.tags,
    required this.onTap,
  });

  @override
  State<LecturesCard> createState() => _LecturesCardState();
}

class _LecturesCardState extends State<LecturesCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.fromLTRB(14, 4, 6, 14), // 14px left/bottom, 4px top, 6px right
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row with icon and favorite icon, vertically centered
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? Colors.amber : Colors.grey,
                  ),
                  tooltip: isFavorite ? 'Favorit entfernt' : 'Als Favorit markieren',
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  padding: const EdgeInsets.only(right: 0, top: 0, left: 0, bottom: 0),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 0),
            // Tags row (single row, not wrap)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: ['VL', '6 SWS', 'Master', 'Englisch'].map((tag) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
