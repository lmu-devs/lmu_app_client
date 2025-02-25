import 'package:flutter/material.dart';
import '../../repository/api/models/links/link_model.dart';

class LinksContentView extends StatelessWidget {
  const LinksContentView({
    super.key,
    required this.links,
  });

  final List<LinkModel> links;

  @override
  Widget build(BuildContext context) {
    return Column(children: [],);
  }
}
