import 'package:flutter/material.dart';
import 'package:megogo_prototype/app/screens/home/home_view_model.dart';
import 'package:megogo_prototype/app/theme/colors_palette.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel model;
  const HomeView({required this.model, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                  'TOP 10 MOVIES',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        widget.model.onCellClicked();
                      },
                      child: Container(
                        height: 500,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Item$index}",
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text('data'),
                          ],
                        ),
                      ),
                    );
                  },
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
