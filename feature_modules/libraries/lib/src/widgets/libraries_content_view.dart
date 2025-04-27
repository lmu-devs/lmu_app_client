import 'package:core/constants.dart';
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
        children: [],
      ),
    );
  }
}
