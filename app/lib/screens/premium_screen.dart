import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_purchase/in_app_purchase.dart' show ProductDetails;

import '../core/providers/subscription_provider.dart';
import '../core/services/iap_service.dart';
import '../core/utils/constants.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/loading_indicator.dart';

/// Paywall for the ad-removal subscription. Never a blocking modal —
/// always reached from an optional "Remove Ads" row in Settings
/// (Section 19). No feature-gating language anywhere on this screen,
/// since every feature is already available for free.
class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key, required this.subscriptionProvider});

  final SubscriptionProvider subscriptionProvider;

  /// Returns the store's actual localized price for [productId] if the
  /// product catalog has loaded, falling back to a static approximate
  /// price (e.g. while offline) only when the live price isn't available
  /// yet. The live price is always correct for the user's currency and
  /// exactly matches what they'll be charged; the fallback exists purely
  /// so the screen isn't blank before `IapService.initialize()` finishes.
  String _priceFor(String productId, {required String fallback}) {
    final products = subscriptionProvider.availableProducts;
    final match = products.where((p) => p.id == productId);
    if (match.isEmpty) return fallback;
    final ProductDetails product = match.first;
    return product.price;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;

    return AppScaffold(
      title: l10n.premiumScreenTitle,
      body: ListenableBuilder(
        listenable: Listenable.merge([
          subscriptionProvider.status,
          subscriptionProvider.isProcessingPurchase,
          subscriptionProvider.lastErrorMessage,
        ]),
        builder: (context, _) {
          final isPro =
              subscriptionProvider.status.value == SubscriptionStatus.pro;
          final isProcessing = subscriptionProvider.isProcessingPurchase.value;
          final error = subscriptionProvider.lastErrorMessage.value;

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.spa_outlined,
                  size: 48,
                  color: AppColors.accent.resolve(mode),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.premiumHeadline,
                  style: TextStyle(
                    fontSize: AppTypography.headline.size,
                    fontWeight: AppTypography.headline.weight,
                    color: AppColors.textPrimary.resolve(mode),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.premiumBody,
                  style: TextStyle(
                    fontSize: AppTypography.body.size,
                    height: AppTypography.body.height,
                    color: AppColors.textSecondary.resolve(mode),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                if (isPro)
                  Text(
                    l10n.premiumAlreadyProMessage,
                    style: TextStyle(
                      fontSize: AppTypography.body.size,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success.resolve(mode),
                    ),
                  )
                else ...[
                  _PlanOption(
                    label: l10n.premiumMonthlyLabel,
                    price: _priceFor(
                      AppConstants.iapMonthlyProductId,
                      fallback: l10n.premiumMonthlyPrice,
                    ),
                    onTap: isProcessing
                        ? null
                        : subscriptionProvider.purchaseMonthly,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _PlanOption(
                    label: l10n.premiumYearlyLabel,
                    price: _priceFor(
                      AppConstants.iapYearlyProductId,
                      fallback: l10n.premiumYearlyPrice,
                    ),
                    highlighted: true,
                    onTap: isProcessing
                        ? null
                        : subscriptionProvider.purchaseYearly,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (isProcessing)
                    const Center(child: LoadingIndicator())
                  else if (error != null)
                    Text(
                      error,
                      style: TextStyle(
                        color: AppColors.error.resolve(mode),
                        fontSize: AppTypography.footnote.size,
                      ),
                    ),
                  const SizedBox(height: AppSpacing.md),
                  Center(
                    child: TextButton(
                      onPressed: isProcessing
                          ? null
                          : subscriptionProvider.restore,
                      child: Text(l10n.premiumRestoreButton),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PlanOption extends StatelessWidget {
  const _PlanOption({
    required this.label,
    required this.price,
    required this.onTap,
    this.highlighted = false,
  });

  final String label;
  final String price;
  final VoidCallback? onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final accent = AppColors.accent.resolve(mode);
    final borderColor = highlighted ? accent : AppColors.borderSubtle.resolve(mode);

    return Semantics(
      button: true,
      label: '$label, $price',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: Border.all(
              color: borderColor,
              width: highlighted ? 2 : AppElevation.cardBorderWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: AppTypography.body.size,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary.resolve(mode),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: AppTypography.body.size,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
