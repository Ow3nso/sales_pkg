import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AppBarType,
        CartController,
        Customer,
        DefaultBackButton,
        DefaultInputField,
        HourGlass,
        LuhkuAppBar,
        NavigationService,
        ReadContext,
        ShortMessages,
        StyleColors,
        WatchContext;
import 'package:sales_pkg/src/controllers/customer_controller.dart';
import 'package:sales_pkg/src/pages/customer/widgets/customer_card.dart';

import '../../../utils/styles/app_util.dart';
import '../../../widgets/bottom_card.dart';
import '../../../widgets/default_message.dart';
import 'add_customer_view.dart';

class CustomerView extends StatelessWidget {
  const CustomerView({super.key});
  static const routeName = 'customers';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: LuhkuAppBar(
        color: Theme.of(context).colorScheme.onPrimary,
        height: 130,
        appBarType: AppBarType.other,
        backAction: const DefaultBackButton(),
        title: Expanded(
          child: Text(
            'Your Customers',
            style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
        ),
        bottom: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
          child: DefaultInputField(
            onChange: (value) {},
            hintText: 'Search',
            prefix: Image.asset(
              AppUtil.searchIcon,
              package: AppUtil.packageName,
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
            future: context.read<CustomerController>().getStoreCustomers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (context.watch<CustomerController>().customers.isEmpty) {
                  return DefaultMessage(
                    title: "You don't have customers yet",
                    description:
                        "Add a customer to your store by tapping the button below",
                    label: "Add Customer",
                    color: StyleColors.lukhuError10,
                    assetImage: AppUtil.deleteProfileIcon,
                    onTap: () {
                      NavigationService.navigate(
                          context, AddCustomer.routeName);
                    },
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => context
                      .read<CustomerController>()
                      .getStoreCustomers(isRefreshMode: true, limit: 20),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemCount: context
                        .watch<CustomerController>()
                        .customers
                        .keys
                        .length,
                    itemBuilder: (context, index) {
                      return CustomerCard(
                        data: _customer(context, index)!.toJson(),
                        customer: _customer(context, index)!,
                        onTap: (customer) {
                          context.read<CustomerController>().customer =
                              customer;
                          context.read<CartController>().customerName.text =
                              customer.name ?? "";
                          ShortMessages.showShortMessage(
                            message: '${customer.name} has been selected!',
                          );

                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return DefaultMessage(
                  title: 'Error',
                  assetImage: AppUtil.deleteProfileIcon,
                  color: StyleColors.lukhuError10,
                  description: snapshot.error.toString(),
                  label: 'Try Again',
                  onTap: () {
                    context.read<CustomerController>().getStoreCustomers();
                  },
                );
              }

              return const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: HourGlass(),
                ),
              );
            },
          ),
        ),
      ),
      bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
          ? null
          : context.watch<CustomerController>().customers.isEmpty
              ? null
              : BottomCard(
                  label: 'Add Customer',
                  onTap: () {
                    NavigationService.navigate(context, AddCustomer.routeName);
                  },
                ),
    );
  }

  Customer? _customer(BuildContext context, int index) {
    return context
        .read<CustomerController>()
        .customers[_customerKey(context, index)];
  }

  String _customerKey(BuildContext context, int index) {
    return context.read<CustomerController>().customers.keys.elementAt(index);
  }
}
