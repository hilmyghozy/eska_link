import 'dart:developer';

import 'package:eska_link/components/default_app_bar.dart';
import 'package:eska_link/components/default_widget_container.dart';
import 'package:eska_link/homepage/hompage_controller.dart';
import 'package:eska_link/utils/v_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  final ctrl = Get.put(HomepageController());

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultWidgetContainer(
        context,
        defaultAppBar(context, 'Eska Link'),
        Container(
          color: VColor.white,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'User',
                          style: TextStyle(
                              color: VColor.primaryGreen,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                        InkWell(
                          onTap: () {
                            ctrl.cancelEdit();
                          },
                          child: Container(
                            color: VColor.primaryGold,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: const Text('Cancel Edit'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.mediaQuerySize.width / 2.3,
                          child: TextFormField(
                            controller: ctrl.nikTC,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Nik',
                              labelStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.mediaQuerySize.width / 2.3,
                          child: TextFormField(
                            controller: ctrl.namaTC,
                            decoration: const InputDecoration(
                              labelText: 'Nama',
                              labelStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.mediaQuerySize.width / 2.3,
                          child: TextFormField(
                            controller: ctrl.umurTC,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Umur',
                              labelStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.mediaQuerySize.width / 2.3,
                          child: TextFormField(
                            controller: ctrl.kotaTC,
                            decoration: const InputDecoration(
                              labelText: 'Kota',
                              labelStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(() {
                    return ctrl.listnerType.value == ListenerTypes.create
                        ? InkWell(
                            onTap: () {
                              log('Save');
                              ctrl.createUser();
                            },
                            child: Container(
                              color: VColor.primaryGreen,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              width: context.mediaQuerySize.width / 2,
                              child: const Text(
                                'Save',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: VColor.white,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              ctrl.updateUser(ctrl.userId.value);
                            },
                            child: Container(
                              color: VColor.primaryGreen,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              width: context.mediaQuerySize.width / 2,
                              child: const Text(
                                'Edit',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: VColor.white,
                                ),
                              ),
                            ),
                          );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                'Nik',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                'Nama (Umur)',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              child: Center(
                            child: Text(
                              'Kota',
                            ),
                          )),
                        ),
                        Expanded(
                          child: SizedBox(
                              child: Center(
                            child: Text(
                              'Action',
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: VColor.textBlack,
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: Obx(
                    () => ListView.separated(
                      primary: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      itemCount: ctrl.userDB.length,
                      itemBuilder: (c, i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ctrl.userDB[i].nik),
                            Text(
                                '${ctrl.userDB[i].nama} (${ctrl.userDB[i].umur})'),
                            Text(ctrl.userDB[i].kota),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    log('edit ${ctrl.userDB[i].id}');
                                    ctrl.editOnTap(
                                      ctrl.userDB[i].id,
                                      ctrl.userDB[i].nik,
                                      ctrl.userDB[i].nama,
                                      ctrl.userDB[i].umur,
                                      ctrl.userDB[i].kota,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: VColor.primaryGreen,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    ctrl.deleteUser(ctrl.userDB[i].id);
                                    log('delete $i');
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: VColor.red,
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: VColor.mediumGreen,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        safeArea: true);
  }
}
