import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_notification/module/club/controller/club_controller.dart';
import 'package:test_notification/module/club/widget/club_list_view.dart';

class ClubListScreen extends StatefulWidget {
  const ClubListScreen({super.key});

  @override
  State<ClubListScreen> createState() => _ClubListScreenState();
}

class _ClubListScreenState extends State<ClubListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ClubController>().loadClubs();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final clubControler = context.watch<ClubController>();
    return ClubListView(
      allGroups: clubControler.allGroups,
      myGroups: clubControler.myGroups,
      onJoinedTap: (club) {},
    );
  }
}
