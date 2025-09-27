import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../model/payment_tab_model.dart';
import '../model/payments_child_model.dart';
import '../repository/payments_repo.dart';

class PaymentsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _curIndex = 0;
  int get curIndex => _curIndex;

  set curIndex(int value) {
    _curIndex = value;
  }

  String? _currentLoadingRoute;

  String? get currentLoadingRoute => _currentLoadingRoute;

  final TextEditingController searchController = TextEditingController();

  void setLoading(String? route) {
    _currentLoadingRoute = route;
    notifyListeners();
  }

  Future<void> setTabIndex(
      {required BuildContext context,
      required int index,
      required String menuId}) async {
    _curIndex = index;
    for (int i = 0; i < subMenu.length; i++) {
      if (i == index) {
        curSubMenuId = subMenu[i].sUBMENUID ?? '';
        break;
      }
    }

    await getChildMenu(context: context, mainMenuId: menuId);

    notifyListeners();
  }

  void searchItems(String query) {
    if (query.isEmpty) {
      filteredItems = List.from(childMenu);
    } else {
      filteredItems = childMenu
          .where((item) => item.cHILDMENUNAME
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  //transition

  void onEnter(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void onExit() {
    selectedIndex = -1;
    notifyListeners();
  }

  void resetItem() {
    selectedIndex = -1;
    curIndex = 0;
    notifyListeners();
  }

  ///Api calls
//payment status check api
  int selectedIndex = -1;
  void setIndex({required int curIndex}) {
    selectedIndex = curIndex;
    notifyListeners();
  }

  final _api = PaymentsRepository();
  bool _isLoadingStatus = false;
  bool get isLoadingStatus => _isLoadingStatus;
  int _loadingIndex = -1;
  int get loadingIndex => _loadingIndex;

  set loadingIndex(int value) {
    _loadingIndex = value;
  }

  ///tab menu
  List<PaymentTabModel> subMenu = [];
  String curSubMenuId = '';
  Future<void> getSubMenu(
      {required BuildContext context, required String mainMenuId}) async {
    try {
      final response = await _api.getSubMenu(mainMenuId: mainMenuId);

      if (response != null && response['status'] == 200) {
        subMenu = [];
        curSubMenuId = '';
        final items = (response['data']['menuResDto'] as List)
            .map((item) => PaymentTabModel.fromJson(item))
            .toList();

        subMenu = items;
        curSubMenuId = subMenu.first.sUBMENUID ?? '';
        if (context.mounted) {
          await setTabIndex(
              context: context, index: 0, menuId: mainMenuId ?? '');
        }

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

  List<PaymentsChildModel> childMenu = [];

  List<PaymentsChildModel> filteredItems = [];
  Future<void> getChildMenu(
      {required BuildContext context, required String mainMenuId}) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await _api.getChildMenu(
          mainMenuId: mainMenuId, subMenuId: curSubMenuId);

      if (response != null && response['status'] == 200) {
        childMenu = [];
        filteredItems = [];

        final items = (response['data']['menuResDto'] as List)
            .map((item) => PaymentsChildModel.fromJson(item))
            .toList();

        childMenu = items;
        filteredItems = items;
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ///IMPS inquiry
  Future<void> chkImpsStatus({required BuildContext context}) async {
    try {
      setLoading(RoutesPath.impsInquiry);
      notifyListeners();
      final response = await _api.chkImpsStatus();

      if (response != null && response['status'] == 200) {
        final splitResponse = response['data']['response'][0]['RES'].split('~');

        final shouldNavigate = splitResponse[0].toString() == "0" ||
            splitResponse[0].toString() == "1";

        notifyListeners();

        if (shouldNavigate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomAlertDialog.showCustomAlertDialog(
              context: context,
              title: 'Unauthorized $shouldNavigate $splitResponse[0]',
              message: splitResponse[1].toString(),
              cancelText: 'Ok',
              onCancelPressed: () {
                context.pop();
              },
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.goNamed(RoutesName.impsInquiry);
          });
        }
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
    } finally {
      setLoading(null);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
