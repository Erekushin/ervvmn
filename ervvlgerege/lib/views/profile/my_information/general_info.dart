import 'package:cached_network_image/cached_network_image.dart';
import 'package:ervvlgerege/Controllers/entrance.dart';
import 'package:ervvlgerege/Controllers/image.dart';
import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../MyWidgets/app/app_bar/appbar_simple.dart';
import '../../../MyWidgets/app/widget_combo.dart';
import '../../../MyWidgets/fundamental/buttons.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class GeneralInfo extends StatefulWidget {
  const GeneralInfo({Key? key}) : super(key: key);

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  var proCont = Get.find<ProC>();
  var authCont = Get.find<AuthC>();
  var imageCont = Get.find<ImageCont>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSimple(
        title: 'Хувийн мэдээлэл',
        backAction: () {},
        color: const Color(0xff464646),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  width: Sizes.width * .9,
                  height: 180,
                  child: InkWell(
                      onTap: () async {
                        await GlobalHelpers.imageHelper
                            .cameraAndGallery(context);
                        setState(() {
                          DefaultCacheManager().emptyCache();
                          imageCache.clear();
                          imageCache.clearLiveImages();
                        });
                      },
                      child: proPicu(
                          '${Addresses.mArea}file/?file=${proCont.userEntranceData.userInfo!.profilePicture}'))),
              input('Нэр', proCont.userEntranceData.userInfo!.username ?? '',
                  proCont.myName),
              input2(
                  'Танилцуулга',
                  proCont.userEntranceData.userInfo!.userInfo ?? '',
                  proCont.myDiscription),
              falseInput('Утас', proCont.userEntranceData.userInfo!.phone ?? '',
                  proCont.myPhone, () {
                authCont.utasShinechileh.value = true;
                Get.toNamed(RouteUnits.forgetpass,
                    arguments: proCont.userEntranceData.userInfo!.phone ?? '');
              }, 'Утас баталгаажаагүй байна', 2),
              falseInput(
                  'Email4',
                  proCont.userEntranceData.userInfo!.email ?? '',
                  proCont.myMail, () {
                authCont.emailShinechileh.value = true;
                Get.toNamed(RouteUnits.forgetpass,
                    arguments: proCont.userEntranceData.userInfo!.email ?? '');
              }, 'е-мэйл баталгаажисан байна.', 1),
              falseInput('Нууц үг', '**********', proCont.myPass, () {
                authCont.nuutsVgSergeehArgaSongoh.value = true;
                Get.toNamed(RouteUnits.forgetpass);
              }, '', 0),
              falseInput(
                  'Регистрийн дугаар',
                  proCont.userEntranceData.userInfo!.regNo ?? '',
                  proCont.myRd,
                  () {},
                  '',
                  0),
              const SizedBox(
                height: 10,
              ),
              greenInfoBtn('Эрүүл мэндийн мэдээлэл', () {
                Get.toNamed(RouteUnits.healthInfo);
              }),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Sizes.width * .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    generalBtn(Mcolors.geregeBlue, 'хадаглах', () {
                      proCont.generalInfo();
                    })
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget proPicu(String imgUrl) {
    return CachedNetworkImage(
        key: UniqueKey(),
        fit: BoxFit.cover,
        fadeInCurve: Curves.easeIn,
        errorWidget: (context, url, error) => Container(
              color: Colors.black12,
              child: const Icon(
                FontAwesomeIcons.x,
                color: Colors.white,
              ),
            ),
        progressIndicatorBuilder: ((context, url, progress) {
          return Container(
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),
          );
        }),
        width: Sizes.width * .9,
        imageUrl: imgUrl);
  }
}
