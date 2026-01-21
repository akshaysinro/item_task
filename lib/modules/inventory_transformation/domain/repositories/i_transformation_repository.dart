import '../entities/inventory_item.dart';
import '../../../../common/core/domain/entities/stockable.dart';

abstract class ITransformationRepository {
  Future<List<InventoryItem>> getStockItems();
  Future<void> saveTransformationResult(List<Stockable> results);
}
