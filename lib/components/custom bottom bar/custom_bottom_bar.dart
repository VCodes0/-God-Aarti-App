import 'package:flutter/material.dart';

import '../../views/aarti/aarti_screen.dart';
import '../../views/downloads/downloads_screen.dart';
import '../../views/wallpaper/wallpaper_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> items = [
    {
      'icon': 'assets/active_hand.png',
      'selectedIcon': 'assets/inactive_hand.png',
      'label': 'Aarti',
    },
    {
      'icon': 'assets/active_wallpaper.png',
      'selectedIcon': 'assets/inactive_wallpaper.png',
      'label': 'Wallpaper',
    },
    {
      'icon': 'assets/active_download.png',
      'selectedIcon': 'assets/inactive_download.png',
      'label': 'Downloads',
    },
  ];

  final List<Widget> screens = [
    AartiScreen(),
    WallpaperScreen(),
    DownloadsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: selectedIndex, children: screens),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      final isSelected = index == selectedIndex;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFFF9800),
                                      Color(0xFFFFC107),
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                isSelected
                                    ? item['selectedIcon']
                                    : item['icon'],
                                width: 24,
                                height: 24,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item['label'],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
