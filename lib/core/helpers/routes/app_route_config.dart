import 'package:flutter/material.dart';
import 'package:flutter_payment_app/features/payments/view/report/pay_ogl_report/view/pay_ogl_report.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../features/bread_crumbs/controller/breadcrumbs_controller.dart';
import '../../../features/home/view/home_page.dart';
import '../../../features/home/view/shell/main_shell.dart';
import '../../../features/payments/view/payments/change_branch_imps_bank/view/ch_branch_imps_bank.dart';
import '../../../features/payments/view/payments/change_debit_advice_branch/view/advise_branch_page.dart';
import '../../../features/payments/view/payments/debit_advise_block/view/debit_advise_block.dart';
import '../../../features/payments/view/payments/reini_sus_pay_req/view/reini_sus_pay_req.dart';
import '../../../features/payments/view/payments_page.dart';
import '../../../features/payments/view/report/customer_neft_details/view/neft_details.dart';
import '../../../features/payments/view/report/imps_inquiry/view/imps_inquiry.dart';
import '../../../features/payments/view/report/imps_inquiry/view/imps_report/view/imps_report.dart';
import '../../../features/payments/view/report/pay_report/view/pay_report.dart';
import '../../../features/payments/view/report/payment_status/view/payment_status.dart';
import '../../../features/splash_screen/view/spalsh_screen.dart';
import '../internet_connectivity/view/connectivity_page.dart';
import '../session/view/error_page.dart';
import '../session/view/session_expire.dart';
import 'app_route_name.dart';
import 'app_route_path.dart';

