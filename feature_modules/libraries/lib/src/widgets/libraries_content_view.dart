import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import '../repository/api/models/library_model.dart';

class LibrariesContentView extends StatefulWidget {
  const LibrariesContentView({
    super.key,
    required this.libraries,
  });

  final List<LibraryModel> libraries;

  @override
  State<LibrariesContentView> createState() => _LibrariesContentViewState();
}

class _LibrariesContentViewState extends State<LibrariesContentView> {
  List<LibraryModel> get _libraries => widget.libraries;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              children: [
                LmuTileHeadline.base(title: context.locals.app.favorites, customBottomPadding: LmuSizes.size_6),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: LmuTileHeadline.base(title: context.locals.libraries.allLibraries),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              children: [
                const SizedBox(height: LmuSizes.size_16),
                const SizedBox(height: LmuSizes.size_96),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
