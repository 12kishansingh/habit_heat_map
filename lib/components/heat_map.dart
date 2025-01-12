import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final DateTime startdate;
  final Map<DateTime, int>? dataset;
  const MyHeatMap({
    super.key,
    required this.dataset,
    required this.startdate,
  });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startdate,
      endDate: DateTime.now(),
      datasets: dataset,
      colorMode: ColorMode.color,
      defaultColor: Theme.of(context).colorScheme.secondary,
      textColor: const Color.fromARGB(255, 249, 247, 247),
      showColorTip: false,
      showText: true,
      scrollable: true,
      size: 30,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      },
    );
  }
}
