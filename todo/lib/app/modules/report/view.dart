import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateTime = DateFormat.yMMMMd().format(DateTime.now());
    var dateTimeFa =
        '${DateTime.now().toJalali().year}/${DateTime.now().toJalali().month}/${DateTime.now().toJalali().day}';
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTasks = homeCtrl.getTotalTask();
          var completedTasks = homeCtrl.getTotalDoneTask();
          var liveTasks = createdTasks - completedTasks;
          var percent =
              (completedTasks / createdTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Text(
                  'My Report'.tr,
                  style:
                      TextStyle(fontSize: 22.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(
                  homeCtrl.isLangEN == true ? dateTime : dateTimeFa,
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.all(4.0.wp),
                    child: Image.asset('assets/images/report.png',scale: 1.5,),
                  )
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 4.0.wp),
                child: const Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 5.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTasks, 'Live Tasks'.tr),
                    _buildStatus(Colors.orange, completedTasks, 'Completed'.tr),
                    _buildStatus(Colors.blue, createdTasks, 'Created'.tr),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0.wp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  height: 70.0.wp,
                  width: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedColor: green,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (p0, p1) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${createdTasks == 0 ? 0 : percent} %",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0.sp),
                        ),
                        SizedBox(
                          height: 1.0.wp,
                        ),
                        Text(
                          'Efficiency'.tr,
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 0.5.wp, color: color)),
        ),
        SizedBox(
          width: 2.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
            ),
            SizedBox(
              height: 1.0.wp,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
            )
          ],
        )
      ],
    );
  }
}