class AppRoutes {
  final GlobalKey<NavigatorState> rootNavigatorKey;
  late final GoRouter appRouter;
  AppRoutes({
    required this.rootNavigatorKey,
  }) {
    appRouter = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RoutesPath.splash,
      routes: [
        GoRoute(
          name: RoutesName.error_page,
          path: RoutesPath.error_page,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const ErrorPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          name: RoutesName.connectivity_page,
          path: RoutesPath.connectivity_page,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const ConnectivityPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          name: RoutesName.session_expires,
          path: RoutesPath.session_expires,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const SessionExpiredPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          name: RoutesName.splash,
          path: '/requesthandler',
          pageBuilder: (context, state) {
            final queryParams = state.uri.queryParameters;
            final curSession = queryParams['session'] ??
                '05E408121A28051FA42040CA6FC5A4B630F07115213C3D5B67060332BB74DC533BF365FD938028970435DEFFF85216EA74CB1556C51751206A7481AF3072104C';
            final curToken = queryParams['token'] ??
                '36696e3247414f6a7a624577375531484b61546958574468736637384f31657638526b4b4365616263734c72617a70694751756c63444f5652677469547a32714d4f7967497667755166744b4151365242663634774230396e433665696678374e593064376c674971313957794b37517753654676724770564a6478456e2b6763735747733371645633737574596f69457659746767722f55716a5663316d795956414a516566575a592f47506d78325835483344336b6b4a766a464c584530316a6f33565843772f58455957517275762f575544426f49774f446743464d795951754432734b50567155507235426f6c62486f55684d667134674b585538642b78494876595766424e38544835433370326e437268666f4e4b674e50784b3751537464416b77646378695a6558443458524d4f4774446c484b566d46776d2b452f46597755316d6853315a536b724979744f77746667706251714d2b76667556727a506f6b636562777945477838512b492b354e55344a706e6c612b5739797367474c6a4337374c634e6671772b6452574843797644594345633139685068636a636b33557a5037435a51566749583676344f79636d2f736d4e496e4f652b';
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: SplashScreen(
                session: curSession,
                token: curToken,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return MainShell(child: child);
          },
          routes: [
            GoRoute(
              name: RoutesName.home,
              path: RoutesPath.home,
              pageBuilder: (context, state) {
                _removeBreadCrumbs(context);
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const HomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                );
              },
              routes: [
                GoRoute(
                    name: RoutesName.payments,
                    path: 'payments',
                    pageBuilder: (context, state) {
                      final queryParams = state.uri.queryParameters;
                      final mainMenuId = queryParams['main_menu_id'] ?? '';

                      Map<String, String> data = {
                        "name": "payments",
                        "path": "/home/payments?main_menu_id=$mainMenuId"
                      };
                      _addBreadCrumbs(context, data);
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: PaymentsPage(
                          mainMenuId: mainMenuId,
                        ),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                    routes: [
                      GoRoute(
                        name: RoutesName.changeBranchImpsBank,
                        path: 'change_branch_imps_bank',
                        pageBuilder: (context, state) {
                          Map<String, String> data = {
                            "name": "Change Branch Imps Bank",
                            "path": "/home/payments/change_branch_imps_bank"
                          };
                          _addBreadCrumbs(context, data);

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ChangeBranchImpsBranch(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.changeDebitAdviseBranch,
                        path: 'change_debit_advise_branch',
                        pageBuilder: (context, state) {
                          Map<String, String> data = {
                            "name": "Change Debit Advice Branch",
                            "path": "/home/payments/change_debit_advise_branch"
                          };
                          _addBreadCrumbs(context, data);

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ChangeDebitAdviseBranch(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.payOglReport,
                        path: 'payment_ogl_report',
                        pageBuilder: (context, state) {
                          Map<String, String> data = {
                            "name": "payment ogl report",
                            "path": "/home/payments/payment_ogl_report"
                          };
                          _addBreadCrumbs(context, data);

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const PayOglReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.payReport,
                        path: 'payment_report',
                        pageBuilder: (context, state) {
                          Map<String, String> data = {
                            "name": "payment report",
                            "path": "/home/payments/payment_report"
                          };
                          _addBreadCrumbs(context, data);

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const PayReport(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.paymentStatus,
                        path: 'payment_status',
                        pageBuilder: (context, state) {
                          Map<String, String> data = {
                            "name": 'Payment Status',
                            "path": "/home/payments/payment_status"
                          };
                          _addBreadCrumbs(context, data);

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const PaymentStatus(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                          name: RoutesName.impsInquiry,
                          path: 'imps_inquiry',
                          pageBuilder: (context, state) {
                            Map<String, String> data = {
                              "name": 'Imps Inquiry',
                              "path": "/home/payments/imps_inquiry"
                            };
                            _addBreadCrumbs(context, data);

                            return CustomTransitionPage<void>(
                              key: state.pageKey,
                              child: const ImpsInquiry(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                            );
                          },
                          routes: [
                            GoRoute(
                              name: RoutesName.impsInquiryReport,
                              path: 'imps_inquiry_report',
                              pageBuilder: (context, state) {
                                Map<String, String> data = {
                                  "name": 'Imps Inquiry report',
                                  "path":
                                      "/home/payments/imps_inquiry/imps_inquiry_report"
                                };
                                _addBreadCrumbs(context, data);

                                return CustomTransitionPage<void>(
                                  key: state.pageKey,
                                  child: const ImpsInquiryReport(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                          opacity: animation, child: child),
                                );
                              },
                            ),
                          ]),
                      GoRoute(
                        name: RoutesName.neftDeatils,
                        path: 'neft_deatils',
                        pageBuilder: (context, state) {
                          Map<String, String> data = {
                            "name": 'customer NEFT details',
                            "path": "/home/payments/neft_deatils"
                          };
                          _addBreadCrumbs(context, data);

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const CusNEFTDetails(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.reiniSusPayReq,
                        path: 'reini_sus_pay_req',
                        pageBuilder: (context, state) {
                          Map<String, String> data = {
                            "name": 'Reinitiate successful payment request',
                            "path": "/home/payments/reini_sus_pay_req"
                          };
                          _addBreadCrumbs(context, data);

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const ReiniSusPayReq(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                      GoRoute(
                        name: RoutesName.debitAdviseBlock,
                        path: 'debit_advise_block',
                        pageBuilder: (context, state) {
                          Map<String, String> data = {
                            "name": 'Debit advise block',
                            "path": "/home/payments/debit_advise_block"
                          };
                          _addBreadCrumbs(context, data);

                          return CustomTransitionPage<void>(
                            key: state.pageKey,
                            child: const DebitAdviseBlock(),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                                    opacity: animation, child: child),
                          );
                        },
                      ),
                    ]),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) {
        return const ErrorPage();
      },
    );
  }
  void _addBreadCrumbs(BuildContext context, Map<String, String> data) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BreadCrumbsProvider>().addBreadcrumb(data);
    });
  }

// Method to clear breadcrumbs
  void _removeBreadCrumbs(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BreadCrumbsProvider>().clearBreadcrumbs();
    });
  }
}
