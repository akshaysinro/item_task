import 'package:flutter/material.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/inventory_item.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_strategy.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/strategy_metadata.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'package:item_task/common/core/domain/entities/categorizable.dart';

/// Professional Whole Chicken Butchery Strategy
///
/// Breaks down a whole chicken into its primary cuts based on standard restaurant yields.
/// This strategy assumes the input is a whole chicken/bird and outputs usable parts and waste.
///
/// Standard Yield Assumptions (Approximate):
/// - Leg Quarters (Thigh + Drumstick): ~30%
/// - Breast Meat (Boneless/Skinless): ~25%
/// - Wings: ~10%
/// - Carcass/Rack (Used for Stock): ~25%
/// - Skin, Fat, Trim (Waste/Rendering): ~10%
class ButcheryStrategy implements ITransformationStrategy {
  @override
  StrategyMetadata get metadata => const StrategyMetadata(
    key: 'butcher_whole_chicken',
    label: 'Break Down Whole Chicken',
    color: Color(0xFFD2691E), // Chocolate color
    icon: Icons.restaurant,
  );

  @override
  bool canExecute(Categorizable input) => input.category == 'meat'; // Specifically for whole birds

  @override
  List<Stockable> execute(Stockable input) {
    final double totalQuantity = input.quantity;
    final double totalCost = input.cost;

    // 1. Calculate Weights
    final legWeight = totalQuantity * 0.30;
    final breastWeight = totalQuantity * 0.25;
    final wingWeight = totalQuantity * 0.10;
    final carcassWeight = totalQuantity * 0.25;
    final wasteWeight = totalQuantity * 0.10;

    // 2. Allocate Costs (Weighted Cost Allocation)
    // Premium cuts absorb more cost. Bones/waste absorb less/zero.
    // Total Cost Factors:
    // Legs: 1.0
    // Breast: 1.2
    // Wings: 0.8
    // Carcass: 0.2
    // Waste: 0.0

    // Calculate "Cost Units"
    final double legFactor = 1.0;
    final double breastFactor = 1.2;
    final double wingFactor = 0.9;
    final double carcassFactor = 0.2;

    final totalFactors =
        (legWeight * legFactor) +
        (breastWeight * breastFactor) +
        (wingWeight * wingFactor) +
        (carcassWeight * carcassFactor);

    // Cost per factor unit
    final costPerFactor = totalCost / totalFactors;

    return [
      // Leg Quarters / Pieces
      InventoryItem(
        id: '${input.id}_legs',
        name: 'Chicken Legs',
        quantity: legWeight,
        unit: input.unit,
        category: 'meat_cuts',
        cost: legWeight * legFactor * costPerFactor,
      ),

      // Breast Meat
      InventoryItem(
        id: '${input.id}_breast',
        name: 'Chicken Breast',
        quantity: breastWeight,
        unit: input.unit,
        category: 'meat_cuts',
        cost: breastWeight * breastFactor * costPerFactor,
      ),

      // Wings
      InventoryItem(
        id: '${input.id}_wings',
        name: 'Chicken Wings',
        quantity: wingWeight,
        unit: input.unit,
        category: 'meat_cuts',
        cost: wingWeight * wingFactor * costPerFactor,
      ),

      // Carcass / Bones (Stock)
      InventoryItem(
        id: '${input.id}_bones',
        name: 'Chicken Bones/Carcass',
        quantity: carcassWeight,
        unit: input.unit,
        category: 'by_products',
        cost: carcassWeight * carcassFactor * costPerFactor,
      ),

      // Waste
      InventoryItem(
        id: '${input.id}_waste',
        name: 'Skin, Fat & Trim',
        quantity: wasteWeight,
        unit: input.unit,
        category: 'waste',
        cost: 0,
        isWaste: true,
      ),
    ];
  }
}
