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

import 'modules/inventory_transformation/domain/service/butcher_strategy.dart'
    as _i1032;
import 'modules/inventory_transformation/domain/service/juice_strategy.dart'
    as _i520;
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
    gh.factory<_i228.ITransformationStrategy>(
      () => _i520.JuiceStrategy(),
      instanceName: 'juice',
    );
    gh.factory<_i228.ITransformationStrategy>(
      () => _i108.VegetableCuttingStrategy(),
      instanceName: 'veg_cut',
    );
    gh.factory<_i228.ITransformationStrategy>(
      () => _i1032.ButcheryStrategy(),
      instanceName: 'butcher',
    );
    return this;
  }
}
