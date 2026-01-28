import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class YieldConfig {
  final String suffix;
  final String name;
  final double weightFactor;
  final double costFactor;
  final String? category;
  final bool isWaste;

  const YieldConfig({
    required this.suffix,
    required this.name,
    required this.weightFactor,
    required this.costFactor,
    this.category,
    this.isWaste = false,
  });
}

abstract class IButcheryConfiguration {
  String get key;
  String get label;
  Color get color;
  IconData get icon;
  String get inputCategory;
  List<YieldConfig> get yields;
}

@Named('whole_chicken')
@Injectable(as: IButcheryConfiguration)
class WholeChickenConfiguration implements IButcheryConfiguration {
  @override
  String get key => 'butcher_whole_chicken';

  @override
  String get label => 'Break Down Whole Chicken';

  @override
  Color get color => const Color(0xFFD2691E);

  @override
  IconData get icon => Icons.restaurant;

  @override
  String get inputCategory => 'meat';

  @override
  List<YieldConfig> get yields => const [
    YieldConfig(
      suffix: 'legs',
      name: 'Chicken Legs',
      weightFactor: 0.30,
      costFactor: 1.0,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'breast',
      name: 'Chicken Breast',
      weightFactor: 0.25,
      costFactor: 1.2,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'wings',
      name: 'Chicken Wings',
      weightFactor: 0.10,
      costFactor: 0.9,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'bones',
      name: 'Chicken Bones/Carcass',
      weightFactor: 0.25,
      costFactor: 0.2,
      category: 'by_products',
    ),
    YieldConfig(
      suffix: 'waste',
      name: 'Skin, Fat & Trim',
      weightFactor: 0.10,
      costFactor: 0.0,
      category: 'waste',
      isWaste: true,
    ),
  ];
}
