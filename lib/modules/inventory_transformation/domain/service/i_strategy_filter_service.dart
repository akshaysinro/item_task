import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'transformation_strategy.dart';
import 'strategy_metadata.dart';

abstract class IStrategyFilterService {
  /// Returns a map of item IDs to lists of supported strategy keys
  Map<String, List<String>> getItemStrategies(List<Stockable> items);

  /// Returns a map of item IDs to lists of supported strategy metadata
  Map<String, List<StrategyMetadata>> getItemStrategiesWithMetadata(
    List<Stockable> items,
  );

  /// Returns a map of strategy keys to their strategy instances
  Map<String, ITransformationStrategy> get strategies;
}
