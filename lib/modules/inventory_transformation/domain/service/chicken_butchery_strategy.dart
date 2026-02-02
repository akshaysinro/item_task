import 'package:injectable/injectable.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_strategy.dart';
import 'base_transformation_strategy.dart';
import 'transformation_configuration.dart';

@Named('butcher_chicken')
@Injectable(as: ITransformationStrategy)
class ChickenButcheryStrategy extends BaseTransformationStrategy {
  @override
  final ITransformationConfiguration config;

  ChickenButcheryStrategy(@Named('whole_chicken') this.config);
}
