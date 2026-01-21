import 'package:flutter/material.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/inventory_item.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_strategy.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/strategy_metadata.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/strategy_plugin_registry.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'package:item_task/common/core/domain/entities/categorizable.dart';

/// Example: Juice extraction strategy for fruits
/// This is a SELF-REGISTERING plugin - no factory modification needed!
class JuiceStrategy implements ITransformationStrategy {
  // Auto-register this strategy when the class is loaded
  // ignore: unused_field
  static final _registered = (() {
    StrategyPluginRegistry.register(JuiceStrategy());
    return true;
  })();

  @override
  StrategyMetadata get metadata => const StrategyMetadata(
    key: 'juice',
    label: 'Juice',
    color: Color(0xFFF59E0B), // Amber color
    icon: Icons.local_drink,
  );

  @override
  bool canExecute(Categorizable input) => input.category == 'fruit';

  @override
  List<Stockable> execute(Stockable input) {
    // For fruits, we extract juice (70%) and have pulp/waste (30%)
    final juiceQuantity = input.quantity * 0.7;
    final pulpQuantity = input.quantity * 0.3;

    return [
      InventoryItem(
        id: '${input.id}_juice',
        name: '${input.name} Juice',
        quantity: juiceQuantity,
        cost: input.cost,
        unit: 'liters', // Converted to liters
        category: 'beverage',
      ),
      InventoryItem(
        id: '${input.id}_pulp',
        name: '${input.name} Pulp (Waste)',
        quantity: pulpQuantity,
        cost: 0,
        unit: input.unit,
        category: input.category,
        isWaste: true,
      ),
    ];
  }
}
