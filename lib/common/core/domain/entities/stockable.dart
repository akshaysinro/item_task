import 'identifiable.dart';
import 'named.dart';
import 'quantifiable.dart';
import 'valued.dart';
import 'categorizable.dart';
import 'wasteable.dart';
import 'traceable.dart';

abstract class Stockable
    implements
        Identifiable,
        Named,
        Quantifiable,
        Valued,
        Categorizable,
        Wasteable,
        ITraceable {
  /// Creates a copy of this item with reduced quantity and proportionally adjusted cost.
  Stockable createReduced({required double quantity, required double cost});

  /// Creates a copy of this item with a new transformation ID.
  Stockable withSourceTransformationId(String id);
}
