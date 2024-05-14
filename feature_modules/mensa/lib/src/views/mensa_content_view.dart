import 'package:flutter/material.dart';

class MensaContentView extends StatelessWidget {
  const MensaContentView({
    required this.mensaData,
    super.key,
  });

  final String mensaData;

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    return PageView.builder(
      controller: _pageController,
      itemCount: 2,
      itemBuilder: (context, index) => Container(
        color: Colors.red,
        width: 20,
        height: 20,
      ),
    );
  }
}

class _MensaOverivewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              width: 20,
              height: 20,
              color: Colors.green,
            ),
          ),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 2,
        //     itemBuilder: (context, index) => _MensaEntryItem(
        //       mensaEntry: mensaDay.mensaEntries[index],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
