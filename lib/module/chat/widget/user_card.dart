import 'package:flutter/material.dart';
import 'package:test_notification/core/assets.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/module/chat/model/users_model.dart';

class UserCard extends StatelessWidget {
  final UsersModel user;
  final VoidCallback? onTap;

  const UserCard({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(Assets.profile1, scale: 3.5),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "${user.name} ${user.lastName}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: borderColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
