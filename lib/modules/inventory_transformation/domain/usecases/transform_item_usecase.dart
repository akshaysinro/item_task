import 'package:item_task/common/core/domain/entities/stockable.dart';
import '../service/transformation_strategy.dart';
import '../repositories/i_transformation_repository.dart';
import '../entities/transformation_result.dart';
import 'i_transform_item_usecase.dart';

class TransformItemUseCase implements ITransformItemUseCase {
  final ITransformationRepository repository;

  TransformItemUseCase(this.repository);

  @override
  Future<TransformationResult> call({
    required Stockable input,
    required ITransformationStrategy strategy,
    required double quantity,
    String? batchId,
  }) async {
    final transformationId =
        'tr_${DateTime.now().millisecondsSinceEpoch}_${input.id.hashCode % 1000}';

    final partialInput = _createPartialItem(input, quantity);
    final strategyResults = strategy.execute(partialInput);

    final outputs = <Stockable>[];
    final waste = <Stockable>[];

    final processedResults = strategyResults.map((item) {
      return item.withSourceTransformationId(transformationId);
    }).toList();

    for (final result in processedResults) {
      if (result.isWaste) {
        waste.add(result);
      } else {
        outputs.add(result);
      }
    }

    await repository.saveTransformationResult(processedResults);

    return TransformationResult(
      id: transformationId,
      batchId: batchId,
      originalItem: input,
      quantityTransformed: quantity,
      outputs: outputs,
      waste: waste,
    );
  }

  Stockable _createPartialItem(Stockable original, double quantity) {
    final costPerUnit = original.cost / original.quantity;
    final partialCost = costPerUnit * quantity;

    return original.createReduced(quantity: quantity, cost: partialCost);
  }
}
