import 'package:injectable/injectable.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_strategy.dart';
import 'base_transformation_strategy.dart';
import 'transformation_configuration.dart';

@Named('butcher_beef')
@Injectable(as: ITransformationStrategy)
class BeefButcheryStrategy extends BaseTransformationStrategy {
  @override
  final ITransformationConfiguration config;

  BeefButcheryStrategy(@Named('beef_butchery') this.config);
}
