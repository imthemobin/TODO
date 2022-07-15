import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/modules/home/widgets/add_card.dart';
import 'package:todo/app/modules/home/widgets/task_card.dart';


class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: ListView(children: [
        Padding(
          padding:  EdgeInsets.all(4.0.wp),
          child: Text("My List",
            style: TextStyle(
              fontSize: 24.0.sp,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Obx(() => GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...controller.tasks.map((element) => TaskCard(task: element),).toList(),
              AddCard()],
            ),
        )
      ],))
    );
  }
}
