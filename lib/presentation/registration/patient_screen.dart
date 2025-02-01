import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simawi_app/data/model/patient.dart';
import 'package:flutter_simawi_app/presentation/registration/patient_registration_screen.dart';
import 'package:flutter_simawi_app/presentation/widgets/custom_divider.dart';
import 'package:flutter_simawi_app/presentation/widgets/other_navigation.dart';
import 'package:intl/intl.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';
import '../../data/database/database_instance.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/delete_dialog.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  DatabaseInstance? databaseInstance;
  Future _refresh() async {
    setState(() {});
  }

  final TextEditingController _controller = TextEditingController();
  // final List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> _filteredData = [];
  bool isSearch = false;

  Future<void> _searchData(
      String query, List<Map<String, dynamic>> data) async {
    // Simulasi pengambilan data dari API atau database
    await Future.delayed(const Duration(seconds: 1));

    _filteredData = data
        .where((element) =>
            element['namePatient']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element['birth']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();

    log(_filteredData.map((e) => e).toList().toString());

    setState(() {
      isSearch = true;
    });
  }

  List<Map<String, dynamic>> listDoctors = [];
  var selectedDoctor;
  var selectedDateVisit;
  final TextEditingController dateVisitController = TextEditingController();

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Patient Data",
          style: BaseText.mainText18.copyWith(
            fontWeight: BaseText.semiBold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorName.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 4,
        toolbarHeight: 75,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: databaseInstance!.getAllPatient(),
              builder: (context, snapshot) {
                debugPrint("Result : ${snapshot.data}");

                Future.delayed(const Duration(seconds: 2), () async {
                  listDoctors = await databaseInstance!.getAllDoctor();
                  debugPrint(
                      "listDoctors: ${listDoctors.map((e) => e).toList().toString()}");
                });

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {
                                      var result = databaseInstance!
                                          .getAllPatient()
                                          .then((value) => _searchData(
                                              _controller.text, value));
                                    },
                                  ),
                                ),
                                onChanged: (v) => {
                                  if (v.isEmpty)
                                    {
                                      setState(() {
                                        isSearch = false;
                                      })
                                    }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  buildDivider(),
                              itemCount: (isSearch)
                                  ? _filteredData.length
                                  : snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var patients = (isSearch)
                                    ? _filteredData
                                    : snapshot.data ?? [];
                                var patient = patients[index];

                                return buildPatientTile(
                                    number: patient["idPatient"].toString(),
                                    name: patient["namePatient"],
                                    age: patient["age"],
                                    onEditTap: () {
                                      Patient patientToUpdate =
                                          Patient.fromMap(patient);

                                      navigateTo(
                                        context,
                                        PatientRegistration(
                                          isUpdateScreen: true,
                                          patient: patientToUpdate,
                                        ),
                                      ).then((value) => setState(() {}));
                                    },
                                    onDeleteTap: () => showAlertDialog(
                                          context,
                                          databaseInstance,
                                          setState,
                                          true,
                                          patient["idPatient"],
                                        ),
                                    onMoreTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          enableDrag: true,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w),
                                                child: SizedBox(
                                                  // height: ScreenUtil()
                                                  //         .screenHeight /
                                                  //     2,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 24.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Date Visit",
                                                              style: BaseText
                                                                  .blackText14),
                                                          SizedBox(height: 6.h),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              DateTime?
                                                                  pickedDate =
                                                                  await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(), //get today's date
                                                                      firstDate:
                                                                          DateTime(
                                                                              1960), //DateTime.now() - not to allow to choose before today.
                                                                      lastDate:
                                                                          DateTime(
                                                                              2101));

                                                              if (pickedDate !=
                                                                  null) {
                                                                debugPrint(
                                                                    pickedDate
                                                                        .toString()); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                                String
                                                                    formattedDate =
                                                                    DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                                                DateTime
                                                                    formatAge =
                                                                    pickedDate;

                                                                debugPrint(
                                                                    formattedDate); //formatted date output using intl package =>  2022-07-04
                                                                //You can format date as per your need

                                                                setState(() {
                                                                  selectedDateVisit =
                                                                      formattedDate;

                                                                  dateVisitController
                                                                          .text =
                                                                      selectedDateVisit;
                                                                  debugPrint(
                                                                      "selectedDateVisit: $selectedDateVisit ");
                                                                });
                                                              } else {
                                                                debugPrint(
                                                                    "Date is not selected");
                                                              }
                                                            },
                                                            child: SizedBox(
                                                              width: ScreenUtil()
                                                                      .screenWidth /
                                                                  1.6,
                                                              child:
                                                                  CustomTextField(
                                                                readOnly: false,
                                                                hintText:
                                                                    "Example: ${DateFormat('dd-MM-yyyy').format(DateTime(1985, 7, 1))}",
                                                                controller:
                                                                    dateVisitController,
                                                                onChanged:
                                                                    (v) {},
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 16.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Doctor:",
                                                              style: BaseText
                                                                  .blackText14),
                                                          // SizedBox(width: ,)
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.r),
                                                            child: SizedBox(
                                                              width: ScreenUtil()
                                                                      .screenWidth /
                                                                  1.6,
                                                              child:
                                                                  DropdownButtonFormField2<
                                                                      String>(
                                                                isExpanded:
                                                                    true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  fillColor:
                                                                      ColorName
                                                                          .accentColor,
                                                                  filled: true,
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          vertical:
                                                                              10.h),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                ),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                hint: Text(
                                                                  'Select Doctor',
                                                                  style: BaseText
                                                                      .blackText11
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: ColorName
                                                                        .activeTextColor,
                                                                  ),
                                                                ),
                                                                items:
                                                                    listDoctors
                                                                        .map((item) =>
                                                                            DropdownMenuItem<String>(
                                                                              value: item["name"],
                                                                              child: Container(
                                                                                alignment: AlignmentDirectional.centerStart,
                                                                                child: Text(
                                                                                  item["name"],
                                                                                  style: BaseText.mainText12.copyWith(
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList(),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      null) {
                                                                    return 'Please select blood type.';
                                                                  }
                                                                  return null;
                                                                },
                                                                onChanged:
                                                                    (value) {
                                                                  //Do something when selected item is changed.
                                                                },
                                                                onSaved:
                                                                    (value) {
                                                                  selectedDoctor =
                                                                      value
                                                                          .toString();
                                                                },
                                                                buttonStyleData:
                                                                    const ButtonStyleData(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              8),
                                                                ),
                                                                iconStyleData:
                                                                    const IconStyleData(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    color: ColorName
                                                                        .activeTextColor,
                                                                  ),
                                                                  iconSize: 24,
                                                                ),
                                                                dropdownStyleData:
                                                                    DropdownStyleData(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.r),
                                                                    // color: ColorName.grey1Color,
                                                                  ),
                                                                  // direction: DropdownDirection.right,
                                                                ),
                                                                menuItemStyleData:
                                                                    const MenuItemStyleData(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              16),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 50.h)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: ScreenUtil().screenHeight / 2.5),
                          Text(
                            "Has No Data",
                            style: BaseText.blackText14,
                          ),
                          SizedBox(height: 14.h),
                          CircleAvatar(
                            child: IconButton(
                              onPressed: _refresh,
                              icon: const Icon(Icons.refresh),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }
              },
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorName.mainColor,
        onPressed: () => navigateTo(context, const PatientRegistration())
            .then((value) => setState(() {})),
        child: const Icon(Icons.add, color: ColorName.whiteColor),
      ),
    );
  }

  ListTile buildPatientTile({
    required String number,
    required String name,
    required String age,
    Function()? onEditTap,
    Function()? onDeleteTap,
    Function()? onMoreTap,
  }) {
    return ListTile(
      isThreeLine: false,
      visualDensity: VisualDensity.compact,
      horizontalTitleGap: 0,
      leading: Text(
        number,
        style: BaseText.blackText14,
      ),
      title: Text(name,
          style: BaseText.blackText14.copyWith(fontWeight: BaseText.regular)),
      subtitle: Text("Usia: ${age.substring(0, 2)} Tahun",
          style: BaseText.blackText12.copyWith(fontWeight: BaseText.light)),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        children: [
          _buildIconButton(
            onPressed: onEditTap,
            icon: Icons.edit,
            color: ColorName.blackColor,
          ),
          _buildIconButton(
            onPressed: onDeleteTap,
            icon: CupertinoIcons.delete_solid,
            color: Colors.red.shade800,
          ),
          _buildIconButton(
            onPressed: onMoreTap,
            icon: Icons.more_horiz,
            color: ColorName.activeTextColor,
          )
        ],
      ),
    );
  }

  IconButton _buildIconButton({
    Function()? onPressed,
    required IconData icon,
    required Color color,
  }) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
    );
  }
}
