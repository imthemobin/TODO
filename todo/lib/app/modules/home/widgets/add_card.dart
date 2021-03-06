import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcon();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: (() async {
          Get.defaultDialog(
            // fix bug when kybord up Error
              contentPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              title: 'Task Type'.tr,
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              content: Form(
                  key: homeCtrl.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                        child: TextFormField(
                          controller: homeCtrl.editCtrl,
                          decoration: InputDecoration(
                              labelText: 'Title'.tr, border: const OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter yout task title'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                        child: Wrap(
                          spacing: 2.0.wp,
                          children: icons
                              .map((e) => Obx(() {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      selectedColor: Colors.grey[200],
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homeCtrl.chipIndex.value == index,
                                      onSelected: (bool selected) {
                                        homeCtrl.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                    );
                                  }))
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(150, 40),
                          ),
                          onPressed: () {
                            if (homeCtrl.formKey.currentState!.validate()) {
                              int icon = icons[homeCtrl.chipIndex.value]
                                  .icon!
                                  .codePoint;
                              String color = icons[homeCtrl.chipIndex.value]
                                  .color!
                                  .toHex();
                              var task = Task(
                                title: homeCtrl.editCtrl.text,
                                icon: icon,
                                color: color,
                              );
                              Get.back();
                              homeCtrl.addTask(task)
                                  ? EasyLoading.showSuccess('Create sucess'.tr)
                                  : EasyLoading.showError('Duplicated Task'.tr);
                            }
                          },
                          child: Text('confirm'.tr))
                    ],
                  )));
          homeCtrl.editCtrl.clear();
          homeCtrl.changeChipIndex(0);
        }),
        child: DottedBorder(
          strokeWidth: 1.2,
            color: Colors.grey[400]!,
            dashPattern: const [8, 4],
            child: Center(
              child: Icon(
                Icons.add,
                size: 10.0.wp,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
