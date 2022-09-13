import 'package:flutter/material.dart';
import 'package:news_app/models/components/components.dart';

import '../../models/components/constants.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        foregroundColor: kPrimaryColor,
      ),
      body: Center(
        child: showText(text: 'coming soon', size: 16, textColor: kBlack),
      ),
    );
  }
}
