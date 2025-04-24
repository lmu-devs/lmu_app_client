import 'package:core/components.dart';
import 'package:flutter/material.dart';

import '../repository/api/api.dart';

class LibraryDetailsPage extends StatelessWidget {
  const LibraryDetailsPage({
    super.key,
    required this.library,
    this.withAppBar = true,
  });

  final LibraryModel library;
  final bool withAppBar;

  @override
  Widget build(BuildContext context) {
    final content = Container();

    if (!withAppBar) return content;

    return LmuMasterAppBar(
      largeTitle: "Philosophicum",
      leadingAction: LeadingAction.back,
      /**imageUrls: cinema.images != null ? cinema.images!.map((image) => image.url).toList() : [],
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      largeTitleTrailingWidget: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: LmuSizes.size_4,
          vertical: LmuSizes.size_2,
        ),
        decoration: BoxDecoration(
          color: cinema.type.getTextColor(context).withOpacity(0.1),
          borderRadius: BorderRadius.circular(LmuRadiusSizes.small),
        ),
        child: LmuText.bodySmall(
          cinema.type.getValue(),
          color: cinema.type.getTextColor(context),
        ),
      ),**/
      body: SingleChildScrollView(
        child: content,
      ),
    );
  }
}
