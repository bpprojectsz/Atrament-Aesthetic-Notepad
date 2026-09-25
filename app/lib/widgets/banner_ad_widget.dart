import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/providers/subscription_provider.dart';
import '../core/services/iap_service.dart';
import '../platform/admob_service.dart';

/// Banner ad container for the home screen. Collapses to zero height if
/// the ad fails to load, the SDK failed to initialize, or the user has an
/// active ad-removal subscription (Section 14: the app never crashes or
/// blocks the UI because an ad SDK failed).
class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key, required this.subscriptionProvider});

  final SubscriptionProvider subscriptionProvider;

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _banner;
  bool _failed = false;
  bool _hasRequestedLoad = false;

  @override
  void initState() {
    super.initState();
    widget.subscriptionProvider.status.addListener(_onSubscriptionChanged);
    AdMobService.instance.availability.addListener(_onAvailabilityChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // MediaQuery isn't safe to read in initState — this is the correct
    // place for context-dependent one-time setup. Guarded so it only
    // fires once even though didChangeDependencies can run again later.
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      _maybeLoadBanner();
    }
  }

  void _onSubscriptionChanged() {
    if (!mounted) return;
    if (widget.subscriptionProvider.status.value == SubscriptionStatus.pro) {
      _disposeBanner();
    } else if (_banner == null && !_failed) {
      _maybeLoadBanner();
    }
    setState(() {});
  }

  /// Fires when the AdMob SDK finishes initializing. On cold start the
  /// home screen mounts before the SDK is ready, so the first load
  /// attempt is a no-op — this listener supplies the retry.
  void _onAvailabilityChanged() {
    if (!mounted) return;
    if (AdMobService.instance.isAvailable && _banner == null && !_failed) {
      _maybeLoadBanner();
    }
  }

  Future<void> _maybeLoadBanner() async {
    if (widget.subscriptionProvider.status.value == SubscriptionStatus.pro) {
      return;
    }
    if (_banner != null) return;
    if (!AdMobService.instance.isAvailable) {
      // SDK not ready yet — the availability listener retries when it
      // flips true. Do not mark as failed, this is normal on cold start.
      return;
    }

    // Reserve room for the horizontal padding applied by the scaffold so
    // the loaded banner does not clip against the padded edge.
    const int horizontalReserve = 16;
    final screenWidth = MediaQuery.sizeOf(context).width.truncate();
    final width = screenWidth > horizontalReserve
        ? screenWidth - horizontalReserve
        : screenWidth;

    final banner = await AdMobService.instance.loadBanner(
      adaptiveWidth: width,
      onFailed: () {
        if (mounted) setState(() => _failed = true);
      },
    );

    if (!mounted) {
      banner?.dispose();
      return;
    }

    setState(() {
      _banner = banner;
      _failed = banner == null;
    });
  }

  void _disposeBanner() {
    _banner?.dispose();
    _banner = null;
  }

  @override
  void dispose() {
    AdMobService.instance.availability.removeListener(_onAvailabilityChanged);
    widget.subscriptionProvider.status.removeListener(_onSubscriptionChanged);
    _disposeBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPro =
        widget.subscriptionProvider.status.value == SubscriptionStatus.pro;
    final banner = _banner;

    if (isPro || banner == null) {
      // Collapsed: zero height, no visual footprint, no crash.
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      height: banner.size.height.toDouble(),
      child: AdWidget(ad: banner),
    );
  }
}
