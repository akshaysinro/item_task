import '../../../../common/core/domain/entities/stockable.dart';
import 'strategy_metadata.dart';
import 'transformation_configuration.dart';

abstract class ITransformationStrategy {
  StrategyMetadata get metadata;
  List<Stockable> execute(Stockable input);
  bool canExecute(Stockable input);

  /// Calculates the required input quantity to achieve a target quantity for a specific yield.
  double calculateRequiredInputQuantity(
    String yieldSuffix,
    double targetQuantity,
  );

  /// Returns the available yield configurations for this strategy.
  List<YieldConfig> get yields;
}
