import '../../../../common/core/domain/entities/stockable.dart';
import 'transformation_result_processor.dart';

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
      TransformationResultProcessor.getMainOutputs(this);

  /// By-products (by_products category, not waste)
  List<Stockable> get byProducts =>
      TransformationResultProcessor.getByProducts(this);

  /// Actual waste items (isWaste = true)
  List<Stockable> get wasteItems => waste;

  /// Total output quantity (excluding waste)
  double get totalOutputQuantity =>
      TransformationResultProcessor.getTotalOutputQuantity(this);

  /// Total waste quantity
  double get totalWasteQuantity =>
      TransformationResultProcessor.getTotalWasteQuantity(this);

  /// Yield percentage (output / input * 100)
  double get yieldPercentage =>
      TransformationResultProcessor.getYieldPercentage(this);

  /// Waste percentage (waste / input * 100)
  double get wastePercentage =>
      TransformationResultProcessor.getWastePercentage(this);

  /// Total cost allocated to outputs
  double get totalOutputCost =>
      TransformationResultProcessor.getTotalOutputCost(this);

  /// Number of main output items
  int get outputCount => TransformationResultProcessor.getOutputCount(this);

  /// Number of by-product items
  int get byProductCount =>
      TransformationResultProcessor.getByProductCount(this);

  /// Number of waste items
  int get wasteCount => TransformationResultProcessor.getWasteCount(this);
}
