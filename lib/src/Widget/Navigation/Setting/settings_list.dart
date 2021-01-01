import 'package:flutter/material.dart';
import 'package:exam_schedule/src/Widget/Navigation/Setting/abstract_section.dart';
import 'package:exam_schedule/src/Widget/Navigation/Setting/colors.dart';
import 'package:exam_schedule/src/Widget/Navigation/Setting/settings_section.dart';

class SettingsList extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final List<AbstractSection> sections;

  const SettingsList({
    Key key,
    this.sections,
    this.physics,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemCount: sections.length,
        itemBuilder: (context, index) {
          AbstractSection current = sections[index];
          AbstractSection futureOne;
          try {
            futureOne = sections[index + 1];
          } catch (e) {}

          // Add divider if title is null
          if (futureOne != null && futureOne.title != null) {
            current.showBottomDivider = false;
            return current;
          } else {
            current.showBottomDivider = true;
            return current;
          }
        },
      ),
    );
  }
}
