import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final int numberOfSuggestions;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.numberOfSuggestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.green[700], // Set background color
      selectedItemColor: Colors.blue, // Set color for selected items
      unselectedItemColor: Colors.grey[400], // Set color for unselected items
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.graphic_eq),
          label: 'Reward',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications),
              if (numberOfSuggestions > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red, // Red color for badge
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '$numberOfSuggestions',
                      style: const TextStyle(
                        color: Colors.white, // White text on red background
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          label: 'Suggestions',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.card_giftcard),
          label: 'Trend',
        ),
      ],
    );
  }
}
