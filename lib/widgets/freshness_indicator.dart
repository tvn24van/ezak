import 'dart:async';
import 'package:ezak/providers/freshness_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FreshnessIndicator extends ConsumerStatefulWidget {
  const FreshnessIndicator({super.key});

  @override
  ConsumerState<FreshnessIndicator> createState() => _FreshnessIndicatorState();
}

class _FreshnessIndicatorState extends ConsumerState<FreshnessIndicator> {
  static final _size = 20.0;

  bool _timerActive = false;
  Timer? _hideTimer;

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _startTimeout() {
    _hideTimer?.cancel();
    setState(() => _timerActive = true);

    _hideTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _timerActive = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final freshnessAsync = ref.watch(FreshnessProvider.instance);

    ref.listen(FreshnessProvider.instance, (previous, next) {
        if (next.state == FreshnessState.fresh || next.state == FreshnessState.unknown) {
          _startTimeout();
        }
    });

    final isBusy = freshnessAsync.state == FreshnessState.checking || freshnessAsync.state == FreshnessState.fetching;

    if (!isBusy && !_timerActive) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isBusy)
          SizedBox(
            width: _size,
            height: _size,
            child: CircularProgressIndicator(strokeWidth: 2, color: IconTheme.of(context).color),
          ),
        if (freshnessAsync.state == FreshnessState.fresh && _timerActive)
          const Icon(Icons.check_circle_outline),
        if (freshnessAsync.state == FreshnessState.unknown && _timerActive)
          const Icon(Icons.cloud_off),
      ],
    );

  }
}