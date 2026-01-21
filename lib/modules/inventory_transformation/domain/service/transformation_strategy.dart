import '../../../../common/core/domain/entities/stockable.dart';
import '../../../../common/core/domain/entities/categorizable.dart';
import 'strategy_metadata.dart';

abstract class ITransformationStrategy {
  StrategyMetadata get metadata;
  List<Stockable> execute(Stockable input);
  bool canExecute(Categorizable input);
}
