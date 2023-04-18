import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/image.dart';
import '../../../Controllers/profile.dart';
import '../../../MyWidgets/app/app_bar/appbar_simple.dart';
import '../../../MyWidgets/app/widget_combo.dart';
import '../../../global_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ServiceInfo extends StatefulWidget {
  const ServiceInfo({super.key});

  @override
  State<ServiceInfo> createState() => _ServiceInfoState();
}

class _ServiceInfoState extends State<ServiceInfo> {
  var imageCont = Get.find<ImageCont>();
  var proCont = Get.find<ProC>();

  final argu = Get.arguments as int;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSimple(
        title: 'Үйлчилгээний мэдээлэл',
        backAction: () {},
        color: const Color(0xff464646),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              proCont.myServiceB.services![argu].image!))),
                  margin: const EdgeInsets.all(10),
                  width: Sizes.width * .9,
                  height: 180,
                  child: InkWell(
                    onTap: () async {
                      await GlobalHelpers.imageHelper.cameraAndGallery(context);
                      setState(() {
                        DefaultCacheManager().emptyCache();
                        imageCache.clear();
                        imageCache.clearLiveImages();
                      });
                    },
                  )),
              input('Нэр', proCont.myServiceB.services![argu].name!,
                  proCont.serviceName),
              input2(
                  'Танилцуулга',
                  proCont.myServiceB.services![argu].discription!,
                  proCont.serviceDiscription),
            ],
          ),
        ),
      ),
    );
  }
}
