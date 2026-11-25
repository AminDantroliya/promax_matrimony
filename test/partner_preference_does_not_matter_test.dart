import 'package:flutter_test/flutter_test.dart';
import 'package:pro_matrimony/features/common/data/models/dropdown_models.dart';

void main() {
  group('Partner Preference Does Not Matter Logic Tests', () {
    test('Partner Preference field name / label detection', () {
      bool isPartnerField(String name, String label) {
        return name.toLowerCase().startsWith('part_') ||
            name.toLowerCase().startsWith('partner_') ||
            label.toLowerCase().contains('partner');
      }

      expect(isPartnerField('part_religion', 'Partner Religion'), isTrue);
      expect(isPartnerField('part_caste', 'Caste'), isTrue);
      expect(isPartnerField('part_country', 'Country'), isTrue);
      expect(isPartnerField('partner_income', 'Income'), isTrue);
      expect(isPartnerField('religion', 'Partner Religion'), isTrue);

      // Personal fields should NOT be detected as partner
      expect(isPartnerField('religion', 'Religion'), isFalse);
      expect(isPartnerField('caste', 'Caste'), isFalse);
      expect(isPartnerField('marital_status', 'Marital Status'), isFalse);
      expect(isPartnerField('country_id', 'Country'), isFalse);
    });

    test('Effective items prepends Does Not Matter at index 0 for partner fields', () {
      final originalItems = [
        DropdownOptionModel(id: '1', val: 'Hinduism'),
        DropdownOptionModel(id: '2', val: 'Islam'),
        DropdownOptionModel(id: '3', val: 'Christianity'),
      ];

      List<DropdownOptionModel> getEffectiveItems(
          List<DropdownOptionModel> items, bool isPartner) {
        if (!isPartner || items.isEmpty) return items;
        final hasDnm = items.any((e) =>
            e.id?.toString() == 'DOES_NOT_MATTER' ||
            e.val?.toString().toLowerCase() == 'does not matter');
        if (hasDnm) return items;
        return [
          DropdownOptionModel(id: 'DOES_NOT_MATTER', val: 'Does Not Matter'),
          ...items,
        ];
      }

      final partnerItems = getEffectiveItems(originalItems, true);
      expect(partnerItems.length, 4);
      expect(partnerItems[0].id, 'DOES_NOT_MATTER');
      expect(partnerItems[0].val, 'Does Not Matter');
      expect(partnerItems[1].val, 'Hinduism');

      // Non-partner fields should remain untouched
      final nonPartnerItems = getEffectiveItems(originalItems, false);
      expect(nonPartnerItems.length, 3);
      expect(nonPartnerItems[0].val, 'Hinduism');
    });

    test('Mutual exclusivity: selecting Does Not Matter deselects other options', () {
      final selected = <String>{'1', '2'}; // Hinduism, Islam

      void onToggle(String itemId, bool isChecked, bool isPartner) {
        if (isChecked) {
          if (isPartner && itemId == 'DOES_NOT_MATTER') {
            selected.clear();
            selected.add('DOES_NOT_MATTER');
          } else {
            if (isPartner) {
              selected.remove('DOES_NOT_MATTER');
            }
            selected.add(itemId);
          }
        } else {
          selected.remove(itemId);
        }
      }

      // 1. User checks Does Not Matter
      onToggle('DOES_NOT_MATTER', true, true);
      expect(selected, {'DOES_NOT_MATTER'});
      expect(selected.contains('1'), isFalse);
      expect(selected.contains('2'), isFalse);

      // 2. User checks Hinduism ('1') -> Does Not Matter is deselected
      onToggle('1', true, true);
      expect(selected.contains('DOES_NOT_MATTER'), isFalse);
      expect(selected.contains('1'), isTrue);

      // 3. User checks Islam ('2') -> both '1' and '2' are selected
      onToggle('2', true, true);
      expect(selected.contains('DOES_NOT_MATTER'), isFalse);
      expect(selected, {'1', '2'});

      // 4. User checks Does Not Matter again -> both '1' and '2' are deselected
      onToggle('DOES_NOT_MATTER', true, true);
      expect(selected, {'DOES_NOT_MATTER'});
    });

    test('API serialization: Does Not Matter serializes to empty string', () {
      String serializeEditProfile(dynamic val) {
        if (val == null) return '';
        if (val is List<DropdownOptionModel>) {
          return val
              .map((e) => e.id ?? e.val ?? '')
              .where((id) => id.toString().isNotEmpty && id != 'DOES_NOT_MATTER')
              .join(',');
        }
        if (val is DropdownOptionModel) {
          if (val.id == 'DOES_NOT_MATTER' || val.val == 'Does Not Matter') return '';
          return (val.id ?? val.val ?? '').toString();
        }
        if (val is List) {
          return val
              .map((e) {
                if (e is DropdownOptionModel) return e.id ?? e.val ?? '';
                return e.toString();
              })
              .where((s) => s.toString().isNotEmpty && s != 'DOES_NOT_MATTER')
              .join(',');
        }
        final str = val.toString().trim();
        if (str == 'DOES_NOT_MATTER') return '';
        return str;
      }

      // Edit profile serialization with DOES_NOT_MATTER
      expect(serializeEditProfile('DOES_NOT_MATTER'), '');
      expect(serializeEditProfile(['DOES_NOT_MATTER']), '');
      expect(
          serializeEditProfile([
            DropdownOptionModel(id: 'DOES_NOT_MATTER', val: 'Does Not Matter')
          ]),
          '');
      expect(
          serializeEditProfile(
              DropdownOptionModel(id: 'DOES_NOT_MATTER', val: 'Does Not Matter')),
          '');

      // Edit profile serialization with normal values
      expect(serializeEditProfile('1,2'), '1,2');
      expect(
          serializeEditProfile([
            DropdownOptionModel(id: '1', val: 'Hinduism'),
            DropdownOptionModel(id: '2', val: 'Islam'),
          ]),
          '1,2');

      // Register serialization with List<DropdownOptionModel>
      String serializeRegisterList(List<DropdownOptionModel> val) {
        return val
            .map((e) => e.id.toString())
            .where((id) => id.isNotEmpty && id != 'DOES_NOT_MATTER')
            .join(',');
      }

      expect(
        serializeRegisterList([
          DropdownOptionModel(id: 'DOES_NOT_MATTER', val: 'Does Not Matter')
        ]),
        '',
      );
      expect(
        serializeRegisterList([
          DropdownOptionModel(id: '1', val: 'Hinduism'),
          DropdownOptionModel(id: '2', val: 'Islam'),
        ]),
        '1,2',
      );
    });
  });
}
