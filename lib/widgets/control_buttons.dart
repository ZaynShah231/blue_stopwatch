import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final bool isRunning;
  final bool hasTime;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onReset;
  final VoidCallback onLap;
  final bool isDarkMode;

  const ControlButtons({
    Key? key,
    required this.isRunning,
    required this.hasTime,
    required this.onStart,
    required this.onStop,
    required this.onReset,
    required this.onLap,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (isRunning)
            _buildButton(
              onPressed: onLap,
              icon: Icons.flag_rounded,
              label: 'Lap',
              color: const Color(0xFF2E7FD8),
            )
          else if (hasTime)
            _buildButton(
              onPressed: onReset,
              icon: Icons.refresh_rounded,
              label: 'Reset',
              color: const Color(0xFF6C757D),
            )
          else
            const SizedBox(width: 75),
          _buildButton(
            onPressed: isRunning ? onStop : onStart,
            icon: isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
            label: isRunning ? 'Stop' : 'Start',
            color: isRunning
                ? const Color(0xFFFF6B6B)
                : const Color(0xFF51CF66),
            isPrimary: true,
          ),
          const SizedBox(width: 75),
        ],
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
    bool isPrimary = false,
  }) {
    final size = isPrimary ? 85.0 : 75.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: isPrimary ? 40 : 32,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : const Color(0xFF6C757D),
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}