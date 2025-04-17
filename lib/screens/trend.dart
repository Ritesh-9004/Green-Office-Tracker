// lib/screens/trend.dart

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrendScreen extends StatelessWidget {
  final List<double> emissionData;

  const TrendScreen({super.key, required this.emissionData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Carbon Emission Trend',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value} kg',
                  minimum: 0,
                  maximum: emissionData.isNotEmpty
                      ? emissionData.reduce((a, b) => a > b ? a : b) * 1.2
                      : 100,
                  majorGridLines: const MajorGridLines(width: 1, color: Colors.grey),
                  axisLine: const AxisLine(width: 1, color: Colors.grey),
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
                title: ChartTitle(
                  text: 'Carbon Emission (kg)',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  LineSeries<double, String>(
                    dataSource: List.generate(
                      emissionData.length,
                          (index) => emissionData[index],
                    ),
                    xValueMapper: (double emission, int index) =>
                    'Day ${index + 1}', // X-axis value as 'Day X'
                    yValueMapper: (double emission, int index) => emission,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      color: Colors.blue,
                      shape: DataMarkerType.circle,
                    ),
                    color: Colors.blue, // Line color
                    width: 4,
                    animationDuration: 1500,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Adding a better footer for context
            const Text(
              'The graph shows your carbon emission trend over the past week. The values are in kilograms of CO₂.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
