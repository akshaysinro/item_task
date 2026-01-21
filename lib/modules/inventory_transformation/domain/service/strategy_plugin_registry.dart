import 'transformation_strategy.dart';

/// Plugin registry for self-registering transformation strategies
/// Strategies can register themselves without modifying the factory
class StrategyPluginRegistry {
  static final List<ITransformationStrategy> _plugins = [];
  static bool _locked = false;

  /// Register a strategy plugin
  /// Throws if registry is locked (after initialization)
  static void register(ITransformationStrategy strategy) {
    if (_locked) {
      throw StateError(
        'Cannot register strategy after initialization. '
        'Make sure to import strategy files before calling createModule().',
      );
    }
    _plugins.add(strategy);
  }

  /// Lock the registry to prevent further registrations
  static void lock() {
    _locked = true;
  }

  /// Get all registered plugins
  static List<ITransformationStrategy> getAllPlugins() =>
      List.unmodifiable(_plugins);

  /// Clear all plugins (for testing)
  static void clearForTesting() {
    _plugins.clear();
    _locked = false;
  }
}
