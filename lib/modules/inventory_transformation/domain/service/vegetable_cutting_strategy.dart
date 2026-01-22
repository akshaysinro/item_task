import 'package:flutter/material.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/inventory_item.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_strategy.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/strategy_metadata.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'package:item_task/common/core/domain/entities/categorizable.dart';
import 'package:injectable/injectable.dart';

@Named('veg_cut')
@Injectable(as: ITransformationStrategy)
class VegetableCuttingStrategy implements ITransformationStrategy {
  @override
  StrategyMetadata get metadata => const StrategyMetadata(
    key: 'veg_cut',
    label: 'Cut',
    color: Color(0xFF10B981),
    icon: Icons.content_cut,
  );

  @override
  bool canExecute(Categorizable input) =>
      input.category == 'vegetable' || input.category == 'veg';

  @override
  List<Stockable> execute(Stockable input) {
    // For vegetables, we might have 90% usable yield and 10% peels/waste
    final usableQuantity = input.quantity * 0.9;
    final wasteQuantity = input.quantity * 0.1;

    return [
      InventoryItem(
        id: '${input.id}_chopped',
        name: 'Chopped ${input.name}',
        quantity: usableQuantity,
        cost: input
            .cost, // Cost usually remains same for prepared veg in simple model
        unit: input.unit,
        category: input.category,
      ),
      InventoryItem(
        id: '${input.id}_peels',
        name: '${input.name} Peels (Waste)',
        quantity: wasteQuantity,
        cost: 0,
        unit: input.unit,
        category: input.category,
        isWaste: true,
      ),
    ];
  }
}
