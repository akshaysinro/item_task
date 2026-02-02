import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/inventory_item.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/base_transformation_strategy.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_configuration.dart';

class TestTransformationStrategy extends BaseTransformationStrategy {
  @override
  final ITransformationConfiguration config;
  TestTransformationStrategy(this.config);
}

class MockButcheryConfig implements ITransformationConfiguration {
  @override
  String get key => 'test_butchery';
  @override
  String get label => 'Test Butchery';
  @override
  Color get color => Colors.red;
  @override
  IconData get icon => Icons.restaurant;
  @override
  String get inputCategory => 'test_meat';

  @override
  bool matches(Stockable item) => item.category == inputCategory;

  @override
  List<YieldConfig> get yields => const [
    YieldConfig(
      suffix: 'cut1',
      name: 'Cut 1',
      weightFactor: 0.5,
      costFactor: 1.0,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'cut2',
      name: 'Cut 2',
      weightFactor: 0.3,
      costFactor: 1.5,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'waste',
      name: 'Waste',
      weightFactor: 0.2,
      costFactor: 0.0,
      category: 'waste',
      isWaste: true,
    ),
  ];
}

void main() {
  group('BaseButcheryStrategy', () {
    late TestTransformationStrategy strategy;
    late MockButcheryConfig config;

    setUp(() {
      config = MockButcheryConfig();
      strategy = TestTransformationStrategy(config);
    });

    test('should identify if it can execute based on configuration', () {
      final validItem = InventoryItem(
        id: '1',
        name: 'Item',
        quantity: 1,
        cost: 1,
        unit: 'kg',
        category: 'test_meat',
      );
      final invalidItem = InventoryItem(
        id: '2',
        name: 'Item',
        quantity: 1,
        cost: 1,
        unit: 'kg',
        category: 'vegetable',
      );

      expect(strategy.canExecute(validItem), true);
      expect(strategy.canExecute(invalidItem), false);
    });

    test('should correctly calculate yields and costs', () {
      final input = InventoryItem(
        id: 'input_1',
        name: 'Whole Meat',
        quantity: 10.0,
        cost: 100.0,
        unit: 'kg',
        category: 'test_meat',
      );

      final results = strategy.execute(input);

      expect(results.length, 3);

      // Calculations:
      // totalFactors = (10 * 0.5 * 1.0) + (10 * 0.3 * 1.5) + (10 * 0.2 * 0.0)
      // totalFactors = 5.0 + 4.5 + 0.0 = 9.5
      // costPerFactor = 100.0 / 9.5 approx 10.526

      final cut1 = results.firstWhere((r) => r.name == 'Cut 1');
      final cut2 = results.firstWhere((r) => r.name == 'Cut 2');
      final waste = results.firstWhere((r) => r.name == 'Waste');

      // Cut 1: weight = 10 * 0.5 = 5.0, cost = 5.0 * 1.0 * (100 / 9.5) = 52.63
      expect(cut1.quantity, 5.0);
      expect(cut1.cost, closeTo(52.63, 0.01));

      // Cut 2: weight = 10 * 0.3 = 3.0, cost = 3.0 * 1.5 * (100 / 9.5) = 47.37
      expect(cut2.quantity, 3.0);
      expect(cut2.cost, closeTo(47.37, 0.01));

      // Waste: weight = 10 * 0.2 = 2.0, cost = 0.0 (as isWaste is true)
      expect(waste.quantity, 2.0);
      expect(waste.cost, 0.0);
      expect(waste.isWaste, true);

      // Verify total cost allocation (should be 100.0)
      final totalCost = results.fold<double>(0, (sum, item) => sum + item.cost);
      expect(totalCost, closeTo(100.0, 0.001));
    });
  });
}
