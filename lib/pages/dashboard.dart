import 'package:flutter/material.dart';

import '../components/double_circle.dart';
import '../components/hover_pie_chart.dart';
import '../components/text_styles.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Bagian Atas
          Container(
            height: screenHeight * 0.5,
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Stack(
              children: [
                doubleCircle(),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 40.0),
                      child: Text("Butik Mamih", style: AppTextStyles.header(color: Colors.white)),
                    ),
                    Text(
                      "Inventaris Butik Mamih",
                      style: AppTextStyles.subtitle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Bagian Bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "DATA STOK",
                        style: AppTextStyles.subtitle(color: Colors.blueGrey),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    InteractivePieChartWithWidgetTooltip(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
