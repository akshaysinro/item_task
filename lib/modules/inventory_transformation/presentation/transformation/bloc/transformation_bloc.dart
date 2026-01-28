import 'package:flutter_bloc/flutter_bloc.dart';
import '../transformation_interactor.dart';
import '../../../domain/service/i_strategy_filter_service.dart';
import '../../../domain/service/transformation_strategy.dart';
import 'transformation_event.dart';
import 'transformation_state.dart';

/// BLoC for managing transformation state
class TransformationBloc
    extends Bloc<TransformationEvent, TransformationState> {
  final ITransformationInteractor interactor;
  final IStrategyFilterService strategyFilterService;

  TransformationBloc({
    required this.interactor,
    required this.strategyFilterService,
  }) : super(const TransformationInitial()) {
    on<LoadItemsEvent>(_onLoadItems);
    on<TransformItemEvent>(_onTransformItem);
  }

  ITransformationStrategy? getStrategy(String key) {
    return strategyFilterService.strategies[key];
  }

  Future<void> _onLoadItems(
    LoadItemsEvent event,
    Emitter<TransformationState> emit,
  ) async {
    emit(const TransformationLoading());
    try {
      final items = await interactor.fetchAvailableItems();

      // Get strategies with metadata for each item
      final itemStrategies = strategyFilterService
          .getItemStrategiesWithMetadata(items);

      emit(TransformationLoaded(items: items, itemStrategies: itemStrategies));
    } catch (e) {
      emit(
        TransformationError(message: 'Failed to load items: ${e.toString()}'),
      );
    }
  }

  Future<void> _onTransformItem(
    TransformItemEvent event,
    Emitter<TransformationState> emit,
  ) async {
    emit(const TransformationLoading());
    try {
      final strategy = strategyFilterService.strategies[event.strategyKey];
      if (strategy == null) {
        emit(const TransformationError(message: 'Strategy not found'));
        add(const LoadItemsEvent());
        return;
      }

      final result = await interactor.transformItem(
        event.item,
        strategy,
        event.quantity,
      );

      emit(TransformationSuccess(result: result));

      // Automatically reload items after successful transformation
      add(const LoadItemsEvent());
    } catch (e) {
      emit(
        TransformationError(message: 'Transformation failed: ${e.toString()}'),
      );

      // Reload items even after error to show current state
      add(const LoadItemsEvent());
    }
  }
}
