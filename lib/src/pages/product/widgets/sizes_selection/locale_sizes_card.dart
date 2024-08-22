import 'package:flutter/material.dart';
import 'package:lukhu_packages_pkg/lukhu_packages_pkg.dart' show StyleColors;
import 'package:sales_pkg/src/utils/styles/app_util.dart';

class LocaleSizesCard extends StatelessWidget {
  const LocaleSizesCard(
      {Key? key, required this.onLocaleChange, required this.selectedLocale})
      : super(key: key);
  final void Function(String) onLocaleChange;
  final String selectedLocale;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          ...List.generate(
              _localeCount,
              (i) => LocaleCard(
                  borderRadius: _firstItem(i) || _lastItem(i)
                      ? BorderRadius.only(
                          topLeft: Radius.circular(_firstItem(i) ? 7 : 0),
                          bottomLeft: Radius.circular(_firstItem(i) ? 7 : 0),
                          topRight: Radius.circular(_lastItem(i) ? 7 : 0),
                          bottomRight: Radius.circular(_lastItem(i) ? 7 : 0))
                      : null,
                  onLocaleChange: onLocaleChange,
                  active: AppUtil.sizesLocales[i] == selectedLocale,
                  locale: AppUtil.sizesLocales[i]))
        ],
      ),
    );
  }

  bool _lastItem(int i) => i == (_localeCount - 1);

  bool _firstItem(int i) => i == 0;

  int get _localeCount => AppUtil.sizesLocales.length;
}

class LocaleCard extends StatelessWidget {
  const LocaleCard(
      {super.key,
      required this.onLocaleChange,
      required this.locale,
      this.active = false,
      this.borderRadius});
  final void Function(String) onLocaleChange;
  final String locale;
  final bool active;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: active
              ? StyleColors.lukhuDark1
              : StyleColors.greyWeak,
          border: Border.all(width: 0.5)),
      child: InkWell(
        onTap: () => onLocaleChange(locale),
        child: Center(
          child: Text(
            locale,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: active ? Colors.white : StyleColors.lukhuDark1),
          ),
        ),
      ),
    ));
  }
}
