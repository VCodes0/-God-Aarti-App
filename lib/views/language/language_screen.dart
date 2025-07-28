import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/CustomNxtButton/custom_next_button.dart';
import '../../main.dart';
import '../onboarding/firest/first_onboard.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final languages = const [
    "English",
    "हिंदी",
    "Español",
    "Français",
    "Portuguese",
    "한국인",
    "Русcкий",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final padding = mq.width * 0.04;
    final verticalSpacing = mq.height * 0.02;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text("Select Language")),
      body: Container(
        width: mq.width,
        height: mq.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: verticalSpacing * 2,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: verticalSpacing / 2,
                      ),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? Colors.orange.shade100
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              languages[index],
                              style: TextStyle(
                                fontSize: mq.width * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            selectedIndex == index
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: verticalSpacing * 2),
            GestureDetector(
              onTap: () => Get.to(() => OnboardFirst()),
              child: CustomNxtButton(text: 'Next'),
            ),
            SizedBox(height: verticalSpacing * 2),
          ],
        ),
      ),
    );
  }
}
