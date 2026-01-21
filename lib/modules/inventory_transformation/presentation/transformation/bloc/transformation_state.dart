import 'package:equatable/equatable.dart';
import '../../../domain/entities/inventory_item.dart';
import '../../../domain/service/strategy_metadata.dart';
import '../../../domain/entities/transformation_result.dart';

/// Base class for all transformation states
abstract class TransformationState extends Equatable {
  const TransformationState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class TransformationInitial extends TransformationState {
  const TransformationInitial();
}

/// Loading state
class TransformationLoading extends TransformationState {
  const TransformationLoading();
}

/// Items loaded successfully
class TransformationLoaded extends TransformationState {
  final List<InventoryItem> items;
  final Map<String, List<StrategyMetadata>> itemStrategies;

  const TransformationLoaded({
    required this.items,
    required this.itemStrategies,
  });

  @override
  List<Object?> get props => [items, itemStrategies];
}

/// Transformation completed successfully
class TransformationSuccess extends TransformationState {
  final TransformationResult result;

  const TransformationSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

/// Error state
class TransformationError extends TransformationState {
  final String message;

  const TransformationError({required this.message});

  @override
  List<Object?> get props => [message];
}
