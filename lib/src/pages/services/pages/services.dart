import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AddProfilePhotoView,
        AnalyticsPage,
        AppBarType,
        BlurDialogBody,
        CartController,
        DefaultBackButton,
        DefaultButton,
        DefaultCallBtn,
        DefaultIconBtn,
        ImageUploadType,
        LuhkuAppBar,
        NavigationService,
        PlanCard,
        PlanController,
        PlansView,
        ReadContext,
        StyleColors,
        TransactionsPage,
        WatchContext;
import 'package:sales_pkg/src/controllers/service_controller.dart';
import 'package:sales_pkg/src/pages/discount/discount_view.dart';
import 'package:sales_pkg/src/pages/services/pages/expense.dart';
import 'package:sales_pkg/src/pages/services/pages/request_delivery.dart';
import 'package:sales_pkg/src/pages/services/widgets/store_detail.dart';
import 'package:sales_pkg/src/pages/services/widgets/update_store_card.dart';
import '../../../utils/styles/app_util.dart';
import '../widgets/detail_tile.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});
  static const routeName = 'service';

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ServiceController>().setPerformanceValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    final showButton = args != null;
    return Scaffold(
      appBar: LuhkuAppBar(
        appBarType: AppBarType.other,
        backAction: showButton ? const DefaultBackButton() : null,
        enableShadow: true,
        color: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Services',
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          const DefaultCallBtn(),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: DefaultIconBtn(
              backgroundColor: StyleColors.lukhuWhite,
              packageName: AppUtil.packageName,
              assetImage: AppUtil.userOctagonIcon,
              onTap: () {
                NavigationService.navigate(context, "edit_profile");
              },
            ),
          ),
          IconButton(
            onPressed: () {
              NavigationService.navigate(context, "user_settings");
            },
            icon: Icon(
              Icons.settings_outlined,
              color: StyleColors.lukhuDark1,
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16),
              child: Text(
                "Your Plan",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PlanCard(
                item: context.watch<PlanController>().selectedPlan,
                show: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 10, right: 16, left: 16),
              child: DefaultButton(
                height: 40,
                label: "Compare Plans",
                color: StyleColors.lukhuBlue,
                onTap: () {
                  NavigationService.navigate(context, PlansView.routeName);
                },
              ),
            ),
            StoreDetial(
              title: "Store Details",
              label: "View Website",
              onTapLabel: () {},
              children: List.generate(
                  context.watch<ServiceController>().storeDetails.length,
                  (index) {
                var item =
                    context.watch<ServiceController>().storeDetails[index];
                return DetailTile(
                  item: item,
                  onTap: () => _showDialog(context, index),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: StoreDetial(
                title: "Store Performance",
                children:
                    List.generate(AppUtil.storePerformance.length, (index) {
                  var item = AppUtil.storePerformance[index];
                  return DetailTile(
                    item: item,
                    onTap: () {
                      _storePerformance(index, context);
                    },
                  );
                }),
              ),
            ),
            StoreDetial(
              title: "Business Tools",
              children: List.generate(AppUtil.businessTools.length, (index) {
                var item = AppUtil.businessTools[index];
                return DetailTile(
                  item: item,
                  onTap: () {
                    context.read<CartController>().clearCart();
                    switch (index) {
                      case 0:
                        NavigationService.navigate(
                            context, DiscountView.routeName);
                        break;

                      case 1:
                        context
                            .read<ServiceController>()
                            .showPhotographyService(context: context);
                        break;

                      case 2:
                        NavigationService.navigate(
                          context,
                          RequestDeliveryView.routeName,
                        );
                        break;

                      default:
                        NavigationService.navigate(
                            context, TransactionsPage.routeName);
                        break;
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _storePerformance(int index, BuildContext context) {
    switch (index) {
      case 0:
        NavigationService.navigate(context, TransactionsPage.routeName);
        break;
      case 1:
        NavigationService.navigate(context, AnalyticsPage.routeName);
        break;
      case 2:
        NavigationService.navigate(context, ExpenseView.routeName);
        break;
      default:
        NavigationService.navigate(context, TransactionsPage.routeName);
        break;
    }
  }

  void _showDialog(BuildContext context, int index) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return BlurDialogBody(
          bottomDistance: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: index >= 3
                ? AddProfilePhotoView(
                    label: 'Cancel',
                    title: details[index]!['title'] ?? '',
                    description: details[index]!['description'] ?? '',
                    type: index == 3
                        ? ImageUploadType.logo
                        : ImageUploadType.header,
                  )
                : UpdateStoreCard(
                    index: index,
                    title: 'Update your Store Link',
                    description:
                        'Your store link enables customers to find you easily on the internet',
                  ),
          ),
        );
      },
    );
  }

  final Map<int, Map<String, dynamic>> details = {
    3: {
      'title': 'Update your Store Logo',
      'description': 'Upload a logo that reps your brand!',
    },
    4: {
      'title': 'Update your store header',
      'description':
          'Upload a header image that shows what your brand is all about'
    }
  };
}
