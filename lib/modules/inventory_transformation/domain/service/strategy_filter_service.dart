import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'transformation_strategy.dart';
import 'strategy_metadata.dart';
import 'i_strategy_filter_service.dart';

class StrategyFilterService implements IStrategyFilterService {
  final Map<String, ITransformationStrategy> _strategies;

  StrategyFilterService(this._strategies);

  @override
  Map<String, ITransformationStrategy> get strategies => _strategies;

  @override
  Map<String, List<String>> getItemStrategies(List<Stockable> items) {
    final Map<String, List<String>> itemStrategies = {};

    for (final item in items) {
      final supported = _strategies.entries
          .where((entry) {
            return entry.value.canExecute(item);
          })
          .map((entry) => entry.key)
          .toList();

      itemStrategies[item.id] = supported;
    }

    return itemStrategies;
  }

  @override
  Map<String, List<StrategyMetadata>> getItemStrategiesWithMetadata(
    List<Stockable> items,
  ) {
    final itemStrategyKeys = getItemStrategies(items);
    final Map<String, List<StrategyMetadata>> itemStrategies = {};

    for (final entry in itemStrategyKeys.entries) {
      itemStrategies[entry.key] = entry.value
          .map((key) => _strategies[key]?.metadata)
          .whereType<StrategyMetadata>()
          .toList();
    }

    return itemStrategies;
  }
}
