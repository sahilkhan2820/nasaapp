import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/picture.dart';
import '../providers/pictures_provider.dart';
import '../widgets/constants.dart';

class NasaList extends StatelessWidget {
  List<Picture> pictures;

  NasaList({Key? key, required this.pictures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    if (pictures.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: deviceSize.height * 0.6,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.lime,
          ),
        ),
      );
    }

    return NasaWidget(deviceSize: deviceSize, pictures: pictures);
  }
}

class NasaWidget extends StatelessWidget {
  const NasaWidget({
    Key? key,
    required this.deviceSize,
    required this.pictures,
  }) : super(key: key);

  final Size deviceSize;
  final List<Picture> pictures;

  @override
  Widget build(BuildContext context) {
    PicturesProvider picturesProvider =
        Provider.of<PicturesProvider>(context, listen: false);
    picturesProvider.loadcontroller();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: deviceSize.height,
          child: GridView.builder(
            itemCount: pictures.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
            itemBuilder: (BuildContext context, int index) {
              final picture = pictures[index];
              //    picture.id = 'swiper-${picture.id}' ;
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'details', arguments: picture);
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            child: Hero(
                              tag: picture.title ?? '',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/no-image.jpg',
                                  image: picture.getFullPosterImage(),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            // Add from this line
                            child: Container(
                          height: 200,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(picture.title ?? '',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Expanded(
                                  child: Text(picture.explanation ?? '',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)))
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
