import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/inventory_item.dart';
import '../../domain/service/strategy_metadata.dart';
import 'bloc/transformation_bloc.dart';
import 'bloc/transformation_event.dart';
import 'bloc/transformation_state.dart';
import 'widgets/quantity_selection_dialog.dart';
import 'transformation_result_screen.dart';

class TransformationScreen extends StatelessWidget {
  const TransformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Inventory Transformation',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<TransformationBloc, TransformationState>(
        listener: (context, state) {
          if (state is TransformationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state is TransformationSuccess) {
            // Navigate to results screen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    TransformationResultScreen(result: state.result),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TransformationInitial) {
            // Trigger initial load
            context.read<TransformationBloc>().add(const LoadItemsEvent());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransformationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransformationLoaded) {
            return _buildList(context, state.items, state.itemStrategies);
          }

          // Default fallback
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<InventoryItem> items,
    Map<String, List<StrategyMetadata>> itemStrategies,
  ) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No items available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildItemCard(context, item, itemStrategies[item.id] ?? []);
      },
    );
  }

  Widget _buildItemCard(
    BuildContext context,
    InventoryItem item,
    List<StrategyMetadata> strategies,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        subtitle: Text(
          'Qty: ${item.quantity} ${item.unit} | Cost: \$${item.cost.toStringAsFixed(2)}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Wrap(
          spacing: 8,
          children: strategies.map((metadata) {
            return ElevatedButton.icon(
              onPressed: () => _onTransformTapped(context, item, metadata),
              icon: metadata.icon != null
                  ? Icon(metadata.icon, size: 16)
                  : const SizedBox.shrink(),
              label: Text(metadata.label),
              style: ElevatedButton.styleFrom(
                backgroundColor: metadata.color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _onTransformTapped(
    BuildContext context,
    InventoryItem item,
    StrategyMetadata metadata,
  ) async {
    // Show quantity selection dialog
    final quantity = await showDialog<double>(
      context: context,
      builder: (context) => QuantitySelectionDialog(
        itemName: item.name,
        availableQuantity: item.quantity,
        unit: item.unit,
      ),
    );

    if (quantity == null || !context.mounted) {
      return; // User cancelled
    }

    // Get strategy from BLoC
    final bloc = context.read<TransformationBloc>();
    final strategy = bloc.getStrategy(metadata.key);

    if (strategy == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Strategy not found'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      return;
    }

    // Emit transform event
    bloc.add(
      TransformItemEvent(item: item, strategy: strategy, quantity: quantity),
    );
  }
}
