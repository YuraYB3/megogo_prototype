import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/common/widgets/cached_image.dart';
import 'package:megogo_prototype/app/screens/home/home_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';
import 'package:megogo_prototype/domain/movie/imovie.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel model;
  const HomeView({required this.model, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Divider(),
              const Center(
                child: Text(
                  'TOP MOVIES',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Expanded(
                child: StreamBuilder<List<IMovie>>(
                  stream: widget.model.movieStreamList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return  Center(
                        child: Text("ERROR${snapshot.error}", style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24
                        ),),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    final List<IMovie> movieData = snapshot.data!;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: movieData.length,
                      itemBuilder: (context, index) {
                        final IMovie movie = movieData[index];
                        return GestureDetector(
                          onTap: () {
                            widget.model.onCellClicked();
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: CachedImageWidget(
                                    imageUrl: movie.poster,
                                    height:
                                        MediaQuery.of(context).size.height * 0.25,
                                    shape: BoxShape.rectangle,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                )
                              ]),
                        );
                      },
                      padding: const EdgeInsets.all(8.0),
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
