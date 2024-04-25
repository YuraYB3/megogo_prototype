import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/home/home_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';
import 'package:megogo_prototype/domain/movie/imovie.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const HeaderWidget(),
              Expanded(
                child: StreamBuilder<List<IMovie>>(
                  stream: widget.model.movieStreamList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "ERROR${snapshot.error}",
                          style:  TextStyle(
                              color: secondaryColor, fontSize: 24),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        ),
                      );
                    }
                    final List<IMovie> movieData = snapshot.data!;
                    return CustomGrid(
                      movieData: movieData,
                      onCellClicked: widget.model.onCellClicked,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
