  import 'package:flutter/material.dart';
  class SuggestionScreen extends StatefulWidget {
    final double totalEmission;
    final int numberOfSuggestions;
    const SuggestionScreen({
      Key? key,
      required this.totalEmission, required this.numberOfSuggestions,
    }) : super(key: key);

    @override
    _SuggestionScreenState createState() => _SuggestionScreenState();
  }

  class _SuggestionScreenState extends State<SuggestionScreen> {
    int? currentSuggestions;

    @override
    void initState() {
      super.initState();
      currentSuggestions = _generateSuggestions().length;
    }

    @override
    void didUpdateWidget(covariant SuggestionScreen oldWidget) {
      super.didUpdateWidget(oldWidget);
      // Update suggestions when total emission changes
      if (oldWidget.totalEmission != widget.totalEmission) {
        setState(() {
          currentSuggestions = _generateSuggestions().length;
        });
      }
    }

    // Generate dynamic suggestions based on total emission
    List<String> _generateSuggestions() {
      List<String> suggestions = [];
      if (widget.totalEmission < 50) {
        suggestions.add("Switch to LED lighting to reduce energy consumption.");
        suggestions.add("Consider using energy-efficient appliances.");
      } else if (widget.totalEmission < 200) {
        suggestions.add("Try carpooling to reduce your commute emissions.");
        suggestions.add("Upgrade your thermostat for better energy savings.");
      } else {
        suggestions.add("Consider using public transport to reduce emissions.");
        suggestions.add("Use smart power strips to reduce standby power usage.");
      }
      return suggestions;
    }

    @override
    Widget build(BuildContext context) {
      List<String> suggestions = _generateSuggestions();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Suggestions'),
          actions: [
            // Badge to show the number of suggestions
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Stack(
                clipBehavior: Clip.none, // Prevents clipping the badge outside the icon
                children: [
                  const Icon(Icons.notifications, size: 30),
                  if (currentSuggestions != null && currentSuggestions! > 0)
                    Positioned(
                      right: -4, // Adjust position slightly to center the badge better
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '$currentSuggestions',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Here are your suggestions based on your carbon footprint:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: suggestions.length, // Use dynamic list
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      child: ListTile(
                        title: Text(suggestions[index]), // Show real suggestion
                        subtitle: const Text('Take action to reduce your footprint.'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
