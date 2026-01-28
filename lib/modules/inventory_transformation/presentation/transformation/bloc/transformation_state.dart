import 'package:equatable/equatable.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';
import '../../../domain/service/strategy_metadata.dart';
import '../../../domain/entities/transformation_result.dart';

abstract class TransformationState extends Equatable {
  const TransformationState();

  @override
  List<Object?> get props => [];
}

class TransformationInitial extends TransformationState {
  const TransformationInitial();
}

class TransformationLoading extends TransformationState {
  const TransformationLoading();
}

class TransformationLoaded extends TransformationState {
  final List<Stockable> items;
  final Map<String, List<StrategyMetadata>> itemStrategies;

  const TransformationLoaded({
    required this.items,
    required this.itemStrategies,
  });

  @override
  List<Object?> get props => [items, itemStrategies];
}

class TransformationSuccess extends TransformationState {
  final TransformationResult result;

  const TransformationSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class TransformationError extends TransformationState {
  final String message;

  const TransformationError({required this.message});

  @override
  List<Object?> get props => [message];
}
