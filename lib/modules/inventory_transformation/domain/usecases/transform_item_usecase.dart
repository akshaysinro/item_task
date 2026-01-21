import '../../../../common/core/domain/entities/stockable.dart';
import '../service/transformation_strategy.dart';
import '../repositories/i_transformation_repository.dart';
import '../entities/transformation_result.dart';
import '../entities/inventory_item.dart';
import 'i_transform_item_usecase.dart';

class TransformItemUseCase implements ITransformItemUseCase {
  final ITransformationRepository repository;

  TransformItemUseCase(this.repository);

  @override
  Future<TransformationResult> call({
    required Stockable input,
    required ITransformationStrategy strategy,
    required double quantity,
  }) async {
    // Create a partial item with the specified quantity
    final partialInput = _createPartialItem(input, quantity);

    // Execute transformation
    final results = strategy.execute(partialInput);

    // Separate outputs and waste
    final outputs = <Stockable>[];
    final waste = <Stockable>[];

    for (final result in results) {
      if (result is InventoryItem && result.isWaste) {
        waste.add(result);
      } else {
        outputs.add(result);
      }
    }

    // Save results to repository
    await repository.saveTransformationResult(results);

    // Return transformation result
    return TransformationResult(
      originalItem: input,
      quantityTransformed: quantity,
      outputs: outputs,
      waste: waste,
    );
  }

  Stockable _createPartialItem(Stockable original, double quantity) {
    // Create a new item with the specified quantity
    // Cost is proportionally allocated
    final costPerUnit = original.cost / original.quantity;
    final partialCost = costPerUnit * quantity;

    return InventoryItem(
      id: original.id,
      name: original.name,
      quantity: quantity,
      cost: partialCost,
      unit: original.unit,
      category: original.category,
    );
  }
}
