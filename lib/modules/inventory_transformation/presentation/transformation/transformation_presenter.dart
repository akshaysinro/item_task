// import '../../domain/entities/inventory_item.dart';
// import '../../domain/service/i_strategy_filter_service.dart';
// import '../../domain/service/strategy_metadata.dart';
// import '../../domain/entities/transformation_result.dart';
// import 'transformation_interactor.dart';
// import 'i_transformation_router.dart';

// abstract class ITransformationView {
//   void showLoading();
//   void hideLoading();
//   void displayItems(
//     List<InventoryItem> items,
//     Map<String, List<StrategyMetadata>> itemStrategies,
//   );
//   void showError(String message);
//   void showSuccess(String message);

//   // New methods for quantity selection and navigation
//   Future<double?> showQuantitySelection(
//     String itemName,
//     double availableQuantity,
//     String unit,
//   );
//   void navigateToResults(TransformationResult result);
// }

// class TransformationPresenter {
//   final ITransformationInteractor interactor;
//   final IStrategyFilterService strategyFilterService;
//   final ITransformationRouter router;
//   ITransformationView? view;

//   TransformationPresenter({
//     required this.interactor,
//     required this.strategyFilterService,
//     required this.router,
//   });

//   Future<void> viewDidLoad() async {
//     await _loadItems();
//   }

//   Future<void> _loadItems() async {
//     view?.showLoading();
//     try {
//       final items = await interactor.fetchAvailableItems();

//       // Delegate to service - no mapping logic in Presenter
//       final itemStrategies = strategyFilterService
//           .getItemStrategiesWithMetadata(items);

//       view?.displayItems(items, itemStrategies);
//     } catch (e) {
//       view?.showError('Failed to load items');
//     } finally {
//       view?.hideLoading();
//     }
//   }

//   Future<void> onTransformSelected(
//     InventoryItem item,
//     String strategyKey,
//   ) async {
//     final strategy = strategyFilterService.strategies[strategyKey];

//     if (strategy == null) {
//       view?.showError('Strategy not found');
//       return;
//     }

//     // Show quantity selection dialog
//     final quantity = await view?.showQuantitySelection(
//       item.name,
//       item.quantity,
//       item.unit,
//     );

//     if (quantity == null) {
//       // User cancelled
//       return;
//     }

//     view?.showLoading();
//     try {
//       final result = await interactor.transformItem(item, strategy, quantity);
//       view?.hideLoading();

//       // Navigate to results screen
//       view?.navigateToResults(result);

//       // Refresh list after returning from results
//       await _loadItems();
//     } catch (e) {
//       view?.hideLoading();
//       view?.showError('Transformation failed: ${e.toString()}');
//     }
//   }
// }
