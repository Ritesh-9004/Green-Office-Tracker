import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_office_tracker/screens/suggestion.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav.dart';
import 'trend.dart';
import 'package:green_office_tracker/screens/reward.dart';

class CarbonTrackerHome extends StatefulWidget {
  const CarbonTrackerHome({super.key});

  @override
  CarbonTrackerHomeState createState() => CarbonTrackerHomeState();
}

class CarbonTrackerHomeState extends State<CarbonTrackerHome> {
  final commuteDistanceController = TextEditingController();
  final hvacHoursController = TextEditingController();
  final lightsHoursController = TextEditingController();
  final computerHoursController = TextEditingController();

  int _selectedIndex = 0;
  double totalEmission = 0;
  double maxEmission = 500;
  Map<String, dynamic> factors = {};
  String? selectedCommuteMode;
  int numberOfSuggestions = 3;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> fetchEmissionFactors() async {
    try {
      final String response =
      await rootBundle.loadString('android/assets/emission_factors.json');
      final data = json.decode(response);
      setState(() {
        factors = data['emission_factors'];
      });
    } catch (e) {
      print('Error loading emission factors: $e');
    }
  }

  void calculateEmissions() {
    if (factors.isEmpty) {
      print('Emission factors are not loaded yet.');
      return;
    }

    double commuteDistance = double.tryParse(commuteDistanceController.text) ?? 0;
    double hvacHours = double.tryParse(hvacHoursController.text) ?? 0;
    double lightsHours = double.tryParse(lightsHoursController.text) ?? 0;
    double computerHours = double.tryParse(computerHoursController.text) ?? 0;

    double commuteEmission = (commuteDistance * (factors['commute'][selectedCommuteMode] as num)).toDouble();
    double hvacEmission = (hvacHours * (factors['hvac']['per_hour'] as num)).toDouble();
    double lightsEmission = (lightsHours * (factors['lights']['per_hour'] as num)).toDouble();
    double computerEmission = (computerHours * (factors['computer']['per_hour'] as num)).toDouble();

    setState(() {
      totalEmission = commuteEmission + hvacEmission + lightsEmission + computerEmission;

      if (totalEmission < 50) {
        numberOfSuggestions = 1;
      } else if (totalEmission < 200) {
        numberOfSuggestions = 3;
      } else {
        numberOfSuggestions = 5;
      }

      _saveNumberOfSuggestions();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RewardScreen(totalEmission: totalEmission),
      ),
    );
  }
  List<String> _generateSuggestions(double emission) {
    List<String> dynamicSuggestions = [];

    if (emission < 50) {
      dynamicSuggestions = [
        "Consider walking or biking for short distances.",
        "Switch to energy-efficient light bulbs.",
      ];
    } else if (emission < 200) {
      dynamicSuggestions = [
        "Use public transportation more often.",
        "Install a smart thermostat to optimize HVAC usage.",
        "Switch off lights and appliances when not in use.",
      ];
    } else {
      dynamicSuggestions = [
        "Switch to renewable energy sources (solar, wind).",
        "Consider an electric vehicle for commuting.",
        "Reduce flying and opt for trains or buses.",
        "Implement energy-saving technologies in your office.",
      ];
    }

    return dynamicSuggestions;
  }

  Future<void> _saveNumberOfSuggestions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('numberOfSuggestions', numberOfSuggestions);
  }

  Future<void> loadNumberOfSuggestions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      numberOfSuggestions = prefs.getInt('numberOfSuggestions') ?? 3;
    });
  }

  Future<void> clearBadge() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      numberOfSuggestions = 0;
    });
    await prefs.setInt('numberOfSuggestions', 0);
  }

  @override
  void initState() {
    super.initState();
    fetchEmissionFactors();
    loadNumberOfSuggestions();
  }

  @override
  void dispose() {
    commuteDistanceController.dispose();
    hvacHoursController.dispose();
    lightsHoursController.dispose();
    computerHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percent = (totalEmission / maxEmission).clamp(0.0, 1.0);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Emission Tracker'),
        backgroundColor: Colors.green[700],
      ),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your Commute Mode:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700]),
            ),
            const SizedBox(height: 8),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: selectedCommuteMode,
                isExpanded: true,
                hint: const Text("Select Commute Mode"),
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCommuteMode = newValue;
                  });
                },
                items: <String>['car', 'bus', 'train', 'bike', 'flight']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value[0].toUpperCase() + value.substring(1)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(commuteDistanceController, 'Commute Distance (km)', Icons.directions_car),
            _buildTextField(hvacHoursController, 'HVAC Hours', Icons.ac_unit),
            _buildTextField(lightsHoursController, 'Lights Hours', Icons.lightbulb_outline),
            _buildTextField(computerHoursController, 'Computer Hours', Icons.computer),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateEmissions,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Calculate Carbon Footprint',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CircularPercentIndicator(
                radius: 120,
                lineWidth: 12.0,
                animation: true,
                percent: percent,
                center: Text(
                  '${totalEmission.toStringAsFixed(2)} kg',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text("Total CO₂ Emission", style: TextStyle(fontSize: 16.0)),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green[600],
              ),
            ),
          ],
        ),
      )
          : _selectedIndex == 1
          ? RewardScreen(totalEmission: totalEmission)
          : _selectedIndex == 2
          ? SuggestionScreen(
        totalEmission: totalEmission,
        numberOfSuggestions: numberOfSuggestions,
      )
          : TrendScreen(emissionData: [totalEmission]),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        numberOfSuggestions: numberOfSuggestions,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green[700]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
