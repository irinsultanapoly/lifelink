import 'package:super_ui_kit/super_ui_kit.dart';


class AddressController extends GetxController {
  // final DbService dbService = Get.find<DbService>();

  // final tcName = TextEditingController();
  // final tcMobile = TextEditingController();
  // final tcAddressLine = TextEditingController();
  // final tcLabel = TextEditingController();

  // final divisions = <String>[].obs;
  // final cities = <String>[].obs;
  // final areas = <String>[].obs;

  // final isDefault = false.obs;

  // final hasError = false.obs;
  // final errorName = ''.obs;
  // final errorMobile = ''.obs;
  // final errorAddressLine = ''.obs;
  // final errorDivision = ''.obs;
  // final errorCity = ''.obs;
  // final errorArea = ''.obs;

  // var selectedDivision = CSDropDown.kSelectionInstruction.obs;
  // var selectedCity = CSDropDown.kSelectionInstruction.obs;
  // var selectedArea = CSDropDown.kSelectionInstruction.obs;

  // final areaData = Rxn<AreaData?>();

  // final pos = 0.obs;

  // @override
  // void onInit() {
  //   areaData.bindStream(bindAreaData());
  //   super.onInit();
  //   tcName.addListener(() {
  //     errorName.value = '';
  //   });
  //   tcMobile.addListener(() {
  //     errorMobile.value = '';
  //   });
  //   tcAddressLine.addListener(() {
  //     errorAddressLine.value = '';
  //   });
  //   areaData.listen((areaData) => parseAreaData(areaData));
  // }

  // @override
  // void onClose() {
  //   tcName.dispose();
  //   tcMobile.dispose();
  //   tcLabel.dispose();
  //   tcAddressLine.dispose();
  //   super.onClose();
  // }

  // void onDivisionChanged(String? newValue) {
  //   selectedDivision.value = newValue ?? CSDropDown.kSelectionInstruction;
  //   if (newValue == null) return;
  //   if (newValue != CSDropDown.kSelectionInstruction &&
  //       newValue != CSDropDown.kOtherSelection) {
  //     getCities(newValue);
  //   }
  //   printInfo(info: newValue);
  // }

  // void onCityChanged(String? newValue) {
  //   selectedCity.value = newValue ?? CSDropDown.kSelectionInstruction;
  //   if (newValue == null) return;
  //   printInfo(info: newValue);
  //   if (newValue != CSDropDown.kSelectionInstruction &&
  //       newValue != CSDropDown.kOtherSelection) {
  //     getAreas(newValue);
  //   }
  // }

  // void onAreaChanged(String? newValue) {
  //   selectedArea.value = newValue ?? CSDropDown.kSelectionInstruction;
  //   printInfo(info: '$newValue');
  // }

  // saveAddress() {
  //   //Hide keyboard first
  //   hideKeyBoard();
  //   //Check inputted data
  //   validateFields();
  //   //Check if there is any validation error
  //   if (hasError.isTrue) return;
  //   var address = Address(
  //       name: tcName.text,
  //       mobile: tcMobile.text,
  //       addressLine: tcAddressLine.text,
  //       division: selectedDivision.value,
  //       city: selectedCity.value,
  //       area: selectedArea.value,
  //       label: (tcLabel.text.isNotEmpty) ? tcLabel.text : 'address_title'.tr,
  //       isDefault: isDefault.value);

  //   if (dbService.profile.value == null) return;
  //   if (pos < 1) {
  //     //New Insertion
  //     if (dbService.profile.value!.addressBook.isEmpty) {
  //       address.isDefault = true;
  //       dbService.realm?.write(
  //         () => dbService.profile.value?.addressBook.add(address),
  //       );
  //     } else {
  //       if (isDefault.isFalse) {
  //         dbService.realm?.write(
  //           () => dbService.profile.value?.addressBook.add(address),
  //         );
  //       } else {
  //         dbService.realm?.write(() {
  //           dbService.profile.value?.addressBook[0].isDefault = false;
  //           dbService.profile.value?.addressBook.insert(0, address);
  //         });
  //       }
  //     }
  //   } else {
  //     //Modify
  //     if (pos == 1) {
  //       //Modifying the default address. So force this as default.
  //       address.isDefault = true;
  //       dbService.realm?.write(
  //         () => dbService.profile.value?.addressBook[0] = address,
  //       );
  //     } else {
  //       if (isDefault.isFalse) {
  //         dbService.realm?.write(
  //           () => dbService.profile.value?.addressBook[pos - 1] = address,
  //         );
  //       } else {
  //         dbService.realm?.write(() {
  //           dbService.profile.value?.addressBook[0].isDefault = false;
  //           dbService.profile.value?.addressBook.removeAt(pos - 1);
  //           dbService.profile.value?.addressBook.insert(0, address);
  //         });
  //       }
  //     }
  //   }
  //   dbService.profile.refresh();
  //   Get.back();
  // }

