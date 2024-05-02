import 'package:flutter/material.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center();
    // return CSHomeWidget(
    //   floatingActionButton: Padding(
    //     padding: const EdgeInsets.only(left: 30),
    //     child: Row(
    //       children: [
    //         if (controller.pos.value > 0)
    //           Expanded(
    //             child: CSButton(
    //               title: 'address_button_delete'.tr,
    //               onTap: () => controller.deleteAddress(),
    //               type: ButtonType.negative,
    //             ),
    //           ),
    //         if (controller.pos.value > 0) horizontalSpaceSmall,
    //         Expanded(
    //           child: CSButton(
    //             title: 'address_button_save'.tr,
    //             onTap: () => controller.saveAddress(),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
    //   child: Column(
    //     children: [
    //       CSHeader(
    //         title: 'address_title'.tr,
    //       ),
    //       verticalSpaceSmall,
    //       Expanded(
    //         child: ListView(
    //           children: [
    //             verticalSpaceRegular,
    //             Obx(
    //               () => CSInputField(
    //                 controller: controller.tcName,
    //                 placeholder: "address_label_name".tr,
    //                 inputType: TextInputType.name,
    //                 errorText: controller.errorName.isNotEmpty
    //                     ? controller.errorName.value
    //                     : null,
    //               ),
    //             ),
    //             verticalSpaceSmall,
    //             Obx(
    //               () => CSInputField(
    //                 controller: controller.tcMobile,
    //                 placeholder: "address_label_mobile".tr,
    //                 inputType: TextInputType.phone,
    //                 errorText: controller.errorMobile.isNotEmpty
    //                     ? controller.errorMobile.value
    //                     : null,
    //               ),
    //             ),
    //             verticalSpaceSmall,
    //             Obx(
    //               () => CSInputField(
    //                 controller: controller.tcAddressLine,
    //                 placeholder: "address_label_addressLine".tr,
    //                 inputType: TextInputType.streetAddress,
    //                 maxLines: 2,
    //                 errorText: controller.errorMobile.isNotEmpty
    //                     ? controller.errorMobile.value
    //                     : null,
    //               ),
    //             ),
    //             verticalSpaceSmall,
    //             Obx(
    //               () => CSDropDown(
    //                 controller.divisions.toList(),
    //                 header: "address_label_division".tr,
    //                 value: controller.selectedDivision.value,
    //                 onValueChange: controller.onDivisionChanged,
    //                 error: controller.errorDivision.value.isNotEmpty
    //                     ? controller.errorDivision.value
    //                     : null,
    //               ),
    //             ),
    //             verticalSpaceSmall,
    //             Obx(
    //               () => CSDropDown(
    //                 controller.cities.toList(),
    //                 header: "address_label_city".tr,
    //                 value: controller.selectedCity.value,
    //                 onValueChange: controller.onCityChanged,
    //                 error: controller.errorCity.value.isNotEmpty
    //                     ? controller.errorCity.value
    //                     : null,
    //               ),
    //             ),
    //             verticalSpaceSmall,
    //             Obx(
    //               () => CSDropDown(
    //                 controller.areas.toList(),
    //                 header: "address_label_area".tr,
    //                 value: controller.selectedArea.value,
    //                 onValueChange: controller.onAreaChanged,
    //                 error: controller.errorArea.value.isNotEmpty
    //                     ? controller.errorArea.value
    //                     : null,
    //               ),
    //             ),
    //             verticalSpaceRegular,
    //             Obx(
    //               () => CSInputField(
    //                 controller: controller.tcLabel,
    //                 placeholder: "address_label_label".tr,
    //                 inputType: TextInputType.text,
    //                 errorText: controller.errorMobile.isNotEmpty
    //                     ? controller.errorMobile.value
    //                     : null,
    //               ),
    //             ),
    //             verticalSpaceSmall,
    //             Obx(
    //               () => CsCheckbox(
    //                 controller.isDefault.value,
    //                 controller.onDefaultCheck,
    //                 title: 'address_label_make_default'.tr,
    //               ),
    //             ),
    //             verticalSpaceLarge,
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
