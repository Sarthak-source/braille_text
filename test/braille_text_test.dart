import 'package:braille_text/braille_text.dart'; // Adjust the import path based on your project structure
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BrailleConverter', () {
    final brailleConverter = BrailleConverter();

    test('should convert single character to Braille', () {
      expect(brailleConverter.convertToBraille('a'), '⠁');
      expect(brailleConverter.convertToBraille('b'), '⠃');
      expect(brailleConverter.convertToBraille('c'), '⠉');
    });

    test('should convert full text to Braille', () {
      expect(brailleConverter.convertToBraille('hello'), '⠓⠑⠇⠇⠕');
      expect(brailleConverter.convertToBraille('world'), '⠺⠕⠗⠇⠙');
    });

    test('should handle numbers correctly', () {
      expect(brailleConverter.convertToBraille('123'), '⠁⠃⠉');
      expect(brailleConverter.convertToBraille('456'), '⠙⠑⠋');
    });

    test('should handle special characters correctly', () {
      expect(brailleConverter.convertToBraille(',;:.!?'), '⠂⠆⠒⠲⠖⠦');
      expect(brailleConverter.convertToBraille('()@#'), '⠶⠶⠈⠼');
    });

    test('should handle unsupported characters as space', () {
      expect(brailleConverter.convertToBraille('~`|'), '   '); // Adjust based on actual handling
    });

    test('should handle empty string', () {
      expect(brailleConverter.convertToBraille(''), '');
    });

    test('should handle mixed content', () {
      expect(brailleConverter.convertToBraille('Hello World 123!'), '⠓⠑⠇⠇⠕ ⠺⠕⠗⠇⠙ ⠁⠃⠉⠖');
    });
  });
}
