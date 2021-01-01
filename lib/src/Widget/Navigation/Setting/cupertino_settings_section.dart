import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'colors.dart';

class CupertinoSettingsSection extends StatelessWidget {
  const CupertinoSettingsSection(
    this.items, {
    this.header,
    this.footer,
  }) : assert(items != null);

  final List<Widget> items;

  final Widget header;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnChildren = [];
    if (header != null) {
      columnChildren.add(DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.inactiveGray,
          fontSize: 13.5,
          letterSpacing: -0.5,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            bottom: 6.0,
          ),
          child: header,
        ),
      ));
    }

    List<Widget> itemsWithDividers = [];
    for (int i = 0; i < items.length; i++) {
      final leftPadding =
          (items[i] as SettingsTile).leading == null ? 15.0 : 54.0;
      if (i < items.length - 1) {
        itemsWithDividers.add(items[i]);
        itemsWithDividers.add(Divider(
          height: 0.3,
          indent: leftPadding,
        ));
      } else {
        itemsWithDividers.add(items[i]);
      }
    }

    columnChildren.add(
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(1)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0xFF003142),
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF143642), Color(0xFF26667d)],
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: itemsWithDividers,
        ),
      ),
    );

    if (footer != null) {
      columnChildren.add(DefaultTextStyle(
        style: TextStyle(
          color: groupSubtitle,
          fontSize: 13.0,
          letterSpacing: -0.08,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 7.5,
          ),
          child: footer,
        ),
      ));
    }

    return Padding(
      padding: EdgeInsets.only(
        top: header == null ? 35.0 : 22.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }
}
