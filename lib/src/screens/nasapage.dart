import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/pictures_provider.dart';
import '../widgets/constants.dart';
import 'nasalist.dart';

class NasaScreen extends StatelessWidget {
  const NasaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PicturesProvider picturesProvider = Provider.of<PicturesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('NASA App'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              NasaList(pictures: picturesProvider.listPicturesPlaying)
            ],
          ),
        ));
  }
}
