import 'package:item_task/common/core/domain/entities/stockable.dart';

class InventoryItem implements Stockable {
  @override
  final String id;
  @override
  final String name;
  @override
  final double quantity;
  @override
  final double cost;
  @override
  final String unit;
  @override
  final String category;

  @override
  final bool isWaste;

  /// ID of the transformation that produced this item
  final String? sourceTransformationId;

  InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.cost,
    required this.unit,
    required this.category,
    this.isWaste = false,
    this.sourceTransformationId,
  });

  @override
  Stockable createReduced({required double quantity, required double cost}) {
    return copyWith(quantity: quantity, cost: cost);
  }

  @override
  Stockable withSourceTransformationId(String id) {
    return copyWith(sourceTransformationId: id);
  }

  InventoryItem copyWith({
    String? id,
    String? name,
    double? quantity,
    double? cost,
    String? unit,
    String? category,
    bool? isWaste,
    String? sourceTransformationId,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      cost: cost ?? this.cost,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      isWaste: isWaste ?? this.isWaste,
      sourceTransformationId:
          sourceTransformationId ?? this.sourceTransformationId,
    );
  }
}
