import 'package:injectable/injectable.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'transformation_configuration.dart';
import 'transformation_strategy.dart';
import 'base_transformation_strategy.dart';

@Named('juice')
@Injectable(as: ITransformationStrategy)
class JuiceStrategy extends BaseTransformationStrategy {
  @override
  final ITransformationConfiguration config;

  JuiceStrategy(@Named('juice_extraction') this.config);

  @override
  String formatResultName(Stockable input, YieldConfig yield) {
    return '${input.name} ${yield.name}';
  }
}
