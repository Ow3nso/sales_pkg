import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart'
    show
        AnalyticsPage,
        DeliveryStatus,
        FilterType,
        GlobalAppUtil,
        IntExtension,
        OrderType,
        StyleColors,
        TransactionsPage;
import 'package:sales_pkg/src/pages/order/orders_page.dart';

import '../../pages/discount/discount_view.dart';
import '../../pages/product/pages/product_view.dart';
import '../../pages/services/pages/services.dart';

/// This class is used to store all the static variables that are used in the app
class AppUtil {
  static Duration animationDuration = const Duration(milliseconds: 300);

  /// A static variable that is used to store the package name of the app.
  static String packageName = 'sales_pkg';

  ///ImageIcon
  static String callImageIcon = 'assets/images/call.png';
  static String callIcon = 'assets/images/call.png';
  static String iconBoxSearch = 'assets/images/box_search.png';
  static String filterListingIcon = 'assets/images/filter.png';
  static String notificationIcon = 'assets/images/notification.png';
  static String sendIcon = 'assets/images/send_square.png';
  static String backButton = 'assets/images/arrow_square_left.png';
  static String draftIcon = 'assets/images/draft.png';
  static String copyIcon = 'assets/images/copy.png';
  static String bagIcon = 'assets/images/bag_icon.png';
  static String userIcon = 'assets/images/user_square.png';
  static String genderIcon = 'assets/images/gender_icon.png';
  static String userNameIcon = 'assets/images/username_icon.png';
  static String locationIcon = 'assets/images/location.png';
  static String searchIcon = 'assets/images/search.png';
  static String deleteProfileIcon = 'assets/images/profile_delete.png';
  static String filterIcon = 'assets/images/filter_square.png';
  static String discount = 'assets/images/discount.png';
  static String discountIcon = 'assets/images/discount_shape.png';
  static String documentTextIcon = 'assets/images/document_text.png';
  static String folderOpenIcon = 'assets/images/folder_open.png';
  static String barcodeIcon = 'assets/images/barcode.png';
  static String trash = 'assets/images/trash.png';
  static String alertCircle = 'assets/images/alert_circle.png';
  static String productIcon = 'assets/images/products.png';
  static String sendImageIcon = 'assets/images/send.png';
  static String alertTriangleIcon = 'assets/images/alert_triangle.png';

  static String styleViewRoute = 'size_guide_view';

  static List<Map<String, dynamic>> productManageOptions = [
    {
      'name': 'Set a discount',
      'value': '',
      'type': FilterType.setDiscount,
      'options': []
    },
    {
      'name': 'Boost product',
      'value': '',
      'type': FilterType.other,
      'options': []
    },
    {
      'name': 'Duplicate product',
      'value': '',
      'type': FilterType.dulicateProduct,
      'options': []
    },
    {
      'name': 'Mark as Sold',
      'value': '',
      'type': FilterType.markAsSold,
      'options': []
    },
  ];

  static List<Map<String, dynamic>> collectionOptions = [
    {
      'name': 'Select Product Collections',
      'value': '',
      'type': FilterType.other,
      'options': []
    },
  ];

  static List<String> durations = [
    'Today',
    'Yesterday',
    'This Week',
    'Last 7 Days',
    'Last 30 Days',
    'Last 6 Months',
    'Last 1 Year',
    'Custom Date Range'
  ];

  static List<Map<String, dynamic>> sellerStats = [
    {
      'title': 'Revenue',
      'description': 'KSh 0.00',
      'image': 'assets/images/money.png',
      'color': const Color(0xffEDFFDF)
    },
    {
      'title': 'Orders',
      'description': '0',
      'image': 'assets/images/box.png',
      'color': const Color(0xffF0EFFF)
    },
    {
      'title': 'Views',
      'description': '0',
      'image': 'assets/images/chart_square.png',
      'color': const Color(0xffFCE7EE)
    },
  ];

  static List<Map<String, dynamic>> sellerViewAction = [
    {
      'title': 'Add New Sale',
      'route': 'add_sale',
      'icon': Icons.add,
      'color': const Color(0xff003CFF),
      'value': 0,
      'isExternal': false
    },
    {
      'title': 'Your Wallet',
      'route': 'wallet',
      'icon': Icons.arrow_forward_ios,
      'color': const Color(0xff2F9803),
      'value': 2,
      'isExternal': true
    }
  ];

