import 'package:flutter_test/flutter_test.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';
import 'package:pro_matrimony/utils/utils.dart';

void main() {
  group('getSelectedSingleItem Tests', () {
    test('returns matching item when id matches', () {
      final list = [
        DropdownOptionModel(id: '1', val: 'One'),
        DropdownOptionModel(id: '2', val: 'Two'),
      ];
      final result = getSelectedSingleItem(list, '1');
      expect(result.id, '1');
      expect(result.val, 'One');
    });

    test('returns matching item when val matches', () {
      final list = [
        DropdownOptionModel(id: '1', val: 'One'),
        DropdownOptionModel(id: '2', val: 'Two'),
      ];
      final result = getSelectedSingleItem(list, 'Two');
      expect(result.id, '2');
      expect(result.val, 'Two');
    });

    test('returns empty DropdownOptionModel when not found', () {
      final list = [
        DropdownOptionModel(id: '1', val: 'One'),
      ];
      final result = getSelectedSingleItem(list, '999');
      expect(result.id, isNull);
    });
  });
}
