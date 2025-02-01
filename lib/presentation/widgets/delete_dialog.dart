import "package:flutter/material.dart";
import "package:flutter_simawi_app/data/database/database_instance.dart";

showAlertDialog(BuildContext contex, DatabaseInstance? databaseInstance,
    setState, bool isPatient, int id) {
  Widget okButton = TextButton(
    child: const Text("Confirm"),
    onPressed: () {
      //delete disini
      (isPatient)
          ? databaseInstance!.hapusPatient(id)
          : databaseInstance!.hapus(id);
      Navigator.of(contex, rootNavigator: true).pop();
      setState(() {});
    },
  );

  AlertDialog alertDialog = AlertDialog(
    title: const Text("Alert !"),
    content: const Text("Are you sure you will remove ?"),
    actions: [okButton],
  );

  showDialog(
      context: contex,
      builder: (BuildContext context) {
        return alertDialog;
      });
}
