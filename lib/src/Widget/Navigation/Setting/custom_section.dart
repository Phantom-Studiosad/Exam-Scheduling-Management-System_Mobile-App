import 'package:flutter/material.dart';
import 'package:exam_schedule/src/Widget/Navigation/Setting/abstract_section.dart';

// ignore: must_be_immutable
class CustomSection extends AbstractSection {
  final Widget child;

  CustomSection({
    Key key,
    @required this.child,
  }) : super(key: key, title: null);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
