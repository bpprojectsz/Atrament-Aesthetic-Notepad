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

  Future<void> _maybeLoadBanner() async {
    if (widget.subscriptionProvider.status.value == SubscriptionStatus.pro) {
      return;
    }

    final width = MediaQuery.sizeOf(context).width.truncate();
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
      width: banner.size.width.toDouble(),
      height: banner.size.height.toDouble(),
      child: AdWidget(ad: banner),
    );
  }
}
