import 'package:equatable/equatable.dart';
import 'package:item_task/common/core/domain/entities/stockable.dart';

abstract class TransformationEvent extends Equatable {
  const TransformationEvent();

  @override
  List<Object?> get props => [];
}

class LoadItemsEvent extends TransformationEvent {
  const LoadItemsEvent();
}

class TransformItemEvent extends TransformationEvent {
  final Stockable item;
  final String strategyKey;
  final double quantity;

  const TransformItemEvent({
    required this.item,
    required this.strategyKey,
    required this.quantity,
  });

  @override
  List<Object?> get props => [item, strategyKey, quantity];
}
