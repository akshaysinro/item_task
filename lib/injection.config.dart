// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'modules/inventory_transformation/domain/service/beef_butchery_strategy.dart'
    as _i232;
import 'modules/inventory_transformation/domain/service/butcher_strategy.dart'
    as _i1032;
import 'modules/inventory_transformation/domain/service/butchery_configuration.dart'
    as _i539;
import 'modules/inventory_transformation/domain/service/chicken_butchery_strategy.dart'
    as _i1061;
import 'modules/inventory_transformation/domain/service/juice_strategy.dart'
    as _i520;
import 'modules/inventory_transformation/domain/service/transformation_configuration.dart'
    as _i788;
import 'modules/inventory_transformation/domain/service/transformation_strategy.dart'
    as _i228;
import 'modules/inventory_transformation/domain/service/vegetable_cutting_strategy.dart'
    as _i108;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i788.ITransformationConfiguration>(
      () => _i788.VegetableConfiguration(),
      instanceName: 'vegetable_cutting',
    );
    gh.factory<_i788.ITransformationConfiguration>(
      () => _i788.JuiceConfiguration(),
      instanceName: 'juice_extraction',
    );
    gh.factory<_i788.ITransformationConfiguration>(
      () => _i788.BeefButcheryConfiguration(),
      instanceName: 'beef_butchery',
    );
    gh.factory<_i539.IButcheryConfiguration>(
      () => _i539.WholeChickenConfiguration(),
      instanceName: 'whole_chicken',
    );
    gh.factory<_i228.ITransformationStrategy>(
      () => _i520.JuiceStrategy(
        gh<_i788.ITransformationConfiguration>(
          instanceName: 'juice_extraction',
        ),
      ),
      instanceName: 'juice',
    );
    gh.factory<_i228.ITransformationStrategy>(
      () => _i108.VegetableCuttingStrategy(
        gh<_i788.ITransformationConfiguration>(
          instanceName: 'vegetable_cutting',
        ),
      ),
      instanceName: 'veg_cut',
    );
    gh.factory<_i788.ITransformationConfiguration>(
      () => _i788.WholeChickenConfiguration(),
      instanceName: 'whole_chicken',
    );
    gh.factory<_i228.ITransformationStrategy>(
      () => _i1032.ButcheryStrategy(
        gh<_i788.ITransformationConfiguration>(instanceName: 'whole_chicken'),
      ),
      instanceName: 'butcher',
    );
    gh.factory<_i228.ITransformationStrategy>(
      () => _i1061.ChickenButcheryStrategy(
        gh<_i788.ITransformationConfiguration>(instanceName: 'whole_chicken'),
      ),
      instanceName: 'butcher_chicken',
    );
    gh.factory<_i228.ITransformationStrategy>(
      () => _i232.BeefButcheryStrategy(
        gh<_i788.ITransformationConfiguration>(instanceName: 'beef_butchery'),
      ),
      instanceName: 'butcher_beef',
    );
    return this;
  }
}
