import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';

class InteractivePieChartWithWidgetTooltip extends StatefulWidget {
  @override
  _InteractivePieChartWithWidgetTooltipState createState() => _InteractivePieChartWithWidgetTooltipState();
}

class _InteractivePieChartWithWidgetTooltipState extends State<InteractivePieChartWithWidgetTooltip> {
  int? _touchedIndex;
  Widget? _tooltipWidget;
  int _totalBaju = 0;
  int _totalCelana = 0;
  int _totalJaket = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final repository = ItemsRepository();
    final totalBaju = await repository.getCount('baju');
    final totalCelana = await repository.getCount('celana');
    final totalJaket = await repository.getCount('jaket');
    setState(() {
      _totalBaju = totalBaju;
      _totalCelana = totalCelana;
      _totalJaket = totalJaket;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 240,
          width: 240,
          child: PieChart(
            PieChartData(
              sections: _buildSections(),
              borderData: FlBorderData(show: false),
              centerSpaceRadius: 60,
              sectionsSpace: 2,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions || response == null) {
                      _touchedIndex = null;
                      _tooltipWidget = null;
                      return;
                    }
                    _touchedIndex = response.touchedSection?.touchedSectionIndex;
                    _tooltipWidget = _getTooltipWidget(_touchedIndex);
                  });
                },
              ),
            ),
          ),
        ),
        if (_tooltipWidget != null)
          Positioned(
            top: 80,
            child: _tooltipWidget!,
          ),
      ],
    );
  }

  List<PieChartSectionData> _buildSections() {
    final total = _totalBaju + _totalCelana + _totalJaket;
    final sections = [
      PieChartSectionData(
        borderSide: BorderSide(color: Colors.blueGrey),
        color: Colors.white,
        value: total > 0 ? (_totalBaju / total) * 100 : 0,
        title: '${_totalBaju}%',
        radius: _touchedIndex == 0 ? 60 : 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
      PieChartSectionData(
        borderSide: BorderSide(color: Colors.grey),
        color: Colors.blueGrey,
        value: total > 0 ? (_totalCelana / total) * 100 : 0,
        title: '${_totalCelana}%',
        radius: _touchedIndex == 1 ? 60 : 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        borderSide: BorderSide(color: Colors.grey),
        color: Colors.grey,
        value: total > 0 ? (_totalJaket / total) * 100 : 0,
        title: '${_totalJaket}%',
        radius: _touchedIndex == 2 ? 60 : 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
    return sections;
  }

  Widget? _getTooltipWidget(int? index) {
    if (index == null) return null;
    switch (index) {
      case 0:
        return _buildTooltipWidget('Baju: $_totalBaju', Icons.water_drop, Colors.blueGrey);
      case 1:
        return _buildTooltipWidget('Celana: $_totalCelana', Icons.fireplace, Colors.blueGrey);
      case 2:
        return _buildTooltipWidget('Jaket: $_totalJaket', Icons.sunny, Colors.blueGrey);
      default:
        return null;
    }
  }

  Widget _buildTooltipWidget(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
