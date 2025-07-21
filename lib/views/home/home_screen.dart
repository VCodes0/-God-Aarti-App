import 'package:flutter/material.dart';
import '../../components/custom bottom bar/custom_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: CustomBottomBar());
  }
}
