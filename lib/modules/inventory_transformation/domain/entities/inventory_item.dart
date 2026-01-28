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

  InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.cost,
    required this.unit,
    required this.category,
    this.isWaste = false,
  });
}
