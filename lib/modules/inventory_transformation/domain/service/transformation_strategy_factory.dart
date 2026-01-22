import 'transformation_strategy.dart';
import 'package:get_it/get_it.dart';

/// Factory for creating all available transformation strategies
/// Supports both built-in strategies and self-registering plugins
class TransformationStrategyFactory {
  /// Creates all available transformation strategies
  /// Includes both built-in strategies and registered plugins
  static Map<String, ITransformationStrategy> createAll() {
    final strategies = <String, ITransformationStrategy>{};

    // Use GetIt to find all registered strategies
    final registeredStrategies = GetIt.instance
        .getAll<ITransformationStrategy>();

    for (final strategy in registeredStrategies) {
      strategies[strategy.metadata.key] = strategy;
    }

    return strategies;
  }

  /// Alternative: Get strategies as a list
  static List<ITransformationStrategy> createList() {
    return createAll().values.toList();
  }
}
