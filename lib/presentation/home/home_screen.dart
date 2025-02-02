import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../common/theme/color/color_name.dart';
import '../../common/theme/text/base_text.dart';
import '../../data/database/database_instance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseInstance? databaseInstance;
  final Map<String, double> _pasienData = {
    'Pasien Baru': 10,
    'Pasien Lama': 20,
    'Pasien Total': 30,
  };

  final List<Pasien> _pasienList = [
    Pasien('John Doe', '2022-01-01'),
    Pasien('Jane Doe', '2022-01-02'),
    Pasien('Bob Smith', '2022-01-03'),
  ];

  @override
  void initState() {
    super.initState();
    databaseInstance = DatabaseInstance();
    initDatabase();
  }

  Future _refresh() async {
    setState(() {});
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
          "Dashboard",
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
      body: Column(
        children: [
          FutureBuilder<Map<String, dynamic>>(
              future: databaseInstance!.getPatientState(),
              builder: (context, snapshot) {
                debugPrint("Result : ${snapshot.data}");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: ScreenUtil().screenHeight / 2,
                      child: PieChart(
                        dataMap: _pasienData,
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        // initialAngle: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 32,
                        centerText: 'Pasien',
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                          legendShape: BoxShape.rectangle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                        ),
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
              }),
          const SizedBox(height: 20),
          const Text('Daftar Pasien Terbaru'),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _pasienList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_pasienList[index].nama),
                  subtitle: Text(_pasienList[index].tanggal),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Pasien {
  String nama;
  String tanggal;

  Pasien(this.nama, this.tanggal);
}
