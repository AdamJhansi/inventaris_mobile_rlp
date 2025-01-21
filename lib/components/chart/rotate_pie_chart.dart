import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonochromeRotatingPieChart extends StatefulWidget {
  @override
  _MonochromeRotatingPieChartState createState() => _MonochromeRotatingPieChartState();
}

class _MonochromeRotatingPieChartState extends State<MonochromeRotatingPieChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Inisialisasi AnimationController dengan durasi dan mode repeat
    _controller = AnimationController(
      duration: const Duration(seconds: 10), // Durasi satu siklus rotasi
      vsync: this,
    ); // Animasi akan terus berulang
  }

  @override
  void dispose() {
    _controller.dispose(); // Membersihkan controller saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Menghitung rotasi dalam derajat
        double rotation = _controller.value * 360;

        return Container(
          height: 200,
          width: 200,
          child: PieChart(
            PieChartData(
              startDegreeOffset: rotation, // Rotasi dinamis
              sections: [
                PieChartSectionData(
                  color: Colors.grey[800],
                  value: 40,
                  title: '40%',
                  radius: 50,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.grey[600],
                  value: 30,
                  title: '30%',
                  radius: 50,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.grey[400],
                  value: 20,
                  title: '20%',
                  radius: 50,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.grey[200],
                  value: 10,
                  title: '10%',
                  radius: 50,
                  titleStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
              borderData: FlBorderData(show: false),
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        );
      },
    );
  }
}