  // void onDefaultCheck(bool? value) {
  //   if (value != null) {
  //     isDefault.value = value;
  //   }
  // }

  // void validateFields() {
  //   hasError.value = false;
  //   //Name
  //   if (!tcName.text.isValidName) {
  //     hasError.value = true;
  //     errorName.value = 'address_error_name'.tr;
  //   }
  //   //Mobile
  //   if (!tcMobile.text.isPhoneNumber) {
  //     hasError.value = true;
  //     errorMobile.value = 'address_error_mobile'.tr;
  //   }
  //   //AddressLine
  //   if (!tcAddressLine.text.isNotEmpty) {
  //     hasError.value = true;
  //     errorAddressLine.value = 'address_error_addressLine'.tr;
  //   }
  //   //Division
  //   printInfo(info: '${selectedDivision.value}  ${CSDropDown.kOtherSelection}');
  //   if (selectedDivision.value == CSDropDown.kSelectionInstruction ||
  //       selectedDivision.value == CSDropDown.kOtherSelection) {
  //     hasError.value = true;
  //     errorDivision.value = 'address_error_division'.tr;
  //   }
  //   //City
  //   if (selectedCity.value == CSDropDown.kSelectionInstruction ||
  //       selectedCity.value == CSDropDown.kOtherSelection) {
  //     hasError.value = true;
  //     errorCity.value = 'address_error_city'.tr;
  //   }
  //   //Area
  //   if (selectedArea.value == CSDropDown.kSelectionInstruction ||
  //       selectedArea.value == CSDropDown.kOtherSelection) {
  //     hasError.value = true;
  //     errorArea.value = 'address_error_area'.tr;
  //   }
  // }

  // void clearErrors() {
  //   errorName.value = '';
  //   errorMobile.value = '';
  //   errorAddressLine.value = '';
  //   hasError.value = false;
  // }

  // Stream<AreaData?> bindAreaData() {
  //   var areaResult = dbService.realm?.all<AreaData>();
  //   if (areaResult != null && areaResult.isNotEmpty) {
  //     var stream = areaResult.changes;
  //     printInfo(info: 'area:  ${areaResult.length}');
  //     return stream.map((event) => event.results.first);
  //   } else {
  //     return const Stream.empty();
  //   }
  // }

  // parseAreaData(AreaData? areaData) {
  //   if (areaData == null) return;
  //   divisions.value = areaData.divisions.map((div) => div.divName).toList();
  //   //Area data downloaded..
  //   bindAddress();
  // }

  // void getCities(String newValue) {
  //   if (areaData.value == null) return;
  //   //Clear selections first
  //   selectedCity.value = CSDropDown.kSelectionInstruction;
  //   selectedArea.value = CSDropDown.kSelectionInstruction;
  //   //Get data from main object
  //   cities.value = areaData.value?.divisions
  //           .firstWhere((element) => element.divName == newValue)
  //           .cities
  //           .map((city) => city.cityName)
  //           .toList() ??
  //       [];
  // }

  // void getAreas(String newValue) {
  //   if (areaData.value == null) return;
  //   //Clear selections first
  //   selectedArea.value = CSDropDown.kSelectionInstruction;
  //   //Get data from main object
  //   areas.value = areaData.value?.divisions
  //           .firstWhere((element) => element.divName == selectedDivision.value)
  //           .cities
  //           .firstWhere((element) => element.cityName == newValue)
  //           .areas
  //           .map((city) => city.areaName)
  //           .toList() ??
  //       [];
  // }

  // void bindAddress() {
  //   var pos = -1;
  //   if (pos > 0) {
  //     var address = dbService.profile.value!.addressBook[pos - 1];
  //     tcName.text = address.name;
  //     tcMobile.text = address.mobile;
  //     tcAddressLine.text = address.addressLine;
  //     tcLabel.text = address.label;
  //     isDefault.value = address.isDefault;

  //     //To avoid error check the value already exist
  //     if (!divisions.contains(address.division)) {
  //       divisions.add(address.division);
  //     }

  //     //Now make them selected
  //     selectedDivision.value = address.division;
  //     getCities(address.division);
  //     if (!cities.contains(address.city)) {
  //       cities.add(address.division);
  //     }
  //     selectedCity.value = address.city;
  //     getAreas(address.city);
  //     if (!areas.contains(address.area)) {
  //       areas.add(address.area);
  //     }
  //     selectedArea.value = address.area;
  //   }
  // }

  // deleteAddress() {
  //   dbService.realm?.write(() {
  //     dbService.profile.value?.addressBook.removeAt(pos.value - 1);
  //     if (pos.value == 1 &&
  //         (dbService.profile.value?.addressBook.isNotEmpty ?? false)) {
  //       dbService.profile.value?.addressBook[0].isDefault = true;
  //     }
  //   });
  //   dbService.profile.refresh();
  //   Get.back();
  // }
}
