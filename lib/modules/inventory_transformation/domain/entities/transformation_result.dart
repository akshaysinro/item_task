import '../../../../common/core/domain/entities/stockable.dart';
import '../entities/inventory_item.dart';

/// Result of a transformation operation
/// Contains outputs, by-products, waste, and summary statistics
class TransformationResult {
  final Stockable originalItem;
  final double quantityTransformed;
  final List<Stockable> outputs;
  final List<Stockable> waste;
  final DateTime timestamp;

  TransformationResult({
    required this.originalItem,
    required this.quantityTransformed,
    required this.outputs,
    required this.waste,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Main outputs (meat_cuts category)
  List<Stockable> get mainOutputs =>
      outputs.where((item) => _isMainOutput(item)).toList();

  /// By-products (by_products category, not waste)
  List<Stockable> get byProducts =>
      outputs.where((item) => _isByProduct(item)).toList();

  /// Actual waste items (isWaste = true)
  List<Stockable> get wasteItems => waste;

  bool _isMainOutput(Stockable item) {
    if (item is InventoryItem) {
      return item.category == 'meat_cuts' ||
          item.category == 'beverage' ||
          (!item.isWaste && item.category != 'by_products');
    }
    return true;
  }

  bool _isByProduct(Stockable item) {
    if (item is InventoryItem) {
      return item.category == 'by_products' && !item.isWaste;
    }
    return false;
  }

  /// Total output quantity (excluding waste)
  double get totalOutputQuantity =>
      outputs.fold(0.0, (sum, item) => sum + item.quantity);

  /// Total waste quantity
  double get totalWasteQuantity =>
      waste.fold(0.0, (sum, item) => sum + item.quantity);

  /// Yield percentage (output / input * 100)
  double get yieldPercentage =>
      (totalOutputQuantity / quantityTransformed) * 100;

  /// Waste percentage (waste / input * 100)
  double get wastePercentage =>
      (totalWasteQuantity / quantityTransformed) * 100;

  /// Total cost allocated to outputs
  double get totalOutputCost =>
      outputs.fold(0.0, (sum, item) => sum + item.cost);

  /// Number of main output items
  int get outputCount => mainOutputs.length;

  /// Number of by-product items
  int get byProductCount => byProducts.length;

  /// Number of waste items
  int get wasteCount => waste.length;
}
