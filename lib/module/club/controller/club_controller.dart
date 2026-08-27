import 'package:flutter/foundation.dart';
import 'package:test_notification/module/club/model/club_model.dart';
import 'package:test_notification/module/club/service/club_service.dart';

class ClubController extends ChangeNotifier {
  final ClubService _api;

  ClubController(this._api);

  //States
  List<ClubModel> _clubs = List.unmodifiable([]);

  String? _error;

  // getters
  List<ClubModel> get allGroups => _clubs;
  List<ClubModel> get myGroups => _clubs.where((it) => it.isJoined).toList();
  String? get error => _error;

  Future<void> loadClubs() async {
    try {
      final clubs = await _api.getClubs();
      _clubs = clubs;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> joinedClub() async {
    try {
      // await _api.joineClubById(id, value);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
