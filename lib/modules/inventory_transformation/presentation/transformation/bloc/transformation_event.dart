import 'package:equatable/equatable.dart';
import 'package:item_task/modules/inventory_transformation/domain/entities/inventory_item.dart';

/// Base class for all transformation events
abstract class TransformationEvent extends Equatable {
  const TransformationEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load inventory items
class LoadItemsEvent extends TransformationEvent {
  const LoadItemsEvent();
}

/// Event to transform an item with a specific quantity
class TransformItemEvent extends TransformationEvent {
  final InventoryItem item;
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
