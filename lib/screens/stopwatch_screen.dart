import 'package:flutter/material.dart';
import 'dart:async';
import '../models/lap.dart';
import '../utils/time_formatter.dart';
import '../widgets/timer_display.dart';
import '../widgets/control_buttons.dart';
import '../widgets/lap_list.dart';

class StopwatchScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const StopwatchScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;
  List<Lap> _laps = [];
  int _lastLapTime = 0;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliseconds += 10;
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
      _laps.clear();
      _lastLapTime = 0;
    });
  }

  void _recordLap() {
    if (_milliseconds > 0) {
      setState(() {
        int splitTime = _milliseconds - _lastLapTime;
        _laps.insert(
          0,
          Lap(
            number: _laps.length + 1,
            totalTime: _milliseconds,
            splitTime: splitTime,
          ),
        );
        _lastLapTime = _milliseconds;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final bgColor = isDark ? const Color(0xFF0D1B2A) : const Color(0xFFF0F4F8);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Stopwatch Pro',
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : const Color(0xFF2E7FD8).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: const Color(0xFF2E7FD8),
                size: 24,
              ),
              onPressed: widget.onThemeToggle,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildLogo(isDark),
            const SizedBox(height: 30),
            Expanded(
              flex: 2,
              child: TimerDisplay(
                milliseconds: _milliseconds,
                isRunning: _isRunning,
                isDarkMode: isDark,
              ),
            ),
            const SizedBox(height: 20),
            ControlButtons(
              isRunning: _isRunning,
              hasTime: _milliseconds > 0,
              onStart: _startTimer,
              onStop: _stopTimer,
              onReset: _resetTimer,
              onLap: _recordLap,
              isDarkMode: isDark,
            ),
            const SizedBox(height: 30),
            if (_laps.isNotEmpty)
              Expanded(
                flex: 3,
                child: LapList(
                  laps: _laps,
                  isDarkMode: isDark,
                ),
              )
            else
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'No laps recorded yet',
                    style: TextStyle(
                      color: textColor.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7FD8).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/app_icon.png',
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}