import 'package:flutter_test/flutter_test.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/inventory_item.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/transformation_result.dart';

void main() {
  group('TransformationResult', () {
    final originalItem = InventoryItem(
      id: 'item_1',
      name: 'Whole Chicken',
      quantity: 2.0,
      cost: 10.0,
      unit: 'kg',
      category: 'meat',
    );

    final output1 = InventoryItem(
      id: 'out_1',
      name: 'Chicken Breast',
      quantity: 0.5,
      cost: 4.0,
      unit: 'kg',
      category: 'meat_cuts',
      sourceTransformationId: 'tr_1',
    );

    final output2 = InventoryItem(
      id: 'out_2',
      name: 'Chicken Legs',
      quantity: 0.6,
      cost: 4.0,
      unit: 'kg',
      category: 'meat_cuts',
      sourceTransformationId: 'tr_1',
    );

    final byProduct = InventoryItem(
      id: 'bp_1',
      name: 'Bones',
      quantity: 0.5,
      cost: 2.0,
      unit: 'kg',
      category: 'by_products',
      sourceTransformationId: 'tr_1',
    );

    final waste = InventoryItem(
      id: 'w_1',
      name: 'Skin',
      quantity: 0.4,
      cost: 0.0,
      unit: 'kg',
      category: 'waste',
      isWaste: true,
      sourceTransformationId: 'tr_1',
    );

    final result = TransformationResult(
      id: 'tr_1',
      originalItem: originalItem,
      quantityTransformed: 2.0,
      outputs: [output1, output2, byProduct],
      waste: [waste],
    );

    test(
      'should correctly calculate total output quantity excluding waste',
      () {
        expect(result.totalOutputQuantity, 1.6); // 0.5 + 0.6 + 0.5
      },
    );

    test('should correctly calculate total waste quantity', () {
      expect(result.totalWasteQuantity, 0.4);
    });

    test('should correctly calculate yield percentage', () {
      expect(result.yieldPercentage, 80.0); // (1.6 / 2.0) * 100
    });

    test('should correctly calculate waste percentage', () {
      expect(result.wastePercentage, 20.0); // (0.4 / 2.0) * 100
    });

    test('should correctly calculate total output cost', () {
      expect(result.totalOutputCost, 10.0); // 4 + 4 + 2
    });

    test('should filter main outputs correctly', () {
      expect(result.mainOutputs.length, 2);
      expect(result.mainOutputs.any((i) => i.name == 'Chicken Breast'), true);
      expect(result.mainOutputs.any((i) => i.name == 'Chicken Legs'), true);
    });

    test('should filter by-products correctly', () {
      expect(result.byProducts.length, 1);
      expect(result.byProducts.first.name, 'Bones');
    });

    test('should handle zero quantity transformed gracefully', () {
      final zeroResult = TransformationResult(
        id: 'tr_zero',
        originalItem: originalItem,
        quantityTransformed: 0.0,
        outputs: [],
        waste: [],
      );
      expect(zeroResult.yieldPercentage, 0.0);
      expect(zeroResult.wastePercentage, 0.0);
    });
  });
}
