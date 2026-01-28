import 'package:item_task/modules/inventory_transformation/domain/entities/inventory_item.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_strategy.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/strategy_metadata.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'package:item_task/common/core/domain/entities/categorizable.dart';
import 'package:injectable/injectable.dart';
import 'transformation_configuration.dart';

@Named('veg_cut')
@Injectable(as: ITransformationStrategy)
class VegetableCuttingStrategy implements ITransformationStrategy {
  final ITransformationConfiguration config;

  VegetableCuttingStrategy(@Named('vegetable_cutting') this.config);

  @override
  StrategyMetadata get metadata => StrategyMetadata(
    key: config.key,
    label: config.label,
    color: config.color,
    icon: config.icon,
  );

  @override
  bool canExecute(Categorizable input) =>
      input.category == config.inputCategory || input.category == 'veg';

  @override
  List<Stockable> execute(Stockable input) {
    final double totalQuantity = input.quantity;
    final double totalCost = input.cost;

    final totalFactors = config.yields.fold<double>(0, (sum, y) {
      return sum + (totalQuantity * y.weightFactor * y.costFactor);
    });

    final costPerFactor = totalFactors > 0 ? totalCost / totalFactors : 0.0;

    return config.yields.map((y) {
      final weight = totalQuantity * y.weightFactor;
      final cost = weight * y.costFactor * costPerFactor;

      return InventoryItem(
        id: '${input.id}_${y.suffix}',
        name: '${y.name} ${input.name}',
        quantity: weight,
        unit: y.unit ?? input.unit,
        category: y.category ?? 'uncategorized',
        cost: y.isWaste ? 0 : cost,
        isWaste: y.isWaste,
      );
    }).toList();
  }
}
