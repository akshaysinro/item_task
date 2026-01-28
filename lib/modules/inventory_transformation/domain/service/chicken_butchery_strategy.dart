import 'package:injectable/injectable.dart';
import 'package:item_task/modules/inventory_transformation/domain/service/transformation_strategy.dart';
import 'base_butchery_strategy.dart';
import 'transformation_configuration.dart';

@Named('butcher_chicken')
@Injectable(as: ITransformationStrategy)
class ChickenButcheryStrategy extends BaseButcheryStrategy {
  @override
  final ITransformationConfiguration config;

  ChickenButcheryStrategy(@Named('whole_chicken') this.config);

  @override
  bool matchesSpecies(String itemName) =>
      itemName.contains('chicken') || itemName.contains('bird');
}
