import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrailleConverter {
  static final Map<String, String> _brailleMap = {
    'a': '⠁',
    'b': '⠃',
    'c': '⠉',
    'd': '⠙',
    'e': '⠑',
    'f': '⠋',
    'g': '⠛',
    'h': '⠓',
    'i': '⠊',
    'j': '⠚',
    'k': '⠅',
    'l': '⠇',
    'm': '⠍',
    'n': '⠝',
    'o': '⠕',
    'p': '⠏',
    'q': '⠟',
    'r': '⠗',
    's': '⠎',
    't': '⠞',
    'u': '⠥',
    'v': '⠧',
    'w': '⠺',
    'x': '⠭',
    'y': '⠽',
    'z': '⠵',
    '1': '⠁',
    '2': '⠃',
    '3': '⠉',
    '4': '⠙',
    '5': '⠑',
    '6': '⠋',
    '7': '⠛',
    '8': '⠓',
    '9': '⠊',
    '0': '⠚',
    ',': '⠂',
    ';': '⠆',
    ':': '⠒',
    '.': '⠲',
    '!': '⠖',
    '(': '⠶',
    ')': '⠶',
    '?': '⠦',
    '/': '⠌',
    '-': '⠤',
    '‘': '⠄',
    '“': '⠄',
    '*': '⠔',
    '\'': '⠄',
    '@': '⠈',
    '#': '⠼',
    ' ': ' ',
  };

  String convertToBraille(String text) {
    return text
        .toLowerCase()
        .split('')
        .map((char) => _brailleMap[char] ?? ' ')
        .join('');
  }
}

class BrailleText extends StatefulWidget {
  final String text;
  final double textSize;

  const BrailleText({super.key, required this.text, this.textSize = 24.0});

  @override
  BrailleTextState createState() => BrailleTextState();
}

class BrailleTextState extends State<BrailleText> {
  Offset? lastPosition;
  int _lastCharIndex = -1;

  @override
  Widget build(BuildContext context) {
    BrailleConverter converter = BrailleConverter();
    String brailleText = converter.convertToBraille(widget.text);

    return GestureDetector(
      onPanUpdate: (details) {
        _handleSlide(details.localPosition);
      },
      onPanEnd: (details) {
        lastPosition = null;
        _lastCharIndex = -1;
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          brailleText,
          style: TextStyle(
            fontFamily: 'Braille', // Use a custom Braille font
            fontSize: widget.textSize,
          ),
        ),
      ),
    );
  }

  void _handleSlide(Offset position) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(position);

    int charIndex = _getCharIndexAtPosition(localPosition);
    if (charIndex != _lastCharIndex) {
      HapticFeedback.lightImpact(); // Trigger tactile feedback
      _lastCharIndex = charIndex;
    }

    lastPosition = position;
  }

  int _getCharIndexAtPosition(Offset position) {
    // Approximate the character index based on the position
    double charWidth =
        widget.textSize * 0.6; // Approximate width of a Braille character
    int index = (position.dx / charWidth).floor();
    return index.clamp(0, widget.text.length - 1);
  }
}
