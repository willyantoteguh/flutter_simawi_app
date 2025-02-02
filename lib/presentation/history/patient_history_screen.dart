import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simawi_app/data/model/patient.dart';
import 'package:flutter_simawi_app/data/model/patient_history.dart';
import 'package:flutter_simawi_app/data/model/user.dart';
import 'package:flutter_simawi_app/presentation/registration/patient_registration_screen.dart';
import 'package:flutter_simawi_app/presentation/widgets/custom_divider.dart';
import 'package:flutter_simawi_app/presentation/widgets/other_navigation.dart';
import 'package:flutter_simawi_app/presentation/widgets/primary_button.dart';
import 'package:intl/intl.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';
import '../../data/database/database_instance.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/delete_dialog.dart';

enum PatientServed { NotDone, Done }

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({super.key});

  @override
  State<PatientHistoryScreen> createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  DatabaseInstance? databaseInstance;
  Future _refresh() async {
    setState(() {});
  }

  final TextEditingController _controller = TextEditingController();
  // final List<Map<String, dynamic>> _data = [];
  final List<Map<String, dynamic>> _filteredData = [];
  bool isSearch = false;

  List<Map<String, dynamic>> listDoctors = [];
  var selectedDoctor;
  var selectedDoctorNew;
  var selectedDateVisit;
  final TextEditingController dateVisitController = TextEditingController();

  var patientJoin;

  var selectedPatientServed;
  PatientServed _patientServed = PatientServed.NotDone;

  List<User> listRegisteredBy = [];
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
          "Medical Record",
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
              future: databaseInstance!.getPatientData(),
              builder: (context, snapshot) {
                debugPrint("Result : ${snapshot.data}");

                // // Single Patient History
                // Future.delayed(const Duration(seconds: 2), () async {
                //   await databaseInstance!.getPatientData().then((value) {
                //     patientJoin = value;
                //     debugPrint("patientJoin: $patientJoin");
                //   });
                // });

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // //!TODO: Here is Filter Menu isDone

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
                                    name: patient["namePatient"].toString(),
                                    dateVisit: patient["dateVisit"],
                                    onMoreTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          enableDrag: true,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w),
                                                child: StatefulBuilder(builder:
                                                    (context, newSetState) {
                                                  return SizedBox(
                                                    // height: ScreenUtil()
                                                    //         .screenHeight /
                                                    //     2,
                                                    width: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        Text("Not Done",
                                                            style: BaseText
                                                                .blackText14),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                groupValue:
                                                                    _patientServed,
                                                                value:
                                                                    PatientServed
                                                                        .NotDone,
                                                                visualDensity:
                                                                    VisualDensity
                                                                        .compact,
                                                                activeColor:
                                                                    ColorName
                                                                        .mainColor,
                                                                onChanged:
                                                                    (value) {
                                                                  newSetState(
                                                                      () {
                                                                    _patientServed =
                                                                        value!;
                                                                  });
                                                                }),
                                                            Text("Admin",
                                                                style: BaseText
                                                                    .blackText12),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                groupValue:
                                                                    _patientServed,
                                                                value:
                                                                    PatientServed
                                                                        .Done,
                                                                visualDensity:
                                                                    VisualDensity
                                                                        .compact,
                                                                activeColor:
                                                                    ColorName
                                                                        .mainColor,
                                                                onChanged:
                                                                    (value) {
                                                                  newSetState(
                                                                      () {
                                                                    _patientServed =
                                                                        value!;
                                                                  });
                                                                }),
                                                            Text("Doctor",
                                                                style: BaseText
                                                                    .blackText12),
                                                          ],
                                                        ),
                                                        SizedBox(height: 24.h),
                                                        _buildRow(
                                                          label: "Name: ",
                                                          value: patient[
                                                                  "namePatient"]
                                                              .toString(),
                                                        ),
                                                        SizedBox(height: 14.h),
                                                        _buildRow(
                                                          label: "Usia: ",
                                                          value: patient["age"]
                                                              .toString(),
                                                        ),
                                                        SizedBox(height: 14.h),
                                                        _buildRow(
                                                          label:
                                                              "Jenis Kelamin: ",
                                                          value:
                                                              patient["gender"]
                                                                  .toString(),
                                                        ),
                                                        SizedBox(height: 14.h),
                                                        _buildRow(
                                                          label: "No Telepon: ",
                                                          value:
                                                              patient["phone"]
                                                                  .toString(),
                                                        ),
                                                        SizedBox(height: 14.h),
                                                        _buildRow(
                                                          label: "Alamat: ",
                                                          value:
                                                              patient["address"]
                                                                  .toString(),
                                                        ),
                                                        SizedBox(height: 14.h),
                                                        _buildRow(
                                                          label:
                                                              "Tanggal Periksa: ",
                                                          value: patient[
                                                                  "dateVisit"]
                                                              .toString(),
                                                        ),
                                                        SizedBox(height: 14.h),
                                                        _buildRow(
                                                          label: "Doketer: ",
                                                          value: patient[
                                                                  "consultationBy"]
                                                              .toString(),
                                                        ),
                                                        SizedBox(height: 14.h),
                                                        SizedBox(height: 50.h)
                                                      ],
                                                    ),
                                                  );
                                                }),
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

  Row _buildRow({
    String label = "",
    String value = "",
  }) {
    return Row(
      children: [
        Text(
          label,
          style: BaseText.blackText12.copyWith(
            fontWeight: BaseText.medium,
          ),
        ),
        Text(
          value,
          style: BaseText.blackText12,
        )
      ],
    );
  }

  ListTile buildPatientTile({
    required String number,
    required String name,
    required String dateVisit,
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
      subtitle: Text(dateVisit,
          style: BaseText.blackText12.copyWith(fontWeight: BaseText.light)),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        children: [
          _buildIconButton(
            onPressed: onMoreTap,
            icon: Icons.visibility,
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
