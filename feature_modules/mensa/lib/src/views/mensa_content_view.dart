import 'package:flutter/material.dart';
import 'package:mensa/src/repository/api/models/mensa_model.dart';

class MensaContentView extends StatelessWidget {
  const MensaContentView({
    required this.mensaModels,
    super.key,
  });

  final List<MensaModel> mensaModels;

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    return PageView.builder(
      controller: _pageController,
      itemCount: 4,
      itemBuilder: (context, _) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: mensaModels.length,
          itemBuilder: (context, index) => _MensaOverivewItem(
            mensaModel: mensaModels[index],
          ),
        );
      },
    );
  }
}

class _MensaOverivewItem extends StatelessWidget {
  const _MensaOverivewItem({
    Key? key,
    required this.mensaModel,
  }) : super(key: key);

  final MensaModel mensaModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(mensaModel.name),
      ],
    );
  }
}
