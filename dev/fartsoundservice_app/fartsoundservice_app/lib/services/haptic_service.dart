import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ 핵심: HapticFeedback 사용

class HapticService with ChangeNotifier {
  bool _isEnabled = true;

  bool get isEnabled => _isEnabled;

  void toggle() {
    _isEnabled = !_isEnabled;
    notifyListeners();
  }

  /// 사용자 선택(탭) 등에 가벼운 클릭감
  Future<void> selectionTick() async {
    if (!_isEnabled) return;
    await HapticFeedback.selectionClick();
  }

  /// 가벼운 임팩트
  Future<void> light() async {
    if (!_isEnabled) return;
    await HapticFeedback.lightImpact();
  }

  /// 중간 임팩트
  Future<void> medium() async {
    if (!_isEnabled) return;
    await HapticFeedback.mediumImpact();
  }

  /// 강한 임팩트
  Future<void> heavy() async {
    if (!_isEnabled) return;
    await HapticFeedback.heavyImpact();
  }

  /// 플랫폼 기본 진동(지원 되는 경우)
  Future<void> vibrate() async {
    if (!_isEnabled) return;
    await HapticFeedback.vibrate();
  }

  /// 랜덤 하프틱 – 기존 로직 유지
  Future<void> playRandomFartHaptic() async {
    if (!_isEnabled) return;

    // HapticFeedback의 Future<void> Function 레퍼런스 리스트
    final List<Future<void> Function()> feedbacks = [
      HapticFeedback.heavyImpact,
      HapticFeedback.mediumImpact,
      HapticFeedback.lightImpact,
      HapticFeedback.vibrate,
    ];

    final now = DateTime.now().millisecond;
    await feedbacks[now % feedbacks.length]();
  }
}
