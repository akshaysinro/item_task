import 'package:item_task/common/core/domain/entities/stockable.dart';
import '../../domain/entities/inventory_item.dart';
import '../../domain/repositories/i_transformation_repository.dart';

class FakeTransformationRepository implements ITransformationRepository {
  final List<InventoryItem> _dummyItems = [
    InventoryItem(
      id: '1',
      name: 'Whole Chicken',
      quantity: 10.0,
      cost: 50.0,
      unit: 'kg',
      category: 'meat',
    ),
    InventoryItem(
      id: '2',
      name: 'Raw Beef Slab',
      quantity: 15.0,
      cost: 120.0,
      unit: 'kg',
      category: 'meat',
    ),

    InventoryItem(
      id: '4',
      name: 'Red Onions',
      quantity: 50.0,
      cost: 20.0,
      unit: 'kg',
      category: 'veg',
    ),
    InventoryItem(
      id: '5',
      name: 'Fresh Carrots',
      quantity: 30.0,
      cost: 15.0,
      unit: 'kg',
      category: 'veg',
    ),
    InventoryItem(
      id: '6',
      name: 'Fresh Oranges',
      quantity: 20.0,
      cost: 40.0,
      unit: 'kg',
      category: 'fruit',
    ),
  ];

  @override
  Future<List<Stockable>> getStockItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _dummyItems;
  }

  @override
  Future<void> saveTransformationResult(List<Stockable> results) async {
    print(
      'Saving transformation results: ${results.length} items transformed.',
    );
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
