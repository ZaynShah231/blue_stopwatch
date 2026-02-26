import 'package:flutter/material.dart';
import '../models/lap.dart';
import '../utils/time_formatter.dart';

class LapList extends StatelessWidget {
  final List<Lap> laps;
  final bool isDarkMode;

  const LapList({
    Key? key,
    required this.laps,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode ? const Color(0xFF16213E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1A1A2E);

    int fastestTime = laps.map((l) => l.splitTime).reduce((a, b) => a < b ? a : b);
    int slowestTime = laps.map((l) => l.splitTime).reduce((a, b) => a > b ? a : b);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LAPS',
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7FD8).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${laps.length}',
                    style: const TextStyle(
                      color: Color(0xFF2E7FD8),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 10),
              itemCount: laps.length,
              itemBuilder: (context, index) {
                final lap = laps[index];
                final isFastest = lap.splitTime == fastestTime && laps.length > 1;
                final isSlowest = lap.splitTime == slowestTime && laps.length > 1;

                return _buildLapTile(
                  lap: lap,
                  isFastest: isFastest,
                  isSlowest: isSlowest,
                  textColor: textColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLapTile({
    required Lap lap,
    required bool isFastest,
    required bool isSlowest,
    required Color textColor,
  }) {
    Color highlightColor = textColor;
    Color bgColor = Colors.transparent;
    String? badge;

    if (isFastest) {
      highlightColor = const Color(0xFF51CF66);
      bgColor = const Color(0xFF51CF66).withOpacity(0.1);
      badge = 'FASTEST';
    } else if (isSlowest) {
      highlightColor = const Color(0xFFFF6B6B);
      bgColor = const Color(0xFFFF6B6B).withOpacity(0.1);
      badge = 'SLOWEST';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isFastest || isSlowest
              ? highlightColor.withOpacity(0.3)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: highlightColor.withOpacity(0.15),
            ),
            child: Center(
              child: Text(
                '${lap.number}',
                style: TextStyle(
                  color: highlightColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TimeFormatter.format(lap.splitTime),
                  style: TextStyle(
                    color: highlightColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    badge,
                    style: TextStyle(
                      color: highlightColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            TimeFormatter.format(lap.totalTime),
            style: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}