  static List<Map<String, dynamic>> discounts = [
    {
      'id': 1,
      'image':
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8RmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'appliedDiscount': false,
      'isChecked': false,
      'discount': ''
    },
    {
      'id': 2,
      'image':
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8RmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'appliedDiscount': false,
      'isChecked': false,
      'discount': ''
    },
    {
      'id': 3,
      'image':
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8RmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'appliedDiscount': false,
      'isChecked': false,
      'discount': ''
    },
  ];
  static String userSquareIcon = "assets/icons/user-square.png";
  static String userOctagonIcon = "assets/icons/user-octagon.png";
  static String awardIcon = "assets/icons/award.png";

  static List<Map<String, dynamic>> storeDetails = [
    {
      "title": "Store Link",
      "image": "assets/icons/global.png",
      "package": GlobalAppUtil.dukastaxPackageName,
      "lable": "",
      "showEdit": false,
      "showIcon": false,
    },
    {
      "title": "Store Name",
      "image": "assets/icons/shop-add.png",
      "package": GlobalAppUtil.dukastaxPackageName,
      "lable": "",
      "showEdit": true,
      "showIcon": false,
    },
    {
      "title": "Username & Description",
      "image": "assets/icons/firstline.png",
      "package": packageName,
      "lable": "",
      "showEdit": true,
      "showIcon": false,
    },
    {
      "title": "Store Logo",
      "image": "assets/icons/image.png",
      "package": packageName,
      "lable": "",
      "showEdit": true,
      "showIcon": false,
    },
    {
      "title": "Header Image",
      "image": "assets/icons/gallery.png",
      "package": packageName,
      "lable": "",
      "showEdit": true,
      "showIcon": false,
    },
  ];

  static List<Map<String, dynamic>> storePerformance = [
    {
      "title": "Transactions",
      "image": "assets/icons/transaction-minus.png",
      "package": packageName,
      "lable": "",
      "showEdit": false,
      "showIcon": true,
      "route": TransactionsPage.routeName,
      "color": StyleColors.lukhuGrey50,
    },
    {
      "title": "Analytics",
      "image": "assets/icons/transaction-minus.png",
      "package": packageName,
      "lable": "",
      "showIcon": true,
      "showEdit": false,
      "route": AnalyticsPage.routeName,
      "color": StyleColors.lukhuGrey50
    },
    {
      "title": "Expenses",
      "image": "assets/icons/transaction-minus.png",
      "package": packageName,
      "lable": "Upgrade",
      "showEdit": false,
      "showIcon": false,
      "route": "",
      "color": StyleColors.lukhuBlue,
    },
  ];

  static String addIcon = 'assets/icons/add-square.png';
  static String closeIcon = 'assets/images/close_button.png';
  static String uploadIcon = 'assets/icons/upload.png';
  static String graphIcon = 'assets/icons/graph.png';

  static List<Map<String, dynamic>> addresCategory = [
    {
      "title": "Home",
      "image": "assets/icons/home.png",
      "isSelected": false,
      "color": Colors.white,
    },
    {
      "title": "Office",
      "image": "assets/icons/buildings.png",
      "isSelected": false,
      "color": Colors.white,
    },
    {
      "title": "Other",
      "image": "assets/icons/more-circle.png",
      "isSelected": false,
      "color": Colors.white,
    }
  ];

  static List<Map<String, dynamic>> businessTools = [
    {
      "title": "Discounts",
      "image": "assets/icons/ticket-star.png",
      "package": packageName,
      "lable": "",
      "showIcon": true,
      "showEdit": false,
      "route": DiscountView.routeName,
    },
    {
      "title": "Photography Services",
      "image": "assets/icons/camera.png",
      "package": packageName,
      "lable": "",
      "showEdit": false,
      "showIcon": true,
      "route": "",
    },
    {
      "title": "Request Delivery",
      "image": "assets/images/truck_fast.png",
      "package": GlobalAppUtil.productListingPackageName,
      "lable": "",
      "showEdit": false,
      "showIcon": true,
      "route": "",
    },
    {
      "title": "StockUp",
      "image": "assets/icons/house.png",
      "package": packageName,
      "lable": "",
      "showEdit": false,
      "showIcon": true,
      "route": "",
    },
  ];

  static List<Map<String, dynamic>> services = [
    {"tite": "Store Details", "label": "View Website", "data": []},
    {
      "tite": "Store Performance",
      "label": "",
      "data": [
        {
          "title": "Header Image",
          "image": "assets/icons/gallery.png",
          "package": packageName,
          "lable": "",
          "showEdit": true,
        },
      ],
    }
  ];

  static String orderIcon = 'assets/images/orders.png';

