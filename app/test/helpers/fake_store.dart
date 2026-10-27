import 'dart:async';

import 'package:atrament/core/utils/constants.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

/// A store that does what the test tells it to.
class FakeStore implements InAppPurchase {
  final StreamController<List<PurchaseDetails>> purchases =
      StreamController<List<PurchaseDetails>>.broadcast();
  bool available = true;
  Completer<bool>? availabilityGate;
  int restoreCalls = 0;
  bool restoreThrows = false;
  bool completeThrows = false;
  final List<PurchaseDetails> completed = [];

  /// Runs when the app asks to restore (lets a test push purchases back).
  void Function()? onRestore;

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => purchases.stream;

  @override
  Future<bool> isAvailable() async {
    final gate = availabilityGate;
    if (gate != null) return gate.future;
    return available;
  }

  @override
  Future<ProductDetailsResponse> queryProductDetails(
    Set<String> identifiers,
  ) async => ProductDetailsResponse(
    productDetails: const [],
    notFoundIDs: identifiers.toList(),
  );

  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    restoreCalls++;
    if (restoreThrows) throw StateError('store unreachable');
    onRestore?.call();
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) async {
    if (completeThrows) throw StateError('could not acknowledge');
    completed.add(purchase);
  }

  void dispose() => purchases.close();

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      super.noSuchMethod(invocation);
}

PurchaseDetails purchaseDetails(
  PurchaseStatus status, {
  String productId = AppConstants.iapAdFreeProductId,
  bool pendingComplete = false,
}) {
  final details = PurchaseDetails(
    purchaseID: 'p1',
    productID: productId,
    verificationData: PurchaseVerificationData(
      localVerificationData: '',
      serverVerificationData: '',
      source: 'test',
    ),
    transactionDate: '0',
    status: status,
  );
  details.pendingCompletePurchase = pendingComplete;
  return details;
}
