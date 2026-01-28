import 'package:item_task/common/core/domain/entities/stockable.dart';

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

  /// Main outputs (usable products that are not by-products)
  List<Stockable> get mainOutputs => outputs.where((item) {
    return !item.isWaste && item.category != 'by_products';
  }).toList();

  /// By-products (complementary usable products)
  List<Stockable> get byProducts => outputs.where((item) {
    return item.category == 'by_products';
  }).toList();

  /// Actual waste items
  List<Stockable> get wasteItems => waste;

  /// Total output quantity (excluding waste)
  double get totalOutputQuantity =>
      outputs.fold(0.0, (sum, item) => sum + item.quantity);

  /// Total waste quantity
  double get totalWasteQuantity =>
      waste.fold(0.0, (sum, item) => sum + item.quantity);

  /// Yield percentage (output / input * 100)
  double get yieldPercentage => (quantityTransformed > 0)
      ? (totalOutputQuantity / quantityTransformed) * 100
      : 0.0;

  /// Waste percentage (waste / input * 100)
  double get wastePercentage => (quantityTransformed > 0)
      ? (totalWasteQuantity / quantityTransformed) * 100
      : 0.0;

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
