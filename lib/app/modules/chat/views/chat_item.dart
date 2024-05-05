// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:lifelink/app/data/data_keys.dart';
import 'package:lifelink/app/data/models/models.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

const kAddressCardItemCornerRadius = 10.0;
const kAddressCardItemsPaddingV = 10.0;
const kAddressCardItemHeaderHeight = 35.0;

class ChatItem extends GetView {
  final cornerRadius = 10.0;

  final Message msg;
  final Function()? onTap;
  final Function()? onDefaultIconTap;
  final Function()? onEditIconTap;

  const ChatItem(
    this.msg, {
    super.key,
    this.onTap,
    this.onDefaultIconTap,
    this.onEditIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: CSCard(
                onTap: onTap,
                radius: cornerRadius,
                padding: EdgeInsets.zero,
                cardType: CSCardType.item,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: kAddressCardItemHeaderHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: (msg.senderId == GetStorage().read(kKeyUserId))
                              ? Get.theme.colorScheme.primary
                              : Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: kAddressCardItemsPaddingV),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CsIcon(
                                  null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: kAddressCardItemsPaddingV),
                              child: Align(
                                alignment: Alignment.center,
                                child: CSText(
                                  msg.message,
                                  color: (msg.senderId ==
                                          GetStorage().read(kKeyUserId))
                                      ? Get.theme.colorScheme.onPrimary
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CsIcon(
                              null,
                              onTap: onEditIconTap,
                              color: Get.theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
