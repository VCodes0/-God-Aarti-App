import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/permissions/permissions.dart';
import '../../widgets/build policy item/build_policy_item.dart';
import '../CustomNxtButton/custom_next_button.dart';

class TofuScreen extends StatelessWidget {
  const TofuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The application is notifying you to the presence of an app that provides several services that are essential information for safer and more efficient use.",
            style: TextStyle(
              fontSize: screenSize.width * 0.038,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenSize.height * 0.025),

          buildPolicyItem(
            screenSize,
            "assets/icon1.png",
            "By pressing the Accept button, I declare I have read and accepted the following condition of use.",
          ),
          buildPolicyItem(
            screenSize,
            "assets/icon2.png",
            "If we find the app is being used outside its terms of use, we may restrict access to it.",
          ),
          buildPolicyItem(
            screenSize,
            "assets/icon3.png",
            "Any type of modification to the app or its components is not allowed.",
          ),
          buildPolicyItem(
            screenSize,
            "assets/icon2.png",
            "Privacy Policy may be updated from time to time for any reason. We will notify you of any changes to our Privacy Policy by posting the new Privacy Policy here.",
          ),
          buildPolicyItem(
            screenSize,
            "assets/icon4.png",
            "We do not share any kind of your Personal Data with third parties.",
          ),

          SizedBox(height: screenSize.height * 0.03),
          Text(
            "You can find out more information by clicking on the following link:",
            style: TextStyle(
              fontSize: screenSize.width * 0.038,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenSize.height * 0.012),
          Text(
            "Terms and conditions of use",
            style: TextStyle(
              fontSize: screenSize.width * 0.04,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            "Privacy policy.",
            style: TextStyle(
              fontSize: screenSize.width * 0.04,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),

          SizedBox(height: screenSize.height * 0.05),

          // Agree Button
          Center(
            child: GestureDetector(
              onTap: () => Get.to(() => PermissionsScreen()),
              child: CustomNxtButton(text: 'Agree'),
            ),
          ),

          SizedBox(height: screenSize.height * 0.05),
        ],
      ),
    );
  }
}
