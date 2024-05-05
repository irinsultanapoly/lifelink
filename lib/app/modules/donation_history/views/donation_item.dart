// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:lifelink/app/data/models/models.dart';
import 'package:lifelink/app/services/db_service.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

const kAddressCardItemCornerRadius = 10.0;
const kAddressCardItemsPaddingV = 10.0;
const kAddressCardItemHeaderHeight = 35.0;

class DonationItem extends GetView {
  final cornerRadius = 10.0;

  final BloodRequest donation;
  final Function()? onTap;
  final Function()? onDefaultIconTap;
  final Function()? onEditIconTap;

  const DonationItem(
    this.donation, {
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
                                  donation.requestType,
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
                          child: CSText("donation_history_item_label_type".tr),
                        ),
                        const Expanded(
                          flex: 2,
                          child: CSText('PLATELET'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAddressCardItemsPaddingV),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: const CsIcon(Icons.shopping_bag_outlined),
                        ),
                        Expanded(
                          flex: 1,
                          child:
                              CSText("donation_history_item_label_quantity".tr),
                        ),
                        Expanded(
                          flex: 2,
                          child: CSText(
                            donation.amount.toString(),
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
                        Transform.scale(
                          scale: 0.9,
                          child: const CsIcon(Icons.bloodtype_outlined),
                        ),
                        Expanded(
                          flex: 1,
                          child: CSText("donation_history_item_label_group".tr),
                        ),
                        Expanded(
                          flex: 2,
                          child: CSText(donation.bloodGroup),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAddressCardItemsPaddingV),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: const CsIcon(Icons.tag_faces),
                        ),
                        Expanded(
                          flex: 1,
                          child: CSText(
                              "donation_history_item_label_seeker_name".tr),
                        ),
                        FutureBuilder<User?>(
                          future: Get.find<DbService>()
                              .findUserByMobile(donation.requesterId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show a loading indicator while fetching data
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Error: ${snapshot.error}'); // Show an error message if fetching data fails
                            } else {
                              final user = snapshot.data;
                              return Expanded(
                                flex: 2,
                                child: CSText(user?.name ??
                                    ''), // Display user name if available
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAddressCardItemsPaddingV),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: const CsIcon(Icons.local_hospital_outlined),
                        ),
                        Expanded(
                          flex: 1,
                          child:
                              CSText("donation_history_item_label_problem".tr),
                        ),
                        Expanded(
                          flex: 2,
                          child: CSText(donation.pProblem ?? ''),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAddressCardItemsPaddingV),
                    child: Row(
                      children: [
                        const CsIcon(Icons.location_on_outlined),
                        Expanded(
                          flex: 1,
                          child:
                              CSText("donation_history_item_label_address".tr),
                        ),
                        Expanded(
                          flex: 2,
                          child: CSText(donation.hospital ?? ""),
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
                            alignment: Alignment.centerRight,
                            child: CSText(
                              "${donation.donationDate} ${donation.donationTime}",
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
