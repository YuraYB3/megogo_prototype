import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/home/home_view.dart';
import 'package:megogo_prototype/app/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(builder: (context, value, child) {
        return const HomeView();
      },),
    );
    
  }
}
