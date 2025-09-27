import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payment_app/features/drawer/model/main_menu_model.dart';
import 'package:go_router/go_router.dart';
import '../../../core/helpers/cache_helper/app_cache_helper.dart';
import '../../../core/helpers/encryption/app_encryption_helper.dart';
import '../../../core/helpers/encryption/encryption_value.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../repository/drawer_repo.dart';

class DrawerProvider extends ChangeNotifier {
  int? _hoveredIndex;

  int? get hoveredIndex => _hoveredIndex;

  void setHoveredIndex(int? index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  String branchName = '';
  Future<void> setCurBranchName() async {
    final appCacheHelper = AppCacheHelper();
    final appDecryptHelper = AppEncryptionHelper();
    final encrptBranchName = await appCacheHelper.getData("branchName");
    final decrptBranchName = appDecryptHelper.decryptData(
        data: encrptBranchName.toString(),
        baseKey: EncryptionValue.keyAsString,
        ivKey: EncryptionValue.ivAsString);
    branchName = decrptBranchName;
    notifyListeners();
  }

  ///Expand drawer
  bool _isDrawerExpanded = true;

  bool get isDrawerExpanded => _isDrawerExpanded;

  void toggleDrawerExpansion() {
    _isDrawerExpanded = !_isDrawerExpanded;
    notifyListeners();
  }

  ///Api calls
  final _api = DrawerRepository();
  List<MainMenuModel> mainMenu = [];
  Future<void> getMainMenu({required BuildContext context}) async {
    try {
      final response = await _api.getMainMenu();

      if (response != null && response['status'] == 200) {
        mainMenu = [];
        final items = (response['data']['menuResDto'] as List)
            .map((item) => MainMenuModel.fromJson(item))
            .toList();

        mainMenu = items;
        notifyListeners();
      } else if (response != null && response['status'] == 500) {
        CustomToast.showCustomErrorToast(message: "${response['data']}");
        notifyListeners();
      } else if (response != null && response['status'] == 401) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomAlertDialog.showCustomAlertDialog(
            context: context,
            title: 'Failed',
            message: "${response['data']['message']}",
            cancelText: 'Ok',
            onCancelPressed: () {
              Navigator.of(context).pop();
              context.goNamed(RoutesName.session_expires);
            },
          );
        });
        notifyListeners();
      } else {
        CustomToast.showCustomErrorToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }
}
