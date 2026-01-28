import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class YieldConfig {
  final String suffix;
  final String name;
  final double weightFactor;
  final double costFactor;
  final String? category;
  final String? unit;
  final bool isWaste;

  const YieldConfig({
    required this.suffix,
    required this.name,
    required this.weightFactor,
    required this.costFactor,
    this.category,
    this.unit,
    this.isWaste = false,
  });
}

abstract class ITransformationConfiguration {
  String get key;
  String get label;
  Color get color;
  IconData get icon;
  String get inputCategory;
  List<YieldConfig> get yields;
}

@Named('whole_chicken')
@Injectable(as: ITransformationConfiguration)
class WholeChickenConfiguration implements ITransformationConfiguration {
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

@Named('beef_butchery')
@Injectable(as: ITransformationConfiguration)
class BeefButcheryConfiguration implements ITransformationConfiguration {
  @override
  String get key => 'butcher_beef';
  @override
  String get label => 'Break Down Beef Slab';
  @override
  Color get color => const Color(0xFF8B0000);
  @override
  IconData get icon => Icons.restaurant;
  @override
  String get inputCategory => 'meat';

  @override
  List<YieldConfig> get yields => const [
    YieldConfig(
      suffix: 'ribeye',
      name: 'Ribeye Steaks',
      weightFactor: 0.35,
      costFactor: 2.0,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'tenderloin',
      name: 'Beef Tenderloin',
      weightFactor: 0.15,
      costFactor: 3.0,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'sirloin',
      name: 'Sirloin Cuts',
      weightFactor: 0.25,
      costFactor: 1.5,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'ground',
      name: 'Ground Beef (Trim)',
      weightFactor: 0.15,
      costFactor: 0.8,
      category: 'meat_cuts',
    ),
    YieldConfig(
      suffix: 'waste',
      name: 'Fat & Bone (Waste)',
      weightFactor: 0.10,
      costFactor: 0.0,
      category: 'waste',
      isWaste: true,
    ),
  ];
}

@Named('juice_extraction')
@Injectable(as: ITransformationConfiguration)
class JuiceConfiguration implements ITransformationConfiguration {
  @override
  String get key => 'juice';
  @override
  String get label => 'Juice';
  @override
  Color get color => const Color(0xFFF59E0B);
  @override
  IconData get icon => Icons.local_drink;
  @override
  String get inputCategory => 'fruit';

  @override
  List<YieldConfig> get yields => const [
    YieldConfig(
      suffix: 'juice',
      name: 'Juice',
      weightFactor: 0.70,
      costFactor: 1.0,
      category: 'beverage',
      unit: 'liters',
    ),
    YieldConfig(
      suffix: 'pulp',
      name: 'Pulp (Waste)',
      weightFactor: 0.30,
      costFactor: 0.0,
      category: 'waste',
      isWaste: true,
    ),
  ];
}

@Named('vegetable_cutting')
@Injectable(as: ITransformationConfiguration)
class VegetableConfiguration implements ITransformationConfiguration {
  @override
  String get key => 'veg_cut';
  @override
  String get label => 'Cut';
  @override
  Color get color => const Color(0xFF10B981);
  @override
  IconData get icon => Icons.content_cut;
  @override
  String get inputCategory => 'vegetable';

  @override
  List<YieldConfig> get yields => const [
    YieldConfig(
      suffix: 'chopped',
      name: 'Chopped',
      weightFactor: 0.90,
      costFactor: 1.0,
      category: 'prepared_produce',
    ),
    YieldConfig(
      suffix: 'peels',
      name: 'Peels (Waste)',
      weightFactor: 0.10,
      costFactor: 0.0,
      category: 'waste',
      isWaste: true,
    ),
  ];
}
