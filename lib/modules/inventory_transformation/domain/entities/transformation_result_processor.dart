import 'transformation_result.dart';
import '../../../../common/core/domain/entities/stockable.dart';
import '../entities/inventory_item.dart';

/// Processor for transformation result calculations and filtering
class TransformationResultProcessor {
  /// Main outputs (meat_cuts category)
  static List<Stockable> getMainOutputs(TransformationResult result) {
    return result.outputs.where((item) => _isMainOutput(item)).toList();
  }

  /// By-products (by_products category, not waste)
  static List<Stockable> getByProducts(TransformationResult result) {
    return result.outputs.where((item) => _isByProduct(item)).toList();
  }

  /// Total output quantity (excluding waste)
  static double getTotalOutputQuantity(TransformationResult result) {
    return result.outputs.fold(0.0, (sum, item) => sum + item.quantity);
  }

  /// Total waste quantity
  static double getTotalWasteQuantity(TransformationResult result) {
    return result.waste.fold(0.0, (sum, item) => sum + item.quantity);
  }

  /// Yield percentage (output / input * 100)
  static double getYieldPercentage(TransformationResult result) {
    final totalOutput = getTotalOutputQuantity(result);
    return (totalOutput / result.quantityTransformed) * 100;
  }

  /// Waste percentage (waste / input * 100)
  static double getWastePercentage(TransformationResult result) {
    final totalWaste = getTotalWasteQuantity(result);
    return (totalWaste / result.quantityTransformed) * 100;
  }

  /// Total cost allocated to outputs
  static double getTotalOutputCost(TransformationResult result) {
    return result.outputs.fold(0.0, (sum, item) => sum + item.cost);
  }

  /// Number of main output items
  static int getOutputCount(TransformationResult result) {
    return getMainOutputs(result).length;
  }

  /// Number of by-product items
  static int getByProductCount(TransformationResult result) {
    return getByProducts(result).length;
  }

  /// Number of waste items
  static int getWasteCount(TransformationResult result) {
    return result.waste.length;
  }

  static bool _isMainOutput(Stockable item) {
    if (item is InventoryItem) {
      return item.category == 'meat_cuts' ||
          item.category == 'beverage' ||
          (!item.isWaste && item.category != 'by_products');
    }
    return true;
  }

  static bool _isByProduct(Stockable item) {
    if (item is InventoryItem) {
      return item.category == 'by_products' && !item.isWaste;
    }
    return false;
  }
}