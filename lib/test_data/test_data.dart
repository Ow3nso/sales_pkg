import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show FilterType;

class TestData {
  static const userAVatar =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60';

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
    },
    {
      'title': 'Your Wallet',
      'route': 'wallet',
      'icon': Icons.arrow_forward_ios,
      'color': const Color(0xff2F9803)
    }
  ];

  static List<Map<String, dynamic>> categories = [
    {
      'title': 'Products',
      'route': 'products',
      'image': 'assets/images/products.png',
      'color': const Color(0xffFCE7EE)
    },
    {
      'title': 'Orders',
      'route': 'orders',
      'image': 'assets/images/orders.png',
      'color': const Color(0xffF0EFFF)
    },
    {
      'title': 'Discounts',
      'route': 'discounts',
      'image': 'assets/images/receipt_discount.png',
      'color': const Color(0xffFFEDEA)
    },
    {
      'title': 'Services',
      'route': 'services',
      'image': 'assets/images/services.png',
      'color': const Color(0xffEDECF0)
    },
  ];

  static List<Map<String, dynamic>> resources = [
    {
      'image':
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'description': 'Lukhu POS: Manage your biz even better on Lukhu',
      'route': ''
    },
    {
      'image':
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'description': 'How to grow your Biz On Lukhu in 2023',
      'route': ''
    },
    {
      'image':
          'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGZhc2hpb258ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
      'description': 'How to make more sales during Lukhu campaigns',
      'route': ''
    },
    {
      'image':
          'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      'description': 'Lukhu POS: Manage your biz even better on Lukhu',
      'route': ''
    },
    {
      'image':
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      'description': 'How to grow your Biz On Lukhu in 2023',
      'route': ''
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

  static List<Map<String, dynamic>> productManageOptions = [
    {
      'name': 'Set a discount',
      'value': '',
      'type': FilterType.setDiscount,
      'options': []
    },
    {
      'name': 'Mark as sold',
      'value': '',
      'type': FilterType.markAsSold,
      'options': []
    },
    {
      'name': 'Duplicate product',
      'value': '',
      'type': FilterType.dulicateProduct,
      'options': []
    },
  ];

  static List<Map<String, dynamic>> filterColors = [
    {'name': 'Red', 'value': Colors.red},
    {'name': 'Yellow', 'value': Colors.yellow},
    {'name': 'Green', 'value': Colors.green},
    {'name': 'Blue', 'value': Colors.blue},
  ];
  Map data = {
    'Red': Colors.red,
    'Yellow': Colors.yellow,
    'White': Colors.white,
    'Gray': Colors.grey,
    'Black': Colors.black,
    'Brown': Colors.brown,
    'Blue': const Color(0xff5185F8),
    'Cream': const Color(0xffEFE6B8),
    'Tan': const Color(0xffE8BD87),
    'Khaki': const Color(0xff8A7F32),
    'Navy': const Color(0xff0A2452),
    'Green': Colors.green,
    'Burgundy': const Color(0xff8F1C16),
    'Silver': const Color(0xffC0C0C0)
  };
}
