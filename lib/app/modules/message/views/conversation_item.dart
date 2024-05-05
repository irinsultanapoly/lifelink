// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:lifelink/app/data/models/models.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

const kAddressCardItemCornerRadius = 10.0;
const kAddressCardItemsPaddingV = 10.0;
const kAddressCardItemHeaderHeight = 35.0;

class ConversationItem extends GetView {
  final cornerRadius = 10.0;

  final Conversation conversation;
  final Function()? onTap;
  final Function()? onDefaultIconTap;
  final Function()? onEditIconTap;

  const ConversationItem(
    this.conversation, {
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
                      decoration:
                          BoxDecoration(color: Get.theme.colorScheme.primary),
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
                                child: CSText.headline(
                                  conversation.id.toString(),
                                  color: Get.theme.colorScheme.onPrimary,
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
                  verticalSpaceSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAddressCardItemsPaddingV),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: const CsIcon(Icons.water_drop_outlined),
                        ),
                        Expanded(
                          flex: 1,
                          child: CSText("SenderID:"),
                        ),
                        Expanded(
                          flex: 2,
                          child: CSText(
                            conversation.requesterId,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAddressCardItemsPaddingV),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: CSText(
                              "${conversation.createdAt}",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceSmall,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
