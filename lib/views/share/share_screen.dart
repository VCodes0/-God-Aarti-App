import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Never Given Share Page',
                    style: TextStyle(
                      fontSize: mq.width * 0.045,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: mq.width * 0.44,
            bottom: mq.height * 0.2,
            child: IconButton(
              icon: CircleAvatar(
                backgroundColor: CupertinoColors.transparent,
                child: const Icon(Icons.close, color: Colors.black, size: 30),
              ),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
