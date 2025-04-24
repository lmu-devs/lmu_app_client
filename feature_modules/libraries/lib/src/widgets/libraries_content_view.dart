import 'package:flutter/material.dart';
import '../repository/api/models/library_model.dart';

class LibrariesContentView extends StatelessWidget {
  const LibrariesContentView({
    super.key, required this.libraries,
  });

  final List<LibraryModel> libraries;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
