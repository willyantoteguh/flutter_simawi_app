import 'dart:math';

import 'package:age_calculator/age_calculator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simawi_app/presentation/widgets/custom_appbar.dart';
import 'package:flutter_simawi_app/presentation/widgets/primary_button.dart';
import 'package:intl/intl.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';
import '../../data/database/database_instance.dart';
import '../../data/model/patient.dart';
import '../widgets/custom_textfield.dart';

class PatientRegistration extends StatefulWidget {
  final bool isUpdateScreen;

  const PatientRegistration({
    super.key,
    this.isUpdateScreen = false,
  });

  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  late Patient? patient;

  final fullNameController = TextEditingController();
  final birthController = TextEditingController();
  final nikController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  bool isUpdateScreen = false;

  var _genderSelectedValue;
  var selectedDate;
  var _selectedBloodTypeValue;

  late DateDuration _dateDuration;

  List<String> bloodTypes = ["A", "B", "AB", "O"];

  @override
  void initState() {
    super.initState();
    databaseInstance.database();

    isUpdateScreen = widget.isUpdateScreen;

    if (isUpdateScreen) {
      debugPrint("isUpdateScreen yah");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, label: "Patient Registration"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Full name", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              CustomTextField(
                hintText: "Enter Full name",
                controller: fullNameController,
                onChanged: (v) {},
              ),
              SizedBox(height: 14.h),
              Text("NIK", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              CustomTextField(
                hintText: "Enter NIK",
                controller: nikController,
                onChanged: (v) {},
              ),
              SizedBox(height: 14.h),
              Text("Birth", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          1960), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    debugPrint(pickedDate
                        .toString()); //get the picked date in the format => 2022-07-04 00:00:00.000
                    String formattedDate = DateFormat('dd-MM-yyyy').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                    DateTime formatAge = pickedDate;

                    debugPrint(
                        formattedDate); //formatted date output using intl package =>  2022-07-04
                    //You can format date as per your need

                    setState(() {
                      selectedDate = formattedDate;
                      birthController.text = selectedDate;
                      // age = formatAge;

                      _dateDuration = AgeCalculator.age(formatAge);
                      ageController.text = _dateDuration.years.toString();
                      debugPrint("_dateDuration: $_dateDuration ");
                    });
                  } else {
                    debugPrint("Date is not selected");
                  }
                },
                child: SizedBox(
                  child: CustomTextField(
                    readOnly: false,
                    hintText:
                        "Example: ${DateFormat('dd-MM-yyyy').format(DateTime(1985, 7, 1))}",
                    controller: birthController,
                    onChanged: (v) {},
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gender", style: BaseText.blackText14),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildRadioTile(
                            label: "Male",
                            value: 1,
                            groupValue: _genderSelectedValue,
                            onChanged: (value) {
                              setState(() {
                                _genderSelectedValue =
                                    int.parse(value.toString());
                              });
                            },
                          ),
                          buildRadioTile(
                            label: "Female",
                            value: 2,
                            groupValue: _genderSelectedValue,
                            onChanged: (value) {
                              setState(() {
                                _genderSelectedValue =
                                    int.parse(value.toString());
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Age", style: BaseText.blackText14),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: ScreenUtil().screenWidth / 2,
                        child: CustomTextField(
                          readOnly: false,
                          hintText: "Your Age",
                          controller: ageController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Text("Phone", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              CustomTextField(
                hintText: "Enter Phone Number",
                controller: phoneController,
                onChanged: (v) {},
              ),
              SizedBox(height: 14.h),
              Text("Address", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              CustomTextField(
                hintText: "Enter Address",
                controller: addressController,
                isTextArea: true,
                onChanged: (v) {},
              ),
              SizedBox(height: 14.h),
              Text("Blood Type", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRadioTile(
                    label: "A",
                    value: 1,
                    groupValue: _selectedBloodTypeValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedBloodTypeValue = int.parse(value.toString());
                      });
                    },
                  ),
                  SizedBox(width: 6.w),
                  buildRadioTile(
                    label: "B",
                    value: 2,
                    groupValue: _selectedBloodTypeValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedBloodTypeValue = int.parse(value.toString());
                      });
                    },
                  ),
                  SizedBox(width: 6.w),
                  buildRadioTile(
                    label: "AB",
                    value: 3,
                    groupValue: _selectedBloodTypeValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedBloodTypeValue = int.parse(value.toString());
                      });
                    },
                  ),
                  SizedBox(width: 6.w),
                  buildRadioTile(
                    label: "O",
                    value: 4,
                    groupValue: _selectedBloodTypeValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedBloodTypeValue = int.parse(value.toString());
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Weight", style: BaseText.blackText14),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: ScreenUtil().screenWidth / 2.4,
                        child: CustomTextField(
                          hintText: "Enter Weight",
                          controller: weightController,
                          onChanged: (v) {},
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Height", style: BaseText.blackText14),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: ScreenUtil().screenWidth / 2.4,
                        child: CustomTextField(
                          hintText: "Enter Height",
                          controller: heightController,
                          onChanged: (v) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 46.h),
              PrimaryButton(
                height: 45.h,
                title: "Register",
                onPressed: () async {
                  patient = Patient(
                    id: 1,
                    recordNumber: Random().nextInt(1000),
                    name: fullNameController.text,
                    birth: birthController.text,
                    age: double.parse(ageController.text),
                    nik: nikController.text,
                    gender: _genderSelectedValue,
                    phone: phoneController.text,
                    address: addressController.text,
                    bloodType: _selectedBloodTypeValue.toString(),
                    // weight: double.parse(weightController.text),
                    // height: double.parse(heightController.text),
                    createdAt: DateTime.now().toString(),
                    updatedAt: DateTime.now().toString(),
                  );

                  debugPrint(patient!.toMap().toString());

                  int idInsert = await databaseInstance.insertPatient({
                    'idPatient': 1,
                    'recordNumber': Random().nextInt(1000),
                    'namePatient': fullNameController.text,
                    'birth': birthController.text,
                    'age': ageController.text,
                    'nik': nikController.text,
                    'gender': _genderSelectedValue,
                    'phone': phoneController.text,
                    'address': addressController.text,
                    'bloodType': _selectedBloodTypeValue.toString(),
                    'createdAtPatient': DateTime.now().toString(),
                    'updatedAtPatient': DateTime.now().toString(),
                  });
                  debugPrint("Success : $idInsert");
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  Row buildRadioTile({
    required dynamic groupValue,
    required int value,
    void Function(Object? v)? onChanged,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          groupValue: groupValue,
          value: value,
          visualDensity: VisualDensity.compact,
          activeColor: ColorName.mainColor,
          onChanged: onChanged,
        ),
        Text(label, style: BaseText.blackText12),
      ],
    );
  }
}


// Unused dropdown
// ClipRRect(
//                 borderRadius: BorderRadius.circular(13.r),
//                 child: SizedBox(
//                   width: 202.w,
//                   child: DropdownButtonFormField2<String>(
//                     isExpanded: true,
//                     decoration: InputDecoration(
//                       fillColor: ColorName.accentColor,
//                       filled: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 10.h),
//                       border: InputBorder.none,
//                     ),
//                     alignment: Alignment.centerLeft,
//                     hint: Text(
//                       'Select Blood Type',
//                       style: BaseText.subText12.copyWith(
//                         fontWeight: FontWeight.w300,
//                         color: ColorName.activeTextColor,
//                       ),
//                     ),
//                     items: bloodTypes
//                         .map((item) => DropdownMenuItem<String>(
//                               value: item,
//                               child: Container(
//                                 alignment: AlignmentDirectional.centerStart,
//                                 child: Text(
//                                   item,
//                                   style: BaseText.mainText12.copyWith(
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ))
//                         .toList(),
//                     validator: (value) {
//                       if (value == null) {
//                         return 'Please select blood type.';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       //Do something when selected item is changed.
//                     },
//                     onSaved: (value) {
//                       selectedBloodType = value.toString();
//                     },
//                     buttonStyleData: const ButtonStyleData(
//                       padding: EdgeInsets.only(right: 8),
//                     ),
//                     iconStyleData: const IconStyleData(
//                       icon: Icon(
//                         Icons.keyboard_arrow_down,
//                         color: ColorName.activeTextColor,
//                       ),
//                       iconSize: 24,
//                     ),
//                     dropdownStyleData: DropdownStyleData(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.r),
//                         // color: ColorName.grey1Color,
//                       ),
//                       // direction: DropdownDirection.right,
//                     ),
//                     menuItemStyleData: const MenuItemStyleData(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                     ),
//                   ),
//                 ),
//               ),