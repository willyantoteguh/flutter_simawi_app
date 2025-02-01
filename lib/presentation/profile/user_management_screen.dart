import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';
import '../../data/database/database_instance.dart';
import '../../data/model/user.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_divider.dart';
import '../widgets/delete_dialog.dart';
import '../widgets/other_navigation.dart';
import 'create_user_screen.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  DatabaseInstance? databaseInstance;
  int totalAdmin = 0;
  int totalDoctor = 0;
  int total = 0;

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
      backgroundColor: ColorName.whiteColor,
      appBar: customAppBar(context, label: "User Management"),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
          child: Column(
            children: [
              buildDivider(),
              SizedBox(height: 18.h),
              FutureBuilder(
                future: databaseInstance!.totalAdmin(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  } else {
                    if (snapshot.hasData) {
                      totalAdmin = snapshot.data ?? totalAdmin;
                      debugPrint("total Admin: $totalAdmin");

                      return Text("Total Admin: ${snapshot.data.toString()}",
                          style: BaseText.blackText16);
                    } else {
                      return const Text("Total Admin: -");
                    }
                  }
                },
              ),
              FutureBuilder(
                future: databaseInstance!.totalDoctor(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  } else {
                    if (snapshot.hasData) {
                      totalDoctor = snapshot.data ?? totalDoctor;
                      debugPrint("total Doctor: $totalDoctor");

                      return Text("Total Doctor: ${snapshot.data.toString()}",
                          style: BaseText.blackText16);
                    } else {
                      return const Text("Total Doctor: -");
                    }
                  }
                },
              ),
              SizedBox(height: 14.h),
              buildDivider(),
              FutureBuilder<List<User>>(
                future: databaseInstance!.getAll(),
                builder: (context, snapshot) {
                  debugPrint("Result : ${snapshot.data}");
                  total = totalAdmin + totalDoctor;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  } else {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return buildUserTile(
                                number: snapshot.data![index].id.toString(),
                                name: snapshot.data![index].name,
                                email: snapshot.data![index].email,
                                onEditTap: () {
                                  var user = snapshot.data![index];

                                  navigateTo(
                                      context,
                                      CreateUserScreen(
                                        isUpdateScreen: true,
                                        user: user,
                                      )).then((value) => setState(() {}));
                                },
                                onDeleteTap: () => showAlertDialog(
                                      context,
                                      databaseInstance,
                                      setState,
                                      false,
                                      snapshot.data![index].id,
                                    ));
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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorName.mainColor,
        onPressed: () => navigateTo(
            context,
            const CreateUserScreen(
              isUpdateScreen: false,
            )).then(
          (value) => setState(() {}),
        ),
        child: const Icon(Icons.add, color: ColorName.whiteColor),
      ),
    );
  }

  ListTile buildUserTile({
    required String number,
    required String name,
    required String email,
    Function()? onEditTap,
    Function()? onDeleteTap,
  }) {
    return ListTile(
      isThreeLine: true,
      titleAlignment: ListTileTitleAlignment.titleHeight,
      leading: Text(
        number,
        style: BaseText.blackText14,
      ),
      title: Text(name, style: BaseText.blackText14),
      subtitle: Text(email,
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


  // buildUserTile(
                //   number: "1",
                //   name: "Andrea Waluyo",
                //   email: "andrewaw@mail.com",
                //   onEditTap: () {
                //     User user = User(
                //       id: 1,
                //       email: "andrewaw@mail.com",
                //       password: "password",
                //       name: "Andrea Waluyo",
                //       role: Role.doctor,
                //       createdAt: "2025-01-30",
                //       updatedAt: "2025-01-30",
                //     );

                //     navigateTo(
                //       context,
                //       CreateUserScreen(isUpdateScreen: true, user: user),
                //     );
                //   },
                //   onDeleteTap: () {},
                // ),