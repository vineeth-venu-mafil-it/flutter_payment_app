import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import '../../../../../../core/helpers/routes/app_route_name.dart';
import '../../../../../../core/utils/config/styles/colors.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_alert_box.dart';
import '../../../../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/cus_neft_model.dart';
import '../repository/cus_neft_repo.dart';

class CusNEFTDetailsProvider extends ChangeNotifier {
  final FocusNode focusNode = FocusNode();
  bool isLoading = false;
  TextEditingController textController = TextEditingController();
  String validateId = '';
  void validateUserId({required String id}) {
    if (id.isEmpty) {
      validateId = 'should not be empty';
      notifyListeners();
      return;
    }
    const String spclChars = r'!@#$%^&*()/+-][/_=|{}.,;:~`?<>';

    for (int i = 0; i < id.length; i++) {
      if (spclChars.contains(id[i])) {
        validateId = 'Special characters are not allowed';
        notifyListeners();
        return;
      }
    }

    validateId = '';
    notifyListeners();
  }

  //Data table
  int _rowsPerPage = 10;
  int get rowsPerPage => _rowsPerPage;

  void updateRowsPage({required int data}) {
    _rowsPerPage = data;
    notifyListeners();
  }

  //Mouse hover
  bool hoverBtn = false;

  void mouseHover() {
    hoverBtn = !hoverBtn;
    notifyListeners();
  }

  //Api call
  ///Customer Neft details
  Future<void> chkCusNEFTDetAccess({required BuildContext context}) async {
    try {
      final response = await _api.chkCusNeftDetAccess();

      if (response != null && response['status'] == 200) {
        final splitResponse = response['data']['response'][0]['RES'].split('~');
        if (splitResponse[0].toString() == "0") {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomAlertDialog.showCustomAlertDialog(
              context: context,
              title: 'Unauthorized',
              message: splitResponse[1].toString(),
              cancelText: 'Ok',
              onCancelPressed: () {
                context.pop();
                context.go('/home');
              },
            );
          });
        } else {
          if (context.mounted) {
            context.goNamed(RoutesName.neftDeatils);
          }
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
    }
  }

  final _api = CusNEFTDetRepository();
  List<CusNEFTModel> cusNEFTList = [];
  Future<void> fetchCusNEFTdata(
      {required BuildContext context, required String userId}) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.fetchCusNEFTdata(custId: userId.trim());

      if (response != null && response['status'] == 200) {
        cusNEFTList = [];
        final tasks = (response['data']['response'] as List)
            .map((item) => CusNEFTModel.fromJson(item))
            .toList();
        cusNEFTList = tasks;
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
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCusNEFTidProof(
      {required BuildContext context, required String cusId}) async {
    try {
      final response = await _api.fetchCusNEFTidProof(cusId: cusId);

      if (response != null && response['status'] == 200) {
        if (context.mounted) {
          final value = response['data']['response'][0]['ID_PROOF'];
          if (value != null) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.memory(base64Decode(
                              "${response['data']['response'][0]['ID_PROOF']}"))
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyboardListener(
                          focusNode: focusNode,
                          autofocus: true,
                          onKeyEvent: (event) {
                            if (event is KeyDownEvent &&
                                event.logicalKey == LogicalKeyboardKey.enter) {
                              context.pop();
                            }
                          },
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.drawerImgTileColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              context.pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'Ok',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("No data found"),
                backgroundColor: Colors.red,
              ),
            );
          }
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
    }
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    cusNEFTList = [];
    super.dispose();
  }
}
