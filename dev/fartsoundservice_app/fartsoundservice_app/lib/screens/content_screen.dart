import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';  // ✅ 통일

import '../services/haptic_service.dart';
import '../services/sound_service.dart';
import '../widgets/rainbow_border_view.dart';
import '../widgets/expanding_ring.dart';
import '../widgets/sound_selector_view.dart';


class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  double _hue = Random().nextDouble();
  String _selectedEmoji = "💨";
  String _buttonText = "";
  String _message = "";
  String _bottomMessage = "";
  double _buttonScale = 1.0;
  bool _showRainbowBorder = false;

  double _rippleBoost = 0.0;
  final List<Widget> _rings = [];
  Timer? _decayTimer;

  final double _boostIncrement = 0.09;
  final double _boostMax = 0.95;
  final double _decayPerTick = 0.975;
  final double _ringDuration = 0.7;

  final List<String> _emojis = const ["💨", "💩", "😆", "🙊", "🤣", "🎺", "😵‍💫", "😈", "😜", "😹"];

  List<String> _getButtonTexts(AppLocalizations l10n) => [
    l10n.button_text_1,
    l10n.button_text_2,
    l10n.button_text_3,
    l10n.button_text_4,
    l10n.button_text_5,
    l10n.button_text_6,
    l10n.button_text_7,
    l10n.button_text_8,
    l10n.button_text_9,
    l10n.button_text_10,
  ];

  List<String> _getBottomMessages(AppLocalizations l10n) => [
    l10n.bottom_msg_1,
    l10n.bottom_msg_2,
    l10n.bottom_msg_3,
    l10n.bottom_msg_4,
    l10n.bottom_msg_5,
    l10n.bottom_msg_6,
    l10n.bottom_msg_7,
    l10n.bottom_msg_8,
    l10n.bottom_msg_9,
    l10n.bottom_msg_10,
  ];

  @override
  void initState() {
    super.initState();
    _startDecayTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context); // ✅ null-safe
    if (_buttonText.isEmpty) {
      if (l10n != null) {
        _buttonText = l10n.button_text_1;
        _message = l10n.initial_message;
        _bottomMessage = l10n.initial_bottom_message;
      } else {
        // ✅ 폴백(로딩 타이밍 보호)
        _buttonText = 'Press';
        _message = 'Welcome';
        _bottomMessage = 'Ready!';
      }
    }
  }

  void _startDecayTimer() {
    _decayTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_rippleBoost > 0.0001) {
        if (mounted) {
          setState(() {
            _rippleBoost *= _decayPerTick;
            if (_rippleBoost < 0.001) _rippleBoost = 0;
          });
        }
      }
    });
  }

  void _handleTap() {
    final soundService = Provider.of<SoundService>(context, listen: false);
    final hapticService = Provider.of<HapticService>(context, listen: false);
    final l10n = AppLocalizations.of(context)!; // 여기서는 이미 build 후이므로 보통 OK

    final bonus = max(0, 0.12 - _rippleBoost * 0.10);
    _rippleBoost = min(_boostMax, _rippleBoost + _boostIncrement + bonus);

    final ringId = UniqueKey();
    setState(() {
      _rings.add(ExpandingRing(key: ringId, duration: _ringDuration));
    });
    Future.delayed(Duration(milliseconds: (_ringDuration * 1000).toInt()), () {
      if (mounted) {
        setState(() {
          _rings.removeWhere((w) => w.key == ringId);
        });
      }
    });

    soundService.playRandomFart();
    hapticService.playRandomFartHaptic();

    setState(() {
      _showRainbowBorder = true;
      _buttonScale = 1.12;
      _hue = Random().nextDouble();
      _selectedEmoji = _emojis.randomElement;
      _buttonText = _getButtonTexts(l10n).randomElement;
      _message = _getButtonTexts(l10n).randomElement;
      _bottomMessage = _getBottomMessages(l10n).randomElement;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _showRainbowBorder = false);
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _buttonScale = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hapticService = Provider.of<HapticService>(context);
    final l10n = AppLocalizations.of(context) ?? AppLocalizations.of(context)!; // l10n은 이미 준비되었을 것

    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 450),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HSVColor.fromAHSV(1.0, _hue * 360, 0.85, 0.9).toColor(),
                  HSVColor.fromAHSV(1.0, ((_hue * 360) + 36) % 360, 0.6, 0.95).toColor(),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          RainbowBorderView(isAnimating: _showRainbowBorder),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    children: [
                      const Spacer(),
                      const SoundSelectorView(),
                      const SizedBox(width: 12),
                      _buildHapticButton(hapticService),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                Text(
                  l10n.app_title,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))],
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 255, 255, 0.9)),
                ),
                const SizedBox(height: 50),

                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ..._rings,
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          width: 270 * ((1 + _rippleBoost * 0.6)),
                          height: 270 * ((1 + _rippleBoost * 0.6)),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withAlpha((255 * 0.18).round()),
                          ),
                        ),
                        GestureDetector(
                          onTap: _handleTap,
                          child: AnimatedScale(
                            scale: _buttonScale + _rippleBoost * 0.18,
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.elasticOut,
                            child: Container(
                              width: 230,
                              height: 230,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withAlpha((255 * 0.92).round()),
                                border: Border.all(color: Colors.white.withAlpha((255 * 0.6).round()), width: 6),
                                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 10))],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_selectedEmoji, style: const TextStyle(fontSize: 85)),
                                  const SizedBox(height: 6),
                                  Text(
                                    _buttonText,
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color.fromRGBO(0, 0, 0, 0.7)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Text(
                  _bottomMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color.fromRGBO(255, 255, 255, 0.85)),
                ),
                const SizedBox(height: 50),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHapticButton(HapticService hapticService) {
    return GestureDetector(
      onTap: () {
        hapticService.toggle();
        HapticFeedback.lightImpact(); // ✅ 교체
      },
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((255 * 0.18).round()),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withAlpha((255 * 0.4).round())),
        ),
        child: Icon(
          hapticService.isEnabled ? Icons.vibration : Icons.smartphone,
          color: Colors.white,
          size: 24,
          shadows: const [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _decayTimer?.cancel();
    super.dispose();
  }
}

extension RandomElement<T> on List<T> {
  T get randomElement => this[Random().nextInt(length)];
}
