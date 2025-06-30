import 'dart:async';

import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class AlphabetScrollbar extends StatefulWidget {
  const AlphabetScrollbar({
    super.key,
    required this.onLetterSelected,
    this.letters,
  });

  final void Function(String) onLetterSelected;
  final List<String>? letters;

  @override
  State<AlphabetScrollbar> createState() => _AlphabetScrollbarState();
}

class _AlphabetScrollbarState extends State<AlphabetScrollbar> {
  late final List<String> alphabet;
  final GlobalKey _containerKey = GlobalKey();
  String? _activeLetter;
  Timer? _highlightTimer;

  @override
  void initState() {
    super.initState();
    alphabet = widget.letters ?? List<String>.generate(26, (i) => String.fromCharCode(i + 65));
  }

  @override
  void didUpdateWidget(covariant AlphabetScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.letters != oldWidget.letters) {
      alphabet = widget.letters ?? List<String>.generate(26, (i) => String.fromCharCode(i + 65));
    }
  }

  @override
  void dispose() {
    _highlightTimer?.cancel();
    super.dispose();
  }

  void _setActiveLetter(String letter, {bool temporary = false}) {
    widget.onLetterSelected(letter);
    _highlightTimer?.cancel();
    setState(() {
      _activeLetter = letter;
    });
    if (temporary) {
      _highlightTimer = Timer(const Duration(milliseconds: 500), () {
        setState(() {
          _activeLetter = null;
        });
      });
    }
  }

  void _handleVerticalDrag(Offset globalPosition) {
    final RenderBox? box = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final localY = box.globalToLocal(globalPosition).dy;
    final itemHeight = box.size.height / alphabet.length;

    if (localY >= 0 && localY < box.size.height) {
      final index = (localY / itemHeight).floor().clamp(0, alphabet.length - 1);
      final letter = alphabet[index];

      if (_activeLetter != letter) {
        _setActiveLetter(letter);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      width: 40,
      child: Center(
        child: GestureDetector(
          onVerticalDragStart: (details) => _handleVerticalDrag(details.globalPosition),
          onVerticalDragUpdate: (details) => _handleVerticalDrag(details.globalPosition),
          onVerticalDragEnd: (_) {
            setState(() {
              _activeLetter = null;
            });
          },
          child: Container(
            key: _containerKey,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: alphabet.asMap().entries.map((entry) {
                final index = entry.key;
                final letter = entry.value;
                final activeIndex = _activeLetter != null ? alphabet.indexOf(_activeLetter!) : -1;

                double scale = 1.0;
                if (activeIndex != -1) {
                  if (index == activeIndex) {
                    scale = 1.5;
                  } else if (index == activeIndex - 1 || index == activeIndex + 1) {
                    scale = 1.2;
                  }
                }

                return GestureDetector(
                  onTap: () => _setActiveLetter(letter, temporary: true),
                  child: SizedBox(
                    width: 30,
                    height: 18,
                    child: Center(
                      child: AnimatedScale(
                        scale: scale,
                        duration: const Duration(milliseconds: 100),
                        child: Text(
                          letter,
                          style: textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
