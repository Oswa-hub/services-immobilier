import 'package:flutter_test/flutter_test.dart';
import 'package:team_app/core/utils/validators.dart';

void main() {
  group('email', () {
    test('required', () => expect(Validators.email(' '), isNotNull));
    test('invalid', () => expect(Validators.email('john@'), isNotNull));
    test('valid', () => expect(Validators.email('john@example.com'), isNull));
  });

  group('phone', () {
    test('accepts local and international forms', () {
      for (final p in ['22123456', '22 123 456', '+21622123456', '0021622123456']) {
        expect(Validators.phone(p), isNull, reason: p);
      }
    });
    test('rejects bad numbers', () {
      for (final p in ['', '123', '12345678', '+3312345678']) {
        expect(Validators.phone(p), isNotNull, reason: p);
      }
    });
    test('normalizes to +216XXXXXXXX', () {
      expect(Validators.normalizePhone('22 123 456'), '+21622123456');
      expect(Validators.normalizePhone('0021622123456'), '+21622123456');
    });
  });

  group('password', () {
    test('rules', () {
      expect(Validators.password('Abc12345'), isNull);
      expect(Validators.password('abc12345'), isNotNull); // no uppercase
      expect(Validators.password('Abcdefgh'), isNotNull); // no number
      expect(Validators.password('Ab1'), isNotNull); // too short
    });
    test('confirm', () {
      expect(Validators.confirmPassword('x', 'y'), isNotNull);
      expect(Validators.confirmPassword('y', 'y'), isNull);
    });
  });

  test('full name', () {
    expect(Validators.fullName('  '), isNotNull);
    expect(Validators.fullName('Yahya B'), isNull);
  });
}
