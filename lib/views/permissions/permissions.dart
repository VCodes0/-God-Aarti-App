import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/CustomNxtButton/custom_next_button.dart';
import '../../widgets/buildPermissionTile/build_permission_tile.dart';


class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool isContactsEnabled = true;
  bool isMediaEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5F1),
      body: SafeArea(child: _permissionsWidget()),
    );
  }

  Widget _permissionsWidget() {
    final Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screen.width * 0.06,
        vertical: screen.height * 0.025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Required Permission",
              style: TextStyle(
                color: Colors.brown[800],
                fontSize: screen.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: screen.height * 0.015),
          Center(
            child: Text(
              "Grant permission for these apps to access\nfeatures on your device.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: screen.width * 0.038,
              ),
            ),
          ),
          SizedBox(height: screen.height * 0.03),

          /// CONTACTS PERMISSION
          buildPermissionTile(
            screen,
            iconPath: "assets/contact.png",
            title: "Contacts",
            subtitle: "Allow access to your phone’s contacts list.",
            value: isContactsEnabled,
            onChanged: (val) {
              setState(() {
                isContactsEnabled = val;
              });
            },
          ),

          SizedBox(height: screen.height * 0.02),

          /// MEDIA PERMISSION
          buildPermissionTile(
            screen,
            iconPath: "assets/folder.png",
            title: "Photos/Media/File",
            subtitle: "Allow access to Photos, Videos and Media Files.",
            value: isMediaEnabled,
            onChanged: (val) {
              setState(() {
                isMediaEnabled = val;
              });
            },
          ),

          SizedBox(height: screen.height * 0.08),

          /// CONTINUE BUTTON
          Center(
            child: InkWell(
              onTap: () => Get.to(() => GetStartedScreen()),
              child: CustomNxtButton(text: "Continue"),
            ),
          ),

          SizedBox(height: screen.height * 0.1),

          /// AD SPACE
          Container(
            height: screen.height * 0.15,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              "AD",
              style: TextStyle(
                fontSize: screen.width * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
