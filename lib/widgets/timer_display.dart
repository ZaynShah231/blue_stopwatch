import 'package:flutter/material.dart';
import '../utils/time_formatter.dart';

class TimerDisplay extends StatelessWidget {
  final int milliseconds;
  final bool isRunning;
  final bool isDarkMode;

  const TimerDisplay({
    Key? key,
    required this.milliseconds,
    required this.isRunning,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode ? const Color(0xFF16213E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1A1A2E);
    final accentColor = const Color(0xFF2E7FD8);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(isRunning ? 0.3 : 0.15),
            blurRadius: isRunning ? 25 : 15,
            spreadRadius: isRunning ? 3 : 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              TimeFormatter.format(milliseconds),
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w300,
                color: textColor,
                fontFamily: 'monospace',
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}