import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const Divider( color: Colors.teal,),
          const Center(
            child: Text(
              'TOP MOVIES',
              style: TextStyle(
                   color: Colors.teal,
                  fontSize: 48,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            color: Colors.teal,
          )
          ,
        ],
      ),
    );
  }
}