  static List<Map<String, dynamic>> categories = [
    {
      'title': 'Products',
      'route': ProductView.routeName,
      'image': 'assets/images/products.png',
      'color': const Color(0xffFCE7EE),
      'isExternal': true,
      'value': 3,
    },
    {
      'title': 'Orders',
      'route': OrdersViewPage.routeName,
      'image': 'assets/images/orders.png',
      'color': const Color(0xffF0EFFF),
      'isExternal': true,
      'value': 1
    },
    {
      'title': 'Discounts',
      'route': DiscountView.routeName,
      'image': 'assets/images/receipt_discount.png',
      'color': const Color(0xffFFEDEA),
      'isExternal': false,
      'value': 0
    },
    {
      'title': 'Services',
      'route': ServicePage.routeName,
      'image': 'assets/images/services.png',
      'color': const Color(0xffEDECF0),
      'isExternal': true,
      'value': 4,
    },
  ];

  static String imageUrl =
      'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60';

  static List<Map<String, dynamic>> resources = [
    {
      'image':
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'title': 'Lukhu POS: Manage your biz even better on Lukhu',
      'route': '',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
    },
    {
      'image':
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'title': 'How to grow your Biz On Lukhu in 2023',
      'route': '',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
    },
    {
      'image':
          'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGZhc2hpb258ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
      'title': 'How to make more sales during Lukhu campaigns',
      'route': '',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
    },
    {
      'image':
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'title': 'Lukhu POS: Manage your biz even better on Lukhu',
      'route': '',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
    },
    {
      'image':
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'title': 'How to grow your Biz On Lukhu in 2023',
      'route': '',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text."
    },
  ];

  static List<Map<String, dynamic>> tips = [
    {
      'image':
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'description': 'Use photos and videos to express yourself when listing'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'description': 'Pick a captivating background to show off your item'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'description':
          'Take advantage of natural light when taking photos of items'
    },
    {
      'image':
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'description':
          'Show the details of your products to ensure the customer has all the required info before purchase.'
    },
  ];

  static final List<Map<String, dynamic>> orders = [
    {
      'title': 'New Order Alert 🥳',
      'time': '12:05 PM',
      'description':
          '@rey just ordered an item from your store! Tap to view more details',
      'image':
          'https://images.unsplash.com/photo-1603400521630-9f2de124b33b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzZ8fGZhc2hpb258ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
      'isRead': false,
      'type': DeliveryStatus.pending,
      'store': '@zenyeziko',
      'order_no': 'LO3084JFIEE',
      'illustration': [
        {
          'title': 'Your order has been confirmed',
          'time': '12:00 PM',
          'description':
              'Hang on as @zenyeziko ships your item to you. You will be notified once your order has been shipped.',
          'type': OrderType.confirmed
        },
        {
          'title': 'Your order has been shipped',
          'time': '12:00 PM',
          'description':
              'Hang on as our delivery agents get your item to you as fast as they can. You can track your order below.',
          'type': OrderType.shipping
        },
      ]
    },
    {
      'title': 'Order from @rey',
      'time': '12:05 PM',
      'description': 'Tap to view more details ',
      'image':
          'https://images.unsplash.com/photo-1603400521630-9f2de124b33b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzZ8fGZhc2hpb258ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
      'isRead': true,
      'type': DeliveryStatus.cancelled,
      'store': '@zenyeziko',
      'order_no': 'LO3084JFIEE',
      'illustration': [
        {
          'title': 'Your order has been confirmed',
          'time': '12:00 PM',
          'description':
              'Hang on as @zenyeziko ships your item to you. You will be notified once your order has been shipped.',
          'type': OrderType.confirmed
        },
        {
          'title': 'Your order has been shipped',
          'time': '12:00 PM',
          'description':
              'Hang on as our delivery agents get your item to you as fast as they can. You can track your order below.',
          'type': OrderType.shipping
        },
      ]
    },
  ];

  static Map<String, dynamic> productInfoData = {
    "category": ["Men", "Women", "Kids", "Unisex"],
    "condition": [
      "Thrift/Pre-loved",
      "New",
      "Made in Kenya - New",
      "Made in Kenya - Thrift"
    ],
    "sizes": ["Men", "Women", "Kids", "Unisex"]
  };

  ///Data
  static List<String> sizesLocales = [
    'UK Sizes',
    'EU Sizes',
    'US Sizes',
    'Inches'
  ];

