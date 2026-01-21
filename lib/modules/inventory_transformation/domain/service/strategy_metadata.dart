import 'package:flutter/material.dart';

class StrategyMetadata {
  final String key;
  final String label;
  final Color color;
  final IconData? icon;

  const StrategyMetadata({
    required this.key,
    required this.label,
    required this.color,
    this.icon,
  });
}
