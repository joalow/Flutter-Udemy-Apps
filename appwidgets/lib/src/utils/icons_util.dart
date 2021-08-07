import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'add_alert': Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open': Icons.folder_open,
  'donut_large': Icons.donut_large,
  'input_icon': Icons.push_pin,
  'slider_icon': Icons.slideshow_rounded,
  'list_icon': Icons.list
};

Icon getIcon(String iconName) => Icon(
      _icons[iconName],
      color: Colors.blue,
    );
