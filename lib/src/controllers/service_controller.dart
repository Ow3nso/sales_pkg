import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        BlurDialogBody,
        Helpers,
        NavigationService,
        ReadContext,
        UserRepository;

import '../pages/services/widgets/photography_service.dart';
import '../utils/styles/app_util.dart';

class ServiceController extends ChangeNotifier {
  List<Map<String, dynamic>> get storeDetails => AppUtil.storeDetails;

  String? _webDomain;
  String? get webDomain => _webDomain;
  set webDomain(String? value) {
    _webDomain = value;
    notifyListeners();
  }

  void setPerformanceValue() {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;
    storeDetails[1]['lable'] = context.read<UserRepository>().shop?.name ?? '';
    storeDetails[0]['lable'] =
        context.read<UserRepository>().shop?.webDomain ?? '';
    storeDetails[2]['lable'] =
        context.read<UserRepository>().user?.userName ?? '';

    webDomain = context.read<UserRepository>().shop?.webDomain ?? '';

    _storeNameController.text = context.read<UserRepository>().shop?.name ?? '';
    _storeDescriptionController.text =
        context.read<UserRepository>().user?.bioDescription ?? "";
    _storeUsernameController.text =
        context.read<UserRepository>().user?.userName ?? '';
    _storeDescriptionController.text =
        context.read<UserRepository>().shop?.description ?? '';
    _storeLinkController.text =
        context.read<UserRepository>().user?.userName ?? '';

    notifyListeners();

    Helpers.debugLog('[STOREDETAILS LOGGED]${storeDetails[2]['lable']}');
  }

  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storeLinkController = TextEditingController();
  final TextEditingController _storeDescriptionController =
      TextEditingController();
  final TextEditingController _storeUsernameController =
      TextEditingController();

  TextEditingController get storeNameController => _storeNameController;
  TextEditingController get storeLinkController => _storeLinkController;
  TextEditingController get storeDescriptionController =>
      _storeDescriptionController;
  TextEditingController get storeUsernameController => _storeUsernameController;

  bool get isUserDescriptionEmpty =>
      storeDescriptionController.text.isEmpty ||
      storeUsernameController.text.isEmpty;

  bool _requestFreeDomain = false;
  bool get requestFreeDomain => _requestFreeDomain;
  set requestFreeDomain(bool value) {
    _requestFreeDomain = value;
    notifyListeners();
  }

  bool _isUploading = false;
  bool get isUploading => _isUploading;
  set isUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

  String? _storeLink;
  String? get storeLink => _storeLink;
  set storeLink(String? value) {
    _storeLink = value;
    notifyListeners();
  }

  void showPhotographyService({required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (ctx) => const BlurDialogBody(
        bottomDistance: 80,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: PhotographyService(),
        ),
      ),
    );
  }

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;
  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  // Future<void> shareProuct(
  //     {required String productId, required BuildContext context}) async {
  //   final product = products[productId];
  //   if (product == null) {
  //     ShortMessages.showShortMessage(
  //         type: ShortMessageType.error,
  //         message: 'An error occurred, try again later !');
  //     return;
  //   }
  //   final link = await getProductLink(product: product, context: context);
  //   if (link == null) return;
  //   Dialogue.blurredDialogue(
  //       context: context,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16),
  //         child: ShareCard(
  //           productUrl: link,
  //         ),
  //       ));
  // }
}
