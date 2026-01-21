import 'identifiable.dart';
import 'named.dart';
import 'quantifiable.dart';
import 'valued.dart';
import 'categorizable.dart';

abstract class Stockable
    implements Identifiable, Named, Quantifiable, Valued, Categorizable {
  // All properties are inherited from the composed interfaces
}
