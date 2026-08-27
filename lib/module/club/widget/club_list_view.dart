import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/module/club/model/club_model.dart';
import 'package:test_notification/module/club/widget/club_card.dart';

class ClubListView extends StatefulWidget {
  final List<ClubModel> allGroups;
  final List<ClubModel> myGroups;
  final void Function(ClubModel)? onJoinedTap;

  const ClubListView({
    super.key,
    required this.allGroups,
    required this.myGroups,
    this.onJoinedTap,
  });

  @override
  State<ClubListView> createState() => _ClubListViewState();
}

class _ClubListViewState extends State<ClubListView>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = [Constants.allGroups, Constants.myGroups];
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: _tabs.length, vsync: this);

    controller?.addListener(() {
      if (controller!.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.clubs,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              spacing: 10,
              children: List.generate(
                _tabs.length,
                (index) => ChoiceChip(
                  label: Text(_tabs[index]),
                  selected: controller?.index == index,
                  side: BorderSide(color: borderColor),
                  onSelected: (_) {
                    controller?.animateTo(index);
                  },
                  selectedColor: lightGreenColor,
                  backgroundColor: whiteColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                ListView.separated(
                  itemBuilder: (_, index) {
                    final club = widget.allGroups[index];
                    return ClubCard(
                      club: club,
                      onTap: showCludDescriptionModal,
                    );
                  },
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemCount: widget.allGroups.length,
                ),
                ListView.separated(
                  itemBuilder: (_, index) {
                    final club = widget.myGroups[index];
                    return ClubCard(club: club, isMyGroup: true);
                  },
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemCount: widget.myGroups.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCludDescriptionModal(ClubModel club) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ClubDescription(club: club),
    );
  }
}

class ClubDescription extends StatelessWidget {
  final ClubModel club;
  const ClubDescription({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
