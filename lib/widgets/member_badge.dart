import 'package:flutter/material.dart';
import '../models/user.dart';

class MemberBadge extends StatelessWidget {
  final MemberRank rank;
  final String size;

  const MemberBadge({
    super.key,
    required this.rank,
    this.size = 'small',
  });

  static const _rankConfig = {
    MemberRank.bronze: {'color': Color(0xFFCD7F32), 'label': 'Bronze'},
    MemberRank.silver: {'color': Color(0xFFC0C0C0), 'label': 'Silver'},
    MemberRank.gold: {'color': Color(0xFFFFD700), 'label': 'Gold'},
    MemberRank.platinum: {'color': Color(0xFFE5E4E2), 'label': 'Platinum'},
    MemberRank.diamond: {'color': Color(0xFFB9F2FF), 'label': 'Diamond'},
  };

  @override
  Widget build(BuildContext context) {
    final config = _rankConfig[rank]!;
    final color = config['color'] as Color;
    final label = config['label'] as String;
    final fontSize = size == 'large'
        ? 14.0
        : size == 'medium'
            ? 12.0
            : 10.0;
    final paddingH = size == 'large'
        ? 12.0
        : size == 'medium'
            ? 10.0
            : 8.0;
    final paddingV = size == 'large'
        ? 6.0
        : size == 'medium'
            ? 4.0
            : 3.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
