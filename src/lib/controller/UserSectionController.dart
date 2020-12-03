import 'package:confnect/controller/Controller.dart';
import 'package:confnect/view/style/TextStyle.dart';
import 'package:confnect/view/widgets/GoBackButton.dart';
import 'package:confnect/view/widgets/MainPage/MainAppBar.dart';
import 'package:flutter/material.dart';

class UserSectionController {
  static List<Widget> initAppBars(
      List<Widget> action, Controller controller, Function refreshState) {
    return [
      MainAppBar(controller, action, controller.getDatabase(), refreshState)
          .getAppBar(),
      AppBar(
        title: Text(
          "Search",
          style: pageTitleTextStyle,
        ),
        actions: action,
      ),
      AppBar(
        title: Text(
          "Profile",
          style: pageTitleTextStyle,
        ),
        actions: action,
      ),
      AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            controller.currentForumId == -1
                ? 'Forums'
                : controller
                    .getDatabase()
                    .getForum(controller.getCurrentForumId())
                    .getTitle(),
            style: pageTitleTextStyle,
          ),
        ),
        actions: action,
        leading: controller.getCurrentForumId() == -1
            ? null
            : new GoBackButton(
                fn: () {
                  controller.setCurrentForumId(-1);
                  refreshState();
                },
                margin: EdgeInsets.only(top: 5.0, left: 10.0)),
      ),
    ];
  }
}
