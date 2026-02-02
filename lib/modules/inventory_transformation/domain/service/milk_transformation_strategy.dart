import 'package:injectable/injectable.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import 'transformation_configuration.dart';
import 'transformation_strategy.dart';
import 'base_transformation_strategy.dart';

@Named('milk')
@Injectable(as: ITransformationStrategy)
class MilkTransformationStrategy extends BaseTransformationStrategy {
  @override
  final ITransformationConfiguration config;

  MilkTransformationStrategy(@Named('milk_transformation') this.config);

  @override
  String formatResultName(Stockable input, YieldConfig yield) {
    return '${input.name} ${yield.name}';
  }
}
