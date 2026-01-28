import 'package:item_task/common/core/domain/entities/stockable.dart';

abstract class ITransformationRepository {
  Future<List<Stockable>> getStockItems();
  Future<void> saveTransformationResult(List<Stockable> results);
}
