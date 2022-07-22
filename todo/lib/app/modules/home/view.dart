import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/modules/home/widgets/add_card.dart';
import 'package:todo/app/modules/home/widgets/add_dialog.dart';
import 'package:todo/app/modules/home/widgets/task_card.dart';
import 'package:todo/app/modules/report/view.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(index: controller.tabIndex.value, children: [
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: Text(
                    "My List",
                    style: TextStyle(
                        fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...controller.tasks
                          .map(
                            (element) => LongPressDraggable(
                              data: element,
                              onDragStarted: () =>
                                  controller.changeDeleting(true),
                              onDraggableCanceled: (velocity, offset) =>
                                  controller.changeDeleting(false),
                              onDragEnd: (details) =>
                                  controller.changeDeleting(false),
                              feedback: Opacity(
                                opacity: 0.5,
                                child: TaskCard(task: element),
                              ),
                              child: TaskCard(task: element),
                            ),
                          )
                          .toList(),
                      AddCard()
                    ],
                  ),
                ),
              ],
            ),
          ),
           ReportPage(),
        ]),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) => Obx(
          () => FloatingActionButton(
            backgroundColor: controller.deleting.value ? Colors.red : blue,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(() => AddDialog(), transition: Transition.downToUp);
              } else {
                EasyLoading.showInfo('Please create your task');
              }
            },
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
          ),
        ),
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Deleting Succes');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: const Icon(Icons.apps),
                  )),
              BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: const Icon(Icons.data_usage),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
