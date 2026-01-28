import 'identifiable.dart';
import 'named.dart';
import 'quantifiable.dart';
import 'valued.dart';
import 'categorizable.dart';
import 'wasteable.dart';

abstract class Stockable
    implements
        Identifiable,
        Named,
        Quantifiable,
        Valued,
        Categorizable,
        Wasteable {
  // All properties are inherited from the composed interfaces
}
