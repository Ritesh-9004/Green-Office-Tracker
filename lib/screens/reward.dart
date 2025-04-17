import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  final double totalEmission;

  const RewardScreen({super.key, required this.totalEmission});

  String getRewardTitle() {
    if (totalEmission < 50) {
      return "🌿 Eco Hero";
    } else if (totalEmission < 200) {
      return "💡 Conscious Contributor";
    } else {
      return "🔥 Emission Explorer";
    }
  }

  String getRewardMessage() {
    if (totalEmission < 50) {
      return "Amazing work! You've kept your emissions super low. Keep being a green warrior!";
    } else if (totalEmission < 200) {
      return "You're doing well! A few more green steps and you'll become an Eco Hero!";
    } else {
      return "You're on the journey! Try reducing your emissions to unlock rewards.";
    }
  }

  Color getRewardColor() {
    if (totalEmission < 50) {
      return Colors.green;
    } else if (totalEmission < 200) {
      return Colors.amber[700]!;
    } else {
      return Colors.redAccent;
    }
  }

  IconData getRewardIcon() {
    if (totalEmission < 50) {
      return Icons.emoji_events;
    } else if (totalEmission < 200) {
      return Icons.star_half;
    } else {
      return Icons.local_fire_department;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rewards"),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  getRewardIcon(),
                  size: 60,
                  color: getRewardColor(),
                ),
                const SizedBox(height: 16),
                Text(
                  getRewardTitle(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: getRewardColor(),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  getRewardMessage(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  "Your Emission: ${totalEmission.toStringAsFixed(2)} kg CO₂",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
