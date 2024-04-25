import 'package:flutter/material.dart';

import '../../../theme/colors_palette.dart';

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
           Divider( color: secondaryColor,),
           Center(
            child: Text(
              'TOP MOVIES',
              style: TextStyle(
                   color: secondaryColor,
                  fontSize: 48,
                  fontWeight: FontWeight.bold),
            ),
          ),
           Divider(
            color: secondaryColor,
          )
          ,
        ],
      ),
    );
  }
}
