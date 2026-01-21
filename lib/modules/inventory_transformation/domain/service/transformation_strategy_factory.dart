import 'transformation_strategy.dart';
import 'butcher_strategy.dart';
import 'vegetable_cutting_strategy.dart';
import 'juice_strategy.dart';
import 'strategy_plugin_registry.dart';

/// Factory for creating all available transformation strategies
/// Supports both built-in strategies and self-registering plugins
class TransformationStrategyFactory {
  /// Creates all available transformation strategies
  /// Includes both built-in strategies and registered plugins
  static Map<String, ITransformationStrategy> createAll() {
    final strategies = <String, ITransformationStrategy>{};

    // Helper to register strategies by their metadata key
    void add(ITransformationStrategy strategy) {
      strategies[strategy.metadata.key] = strategy;
    }

    // Built-in strategies
    add(ButcheryStrategy());
    add(VegetableCuttingStrategy());
    add(JuiceStrategy());

    // Add all self-registered plugin strategies
    for (final plugin in StrategyPluginRegistry.getAllPlugins()) {
      add(plugin);
    }

    // Lock registry to prevent late registrations
    StrategyPluginRegistry.lock();

    return strategies;
  }

  /// Alternative: Get strategies as a list
  static List<ITransformationStrategy> createList() {
    return createAll().values.toList();
  }
}
