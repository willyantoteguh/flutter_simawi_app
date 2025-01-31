import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simawi_app/data/model/patient.dart';
import 'package:flutter_simawi_app/presentation/registration/patient_registration_screen.dart';
import 'package:flutter_simawi_app/presentation/widgets/custom_divider.dart';
import 'package:flutter_simawi_app/presentation/widgets/other_navigation.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';
import '../../data/database/database_instance.dart';
import '../widgets/custom_appbar.dart';

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
            FutureBuilder<List<Patient>>(
              future: databaseInstance!.getAllPatient(),
              builder: (context, snapshot) {
                debugPrint("Result : ${snapshot.data}");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => buildDivider(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var patients = snapshot.data ?? [];
                          var patient = patients[index];

                          return buildPatientTile(
                            number: patient.id.toString(),
                            name: patient.name,
                            birth: patient.birth,
                            onEditTap: () => navigateTo(
                              context,
                              const PatientRegistration(
                                isUpdateScreen: true,
                              ),
                            ).then((value) => setState(() {})),
                            onDeleteTap: () {},
                          );
                        },
                      ),
                    );
                  } else {
                    return Text(
                      "Has No Data",
                      style: BaseText.blackText14,
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
    required String birth,
    Function()? onEditTap,
    Function()? onDeleteTap,
  }) {
    return ListTile(
      isThreeLine: false,
      visualDensity: VisualDensity.compact,
      leading: Text(
        number,
        style: BaseText.blackText14,
      ),
      title: Text(name,
          style: BaseText.blackText14.copyWith(fontWeight: BaseText.regular)),
      subtitle: Text(birth,
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
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
    );
  }
}
