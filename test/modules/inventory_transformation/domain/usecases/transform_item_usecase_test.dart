import 'package:flutter_test/flutter_test.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/inventory_item.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/transformation_result.dart';
import 'package:item_task/modules/inventory_transformation/domain/repositories/i_transformation_repository.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_strategy.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/strategy_metadata.dart';
import 'package:item_task/modules/inventory_transformation/domain/usecases/transform_item_usecase.dart';

class MockRepository implements ITransformationRepository {
  List<Stockable>? savedResults;

  @override
  Future<List<Stockable>> getStockItems() async => [];

  @override
  Future<void> saveTransformationResult(List<Stockable> results) async {
    savedResults = results;
  }
}

class MockStrategy implements ITransformationStrategy {
  @override
  StrategyMetadata get metadata => throw UnimplementedError();

  @override
  bool canExecute(Stockable input) => true;

  @override
  List<Stockable> execute(Stockable input) {
    return [
      InventoryItem(
        id: 'output_1',
        name: 'Output 1',
        quantity: input.quantity * 0.8,
        cost: input.cost,
        unit: 'kg',
        category: 'meat_cuts',
      ),
      InventoryItem(
        id: 'waste_1',
        name: 'Waste 1',
        quantity: input.quantity * 0.2,
        cost: 0,
        unit: 'kg',
        category: 'waste',
        isWaste: true,
      ),
    ];
  }
}

void main() {
  group('TransformItemUseCase', () {
    late TransformItemUseCase useCase;
    late MockRepository repository;
    late MockStrategy strategy;

    setUp(() {
      repository = MockRepository();
      useCase = TransformItemUseCase(repository);
      strategy = MockStrategy();
    });

    test(
      'should orchestrate transformation and generate traceability IDs',
      () async {
        final input = InventoryItem(
          id: 'input_1',
          name: 'Input',
          quantity: 10.0,
          cost: 100.0,
          unit: 'kg',
          category: 'meat',
        );

        final result = await useCase(
          input: input,
          strategy: strategy,
          quantity: 10.0,
          batchId: 'batch_xyz',
        );

        // Verify Transformation ID generation
        expect(result.id.startsWith('tr_'), true);
        expect(result.batchId, 'batch_xyz');

        // Verify that output items are linked to the transformation ID
        final output = result.outputs.first as InventoryItem;
        expect(output.sourceTransformationId, result.id);

        final waste = result.waste.first as InventoryItem;
        expect(waste.sourceTransformationId, result.id);

        // Verify repository was called with linked items
        expect(repository.savedResults, isNotNull);
        expect(
          (repository.savedResults!.first as InventoryItem)
              .sourceTransformationId,
          result.id,
        );
      },
    );

    test('should handle partial transformations correctly', () async {
      final input = InventoryItem(
        id: 'input_1',
        name: 'Input',
        quantity: 10.0,
        cost: 100.0,
        unit: 'kg',
        category: 'meat',
      );

      // Transform only 5kg (half)
      final result = await useCase(
        input: input,
        strategy: strategy,
        quantity: 5.0,
      );

      expect(result.quantityTransformed, 5.0);

      // Strategy used 5kg, so outputs should reflect that (80% yield = 4kg)
      expect(result.outputs.first.quantity, 4.0);

      // Cost should be proportional (half cost = 50.0)
      expect(result.outputs.first.cost, 50.0);
    });
  });
}
