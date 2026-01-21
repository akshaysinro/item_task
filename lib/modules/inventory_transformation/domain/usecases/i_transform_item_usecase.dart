import '../../../../common/core/domain/entities/stockable.dart';
import '../service/transformation_strategy.dart';
import '../entities/transformation_result.dart';

abstract class ITransformItemUseCase {
  Future<TransformationResult> call({
    required Stockable input,
    required ITransformationStrategy strategy,
    required double quantity,
  });
}
