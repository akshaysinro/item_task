import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transformation_view.dart';
import 'transformation_interactor.dart';
import 'i_transformation_router.dart';
import '../../domain/repositories/i_transformation_repository.dart';
import '../../domain/usecases/transform_item_usecase.dart';
import '../../data/repositories/fake_transformation_repository.dart';
import '../../domain/service/transformation_strategy_factory.dart';
import '../../domain/service/strategy_filter_service.dart';
import 'bloc/transformation_bloc.dart';

// Import plugin strategies to trigger auto-registration
// ignore: unused_import
import '../../domain/service/juice_strategy.dart';

// Restaurant cut strategies
// ignore: unused_import

class TransformationRouter implements ITransformationRouter {
  static Widget createModule() {
    // 1. Setup Strategies using Factory (Open/Closed Principle)
    final strategies = TransformationStrategyFactory.createAll();

    // 2. Setup Domain Services
    final strategyFilterService = StrategyFilterService(strategies);

    // 3. Setup Data Layer
    final ITransformationRepository repository = FakeTransformationRepository();
    final transformUseCase = TransformItemUseCase(repository);

    // 4. Setup Presentation Layer with BLoC
    final interactor = TransformationInteractor(
      repository: repository,
      transformUseCase: transformUseCase,
    );

    // Create BLoC
    final bloc = TransformationBloc(
      interactor: interactor,
      strategyFilterService: strategyFilterService,
    );

    // Provide BLoC to View
    return BlocProvider(
      create: (context) => bloc,
      child: const TransformationScreen(),
    );
  }

  @override
  void navigateToDetails(BuildContext context, String itemId) {
    // Navigation logic would go here
  }
}
