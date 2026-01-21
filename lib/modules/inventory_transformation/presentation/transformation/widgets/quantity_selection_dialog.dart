import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dialog for selecting quantity to transform
class QuantitySelectionDialog extends StatefulWidget {
  final String itemName;
  final double availableQuantity;
  final String unit;

  const QuantitySelectionDialog({
    super.key,
    required this.itemName,
    required this.availableQuantity,
    required this.unit,
  });

  @override
  State<QuantitySelectionDialog> createState() =>
      _QuantitySelectionDialogState();
}

class _QuantitySelectionDialogState extends State<QuantitySelectionDialog> {
  final _controller = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => _errorText = 'Please enter a quantity');
      return;
    }

    final quantity = double.tryParse(text);
    if (quantity == null) {
      setState(() => _errorText = 'Please enter a valid number');
      return;
    }

    if (quantity <= 0) {
      setState(() => _errorText = 'Quantity must be greater than 0');
      return;
    }

    if (quantity > widget.availableQuantity) {
      setState(
        () => _errorText =
            'Cannot exceed available stock (${widget.availableQuantity} ${widget.unit})',
      );
      return;
    }

    Navigator.of(context).pop(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transform ${widget.itemName}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available: ${widget.availableQuantity} ${widget.unit}',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            decoration: InputDecoration(
              labelText: 'Quantity to transform',
              suffixText: widget.unit,
              errorText: _errorText,
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
            onSubmitted: (_) => _validateAndSubmit(),
            onChanged: (_) => setState(() => _errorText = null),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _QuickSelectButton(
                label: '25%',
                onTap: () {
                  _controller.text = (widget.availableQuantity * 0.25)
                      .toStringAsFixed(2);
                  setState(() => _errorText = null);
                },
              ),
              const SizedBox(width: 8),
              _QuickSelectButton(
                label: '50%',
                onTap: () {
                  _controller.text = (widget.availableQuantity * 0.5)
                      .toStringAsFixed(2);
                  setState(() => _errorText = null);
                },
              ),
              const SizedBox(width: 8),
              _QuickSelectButton(
                label: '100%',
                onTap: () {
                  _controller.text = widget.availableQuantity.toString();
                  setState(() => _errorText = null);
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _validateAndSubmit,
          child: const Text('Transform'),
        ),
      ],
    );
  }
}

class _QuickSelectButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickSelectButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