  static List<Map<String, dynamic>> optionColors = [
    {"name": "Black", "color": Colors.black},
    {"name": "White", "color": Colors.white},
    {"name": "Red", "color": Colors.red},
    {"name": "Green", "color": Colors.green},
    {"name": "Blue", "color": Colors.blue},
    {"name": "Yellow", "color": Colors.yellow},
    {"name": "Orange", "color": Colors.orange},
    {"name": "Purple", "color": Colors.purple},
    {"name": "Grey", "color": Colors.grey},
    {"name": "Brown", "color": Colors.brown},
    {"name": "Pink", "color": Colors.pink},
    {"name": "Teal", "color": Colors.teal},
    {"name": "Cyan", "color": Colors.cyan},
    {"name": "Lime", "color": Colors.lime},
    {"name": "Indigo", "color": Colors.indigo},
    {"name": "Light Blue", "color": Colors.lightBlue},
    {"name": "Light Green", "color": Colors.lightGreen},
    {"name": "Amber", "color": Colors.amber},
    {"name": "Deep Orange", "color": Colors.deepOrange},
    {"name": "Deep Purple", "color": Colors.deepPurple},
    {"name": "Blue Grey", "color": Colors.blueGrey},
    {"name": "Tan", "color": Colors.brown[300]},
    {"name": "Gold", "color": Colors.amber[700]},
    {"name": "Silver", "color": Colors.grey[300]},
    {"name": "Bronze", "color": Colors.brown[700]},
    {"name": "Multi", "color": Colors.grey[300]},
    {"name": "Khaki", "color": const Color(0xff8A7F32)},
    {"name": "Navy", "color": const Color(0xff000080)},
    {"name": "Maroon", "color": const Color(0xff800000)},
    {"name": "Olive", "color": const Color(0xff808000)},
    {"name": "Burgundy", "color": const Color(0xff800020)},
    {"name": "Coral", "color": const Color(0xffFF7F50)},
    {"name": "Mint", "color": const Color(0xff98FB98)},
    {"name": "Lavender", "color": const Color(0xffE6E6FA)},
    {"name": "Beige", "color": const Color(0xffF5F5DC)},
    {"name": "Copper", "color": const Color(0xffB87333)},
    {"name": "Cream", "color": const Color(0xffFFFDD0)},
    {"name": "Lilac", "color": const Color(0xffC8A2C8)},
    {"name": "Turquoise", "color": const Color(0xff40E0D0)},
    {"name": "Rust", "color": const Color(0xffB7410E)},
    {"name": "Mauve", "color": const Color(0xffE0B0FF)},
    {"name": "Taupe", "color": const Color(0xff483C32)},
    {"name": "Wine", "color": const Color(0xff722F37)},
    {"name": "Charcoal", "color": const Color(0xff36454F)},
    {"name": "Aqua", "color": const Color(0xff00FFFF)},
    {"name": "Lime", "color": const Color(0xff00FF00)},
    {"name": "Magenta", "color": const Color(0xffFF00FF)},
    {"name": "Crimson", "color": const Color(0xffDC143C)},
    {"name": "Fuchsia", "color": const Color(0xffFF00FF)},
    {"name": "Wheat", "color": const Color(0xffF5DEB3)},
    {"name": "Plum", "color": const Color(0xffDDA0DD)},
  ];

  static Map<String, Map<String, List<String>>> get localeSizes => {
        'Tops': {
          sizesLocales[0]:
              2.upTo(30, stepSize: 2).map((e) => e.toString()).toList(),
          sizesLocales[1]:
              30.upTo(58, stepSize: 2).map((e) => e.toString()).toList(),
          sizesLocales[2]:
              0.upTo(26, stepSize: 2).map((e) => e.toString()).toList(),
          sizesLocales[3]:
              2.upTo(75, stepSize: 2).map((e) => e.toString()).toList(),
        },
        'Bottoms': {
          sizesLocales[0]:
              4.upTo(26, stepSize: 2).map((e) => e.toString()).toList(),
          sizesLocales[1]:
              32.upTo(54, stepSize: 2).map((e) => e.toString()).toList(),
          sizesLocales[2]:
              0.upTo(22, stepSize: 2).map((e) => e.toString()).toList(),
          sizesLocales[3]:
              2.upTo(75, stepSize: 2).map((e) => e.toString()).toList(),
        },
        'Shoes': {
          sizesLocales[0]:
              2.upTo(9, stepSize: 1).map((e) => e.toString()).toList(),
          sizesLocales[1]:
              35.upTo(42, stepSize: 1).map((e) => e.toString()).toList(),
          sizesLocales[2]:
              4.upTo(11, stepSize: 1).map((e) => e.toString()).toList(),
          // sizesLocales[3]:
          //     2.upTo(75, stepSize: 2).map((e) => e.toString()).toList(),
        },
        'Dresses': {
          sizesLocales[0]:
              2.upTo(30, stepSize: 2).map((e) => e.toString()).toList(),
          sizesLocales[1]:
              30.upTo(58, stepSize: 2).map((e) => e.toString()).toList(),
          sizesLocales[2]:
              0.upTo(26, stepSize: 2).map((e) => e.toString()).toList(),
          // sizesLocales[3]:
          //     2.upTo(75, stepSize: 2).map((e) => e.toString()).toList(),
        },
      };

  static String authPluginName = 'auth_plugin';
}
