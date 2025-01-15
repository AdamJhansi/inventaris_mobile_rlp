import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../components/double_circle.dart';
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
                      padding: const EdgeInsets.only(left: 30.0, top: 35.0),
                      child: Text("Header", style: AppTextStyles.header(color: Colors.white)),
                    ),
                    Text(
                      "SUB TITLE",
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chart(
                      data: [
                        {'genre': 'Sports', 'sold': 275},
                        {'genre': 'Strategy', 'sold': 115},
                        {'genre': 'Action', 'sold': 120},
                        {'genre': 'Shooter', 'sold': 350},
                        {'genre': 'Other', 'sold': 150},
                      ],
                      variables: {
                        'genre': Variable(
                          accessor: (Map map) => map['genre'] as String,
                        ),
                        'sold': Variable(
                          accessor: (Map map) => map['sold'] as num,
                        ),
                      },
                      marks: [IntervalMark()],
                      axes: [
                        Defaults.horizontalAxis,
                        Defaults.verticalAxis,
                      ],
                    )
                  ],
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
