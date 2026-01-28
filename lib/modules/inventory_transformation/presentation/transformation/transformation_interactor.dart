import 'package:item_task/common/core/domain/entities/stockable.dart';
import '../../domain/repositories/i_transformation_repository.dart';
import '../../domain/usecases/i_transform_item_usecase.dart';
import '../../domain/entities/transformation_result.dart';
import '../../domain/service/transformation_strategy.dart';

abstract class ITransformationInteractor {
  Future<List<Stockable>> fetchAvailableItems();
  Future<TransformationResult> transformItem(
    Stockable item,
    ITransformationStrategy strategy,
    double quantity,
  );
}

class TransformationInteractor implements ITransformationInteractor {
  final ITransformationRepository repository;
  final ITransformItemUseCase transformUseCase;

  TransformationInteractor({
    required this.repository,
    required this.transformUseCase,
  });

  @override
  Future<List<Stockable>> fetchAvailableItems() {
    return repository.getStockItems();
  }

  @override
  Future<TransformationResult> transformItem(
    Stockable item,
    ITransformationStrategy strategy,
    double quantity,
  ) {
    return transformUseCase(
      input: item,
      strategy: strategy,
      quantity: quantity,
    );
  }
}
