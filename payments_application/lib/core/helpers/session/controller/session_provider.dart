import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:payments_application/core/utils/shared/component/widgets/custom_toast.dart';
import '../../cache_helper/app_cache_helper.dart';
import '../../routes/app_route_name.dart';

class SessionProvider extends ChangeNotifier {
  String? _sessionId;
  DateTime? _sessionStartTime;

  String? get sessionId => _sessionId;

  Future<void> setSession({required String id, required int minutes}) async {
    _sessionId = id;
    _sessionStartTime = DateTime.now(); // Store the current time
    await AppCacheHelper().saveData(key: 'session_id', value: id);
    await AppCacheHelper().saveData(
        key: 'session_start_time', value: _sessionStartTime!.toIso8601String());
    notifyListeners();
  }

  /// Clears the current session.
  Future<void> clearSession() async {
    _sessionId = null;
    _sessionStartTime = null;
    await AppCacheHelper().clearData('session_id');
    await AppCacheHelper().clearData('session_start_time');
    notifyListeners();
  }

  /// Checks if the session is active.
  Future<void> isSessionActive(BuildContext context) async {
    if (_sessionId != null) {
      CustomToast.showCustomErrorToast(message: "Active session");
    } else {
      await clearSession();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomToast.showCustomErrorToast(
            message: "Session expired or inactive");
        context.goNamed(RoutesName.session_expires);
      });
    }
  }

  /// Loads the session from shared preferences.
  bool isActiveSession = false;
  Future<void> loadSession({required BuildContext context}) async {
    // Load session ID and start time from shared preferences
    _sessionId = await AppCacheHelper().getData('session_id');
    String? startTimeString =
        await AppCacheHelper().getData('session_start_time');

    if (_sessionId != null && startTimeString != null) {
      // Parse the start time
      _sessionStartTime = DateTime.parse(startTimeString);

      // Check if the session has expired (15 minutes)
      const sessionDuration = Duration(minutes: 15);
      if (DateTime.now().difference(_sessionStartTime!) > sessionDuration) {
        // Session expired
        await clearSession();
        CustomToast.showCustomErrorToast(message: "Session expired");
        Future.microtask(() => context.goNamed(RoutesName.session_expires));
        isActiveSession = false;
        notifyListeners();
      } else {
        isActiveSession = true;
        notifyListeners();
      }
    } else {
      // No valid session found
      await clearSession();
      final appCacheHelper = AppCacheHelper();
      final encryptedEmpId = await appCacheHelper.getData("empCode");

      // Check if employee ID exists
      if (encryptedEmpId != null) {
        await setSession(
            id: "MAFIL_session", minutes: 15); // Create a new session
        Future.microtask(() => context.goNamed(RoutesName.home));
        isActiveSession = true;
        notifyListeners();
      } else {
        Future.microtask(() => context.goNamed(RoutesName.session_expires));
        isActiveSession = false;
        notifyListeners();
      }
    }
  }
}
