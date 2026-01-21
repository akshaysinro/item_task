import '../../domain/repositories/i_transformation_repository.dart';
import '../../domain/usecases/i_transform_item_usecase.dart';
import '../../domain/entities/inventory_item.dart';
import '../../domain/entities/transformation_result.dart';
import '../../domain/service/transformation_strategy.dart';

abstract class ITransformationInteractor {
  Future<List<InventoryItem>> fetchAvailableItems();
  Future<TransformationResult> transformItem(
    InventoryItem item,
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
  Future<List<InventoryItem>> fetchAvailableItems() {
    return repository.getStockItems();
  }

  @override
  Future<TransformationResult> transformItem(
    InventoryItem item,
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
