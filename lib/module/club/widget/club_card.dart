
import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/module/club/model/club_model.dart';

class ClubCard extends StatelessWidget {
  final ClubModel club;
  final bool isMyGroup;
  final void Function(ClubModel)? onTap;
  const ClubCard({
    super.key,
    required this.club,
    this.isMyGroup = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: borderColor,
            offset: const Offset(0, 10),
            spreadRadius: -5,
            blurRadius: 5,
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: lightGreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.chat_rounded, color: darkGreenColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      club.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    if (!isMyGroup)
                      InkWell(
                        onTap: () => onTap?.call(club),
                        child: Text(
                          club.isJoined ? Constants.joined : Constants.joinNow,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: club.isJoined ? borderColor : darkGreenColor,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${club.topics} ${Constants.topics}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: borderColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
