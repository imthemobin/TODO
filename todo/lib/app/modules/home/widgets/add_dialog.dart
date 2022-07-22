import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeCrtl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=> false ,
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: homeCrtl.formKey,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(3.0.wp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                            homeCrtl.editCtrl.clear();
                            homeCrtl.changeTask(null);
                          },
                          icon: const Icon(Icons.close)),
                      TextButton(
                          onPressed: () {
                            if (homeCrtl.formKey.currentState!.validate()) {
                              if (homeCrtl.task.value == null) {
                                EasyLoading.showError('Please select task type'.tr);
                              } else {
                                var succes = homeCrtl.updateTask(
                                  homeCrtl.task.value!,
                                  homeCrtl.editCtrl.text,
                                );
                                if (succes) {
                                  EasyLoading.showSuccess(
                                      'Todo iteam add success'.tr);
                                  Get.back();
                                  homeCrtl.changeTask(null);
                                } else {
                                  EasyLoading.showError(
                                      'Todo iteam alrady exist'.tr);
                                }
                                homeCrtl.editCtrl.clear();
                              }
                            }
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            'Done'.tr,
                            style: TextStyle(
                              fontSize: 14.0.sp,
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: Text(
                    'New Task'.tr,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: TextFormField(
                    controller: homeCrtl.editCtrl,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!)),
                    ),
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your todo item'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.0.wp,
                    right: 5.0.wp,
                    left: 5.0.wp,
                    bottom: 2.0.wp,
                  ),
                  child: Text(
                    'Add to: '.tr,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...homeCrtl.tasks
                    .map((element) => Obx(
                          () => InkWell(
                            onTap: () => homeCrtl.changeTask(element),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.0.wp, horizontal: 5.0.wp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        IconData(element.icon,
                                            fontFamily: 'MaterialIcons'),
                                        color: HexColor.fromHex(element.color),
                                      ),
                                      SizedBox(
                                        width: 3.0.wp,
                                      ),
                                      Text(
                                        element.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (homeCrtl.task.value == element)
                                    const Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
