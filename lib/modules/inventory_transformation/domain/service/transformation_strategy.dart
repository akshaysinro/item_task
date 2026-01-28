import '../../../../common/core/domain/entities/stockable.dart';
import 'strategy_metadata.dart';

abstract class ITransformationStrategy {
  StrategyMetadata get metadata;
  List<Stockable> execute(Stockable input);
  bool canExecute(Stockable input);
}
