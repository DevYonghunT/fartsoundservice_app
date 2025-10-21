import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart'; // ✅ 올바른 경로
import '../services/haptic_service.dart';
import '../services/sound_service.dart';

class SoundSelectorView extends StatefulWidget {
  const SoundSelectorView({super.key});

  @override
  State<SoundSelectorView> createState() => _SoundSelectorViewState();
}

class _SoundSelectorViewState extends State<SoundSelectorView> {
  late PageController _controller;
  int _selectedIndex = 0;

  final int _baseCount = 11; // auto + 10 sounds
  final int _loopMultiplier = 100;
  late int _middleStartIndex;

  @override
  void initState() {
    super.initState();
    _middleStartIndex = (_baseCount * _loopMultiplier / 2).floor();
    _selectedIndex = _middleStartIndex;
    _controller = PageController(
      initialPage: _middleStartIndex,
      viewportFraction: 0.5, // To center one item
    );
  }

  void _onPageChanged(int absoluteIndex) {
    final soundService = context.read<SoundService>();
    final hapticService = context.read<HapticService>();
    final baseIndex = absoluteIndex % _baseCount;

    setState(() {
      _selectedIndex = absoluteIndex;
    });

    if (baseIndex == 0) {
      soundService.selectionMode = SoundSelectionMode.auto;
    } else {
      soundService.manualIndex = baseIndex - 1;
    }
    hapticService.selectionTick();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 48,
      child: PageView.builder(
        controller: _controller,
        itemCount: _baseCount * _loopMultiplier,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, absoluteIndex) {
          final isSelected = (_selectedIndex == absoluteIndex);
          final baseIndex = absoluteIndex % _baseCount;
          final l10n = AppLocalizations.of(context)!;

          String text;
          if (baseIndex == 0) {
            text = l10n.sound_selector_auto;
          } else {
            text = "${l10n.sound_selector_fart}$baseIndex";
          }

          return AnimatedScale(
            scale: isSelected ? 1.15 : 0.92,
            duration: const Duration(milliseconds: 200),
            child: AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.7,
              duration: const Duration(milliseconds: 200),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withAlpha((255 * (isSelected ? 0.7 : 0.25)).round()),
                    width: isSelected ? 2 : 1,
                  ),
                  color: isSelected ? Colors.white.withAlpha((255 * 0.18).round()) : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: Colors.white.withAlpha((255 * (isSelected ? 1.0 : 0.8)).round()),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}