import 'package:flutter/material.dart';
import 'package:appwidgets/src/pages/alert_page.dart';
import 'package:appwidgets/src/pages/animated_container.dart';
import 'package:appwidgets/src/pages/avatar_page.dart';
import 'package:appwidgets/src/pages/card_page.dart';
import 'package:appwidgets/src/pages/home_page.dart';
import 'package:appwidgets/src/pages/inputs_page.dart';
import 'package:appwidgets/src/pages/listview_page.dart';
import 'package:appwidgets/src/pages/slider_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'animatedContainer': (BuildContext context) => AnimatedContainerPage(),
    'inputs': (BuildContext context) => InputsPage(),
    'sliderPage': (BuildContext context) => SliderPage(),
    'listPage': (BuildContext context) => ListViewPage(),
  };
}
