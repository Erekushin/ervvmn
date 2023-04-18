import 'package:ervvlgerege/Controllers/profile.dart';
import 'package:ervvlgerege/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/chat/conversations.dart';
import '../fundamental/text_heading.dart';

class ChatPartner extends StatefulWidget {
  const ChatPartner({super.key, required this.convItem});
  final EachConvM convItem;
  @override
  State<ChatPartner> createState() => _ChatPartnerState();
}

class _ChatPartnerState extends State<ChatPartner> {
  var proC = Get.find<ProC>();

  String partnerName = 'найз';
  String lastMsj = '';
  @override
  void initState() {
    super.initState();
    if (!widget.convItem.isGroup!) {
      for (int i = 0; i < widget.convItem.convManyUsers!.length; i++) {
        if (widget.convItem.convManyUsers![i].id != GlobalHelpers.myUserId) {
          partnerName = widget.convItem.convManyUsers![i].username!;
        }
      }
    }
    lastMsj =
        widget.convItem.msgs!.isEmpty ? '' : widget.convItem.msgs!.last.msg!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/avatar3.jpg',
                            ),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.1, -1.1),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Mcolors.medicalGreen),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    txtForm8(partnerName),
                    const SizedBox(
                      height: 5,
                    ),
                    txtForm11(lastMsj)
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                txtForm11('1 цаг'),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 7, right: 7, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Mcolors.medicalGreen,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: txtForm10('2'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
