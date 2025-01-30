import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simawi_app/data/model/user.dart';

import '../../common/constants/text_constant.dart';
import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';
import '../../data/database/database_instance.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_password_textfield.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_button.dart';

class CreateUserScreen extends StatefulWidget {
  final bool isUpdateScreen;
  final User? user;

  const CreateUserScreen({
    super.key,
    this.user,
    required this.isUpdateScreen,
  });

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  bool isUpdateScreen = false;
  late User? _currentUser;

  String appBarTitle = "New User";

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  int _selectedValue = 1;

  @override
  void initState() {
    super.initState();
    databaseInstance.database();

    isUpdateScreen = widget.isUpdateScreen;

    if (isUpdateScreen) {
      _currentUser = widget.user;
      appBarTitle = "Update User";

      // Load current user
      fullNameController.text = _currentUser?.name ?? "";
      emailController.text = _currentUser?.email ?? "";
      _selectedValue = _currentUser!.role;
    }
  }

  showAlertDialog(BuildContext contex) {
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(contex, rootNavigator: true).pop();
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text("Warning !"),
      content: const Text("Must fill in all fields.."),
      actions: [okButton],
    );

    showDialog(
        context: contex,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteColor,
      appBar: customAppBar(context, label: appBarTitle),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (isUpdateScreen)
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome!", style: BaseText.mainText18),
                        SizedBox(height: 12.h),
                        Text(TextConstants.newUserDescription,
                            style: BaseText.blackText12
                                .copyWith(fontWeight: BaseText.light)),
                        SizedBox(height: 36.h),
                      ],
                    ),
              Text("Full name", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              CustomTextField(
                hintText: "Enter Full name",
                controller: fullNameController,
                onChanged: (v) {},
              ),
              SizedBox(height: 14.h),
              Text("Email", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              CustomTextField(
                hintText: "Enter Email",
                controller: emailController,
                onChanged: (v) {},
              ),
              SizedBox(height: 14.h),
              Text("Password", style: BaseText.blackText14),
              SizedBox(height: 6.h),
              CustomPasswordTextfield(
                hintText: "Enter Password",
                controller: passwordController,
                onChanged: (v) {},
              ),
              SizedBox(height: 14.h),
              Text("Role", style: BaseText.blackText14),
              Row(
                children: [
                  Radio(
                      groupValue: _selectedValue,
                      value: 1,
                      visualDensity: VisualDensity.compact,
                      activeColor: ColorName.mainColor,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = int.parse(value.toString());
                        });
                      }),
                  Text("Admin", style: BaseText.blackText12),
                ],
              ),
              Row(
                children: [
                  Radio(
                      groupValue: _selectedValue,
                      value: 2,
                      visualDensity: VisualDensity.compact,
                      activeColor: ColorName.mainColor,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = int.parse(value.toString());
                        });
                      }),
                  Text("Doctor", style: BaseText.blackText12),
                ],
              ),
              SizedBox(height: 46.h),
              PrimaryButton(
                onPressed: () async {
                  if (fullNameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    showAlertDialog(context);
                  } else {
                    if (isUpdateScreen) {
                      debugPrint("onTap Update");

                      User updateUser = User(
                        id: _currentUser!.id,
                        name: fullNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        role: _selectedValue,
                        createdAt: _currentUser!.createdAt,
                        updatedAt: DateTime.now().toString(),
                      );

                      debugPrint(updateUser.toMap().toString());

                      await databaseInstance.update(
                          _currentUser!.id, updateUser.toMap());
                      Navigator.pop(context);
                    } else {
                      debugPrint("onTap Create");

                      User newUser = User(
                        id: Random().nextInt(200),
                        name: fullNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        role: _selectedValue,
                        createdAt: DateTime.now().toString(),
                        updatedAt: DateTime.now().toString(),
                      );

                      debugPrint(newUser.toMap().toString());

                      int idInsert =
                          await databaseInstance.insert(newUser.toMap());
                      debugPrint("Success : $idInsert");
                      Navigator.pop(context);
                    }
                  }
                },
                height: 45.h,
                title: "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }
}
