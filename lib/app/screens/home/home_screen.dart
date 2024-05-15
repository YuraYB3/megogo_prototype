import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/loading_widget.dart';
import 'package:megogo_prototype/app/screens/home/home_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

import 'widgets/custom_grid.dart';
import 'widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel model;
  const HomeScreen({required this.model, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.model.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: switch (widget.model.homeViewState) {
          HomeViewState.loading => const LoadingWidget(),
          HomeViewState.readyToWork => SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const HeaderWidget(),
                    Expanded(
                      child: CustomGrid(
                        movieData: widget.model.movieList,
                        onCellClicked: widget.model.onPosterClicked,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        });
  }
}
