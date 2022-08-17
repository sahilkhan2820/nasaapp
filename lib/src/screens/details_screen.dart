import 'package:flutter/material.dart';
import 'package:nasa/src/models/picture.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Picture picture =
        ModalRoute.of(context)!.settings.arguments as Picture;

    return Scaffold(
        body: CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        _CustomAppBar(picture),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(picture),
          _Overview(picture),
          _Overview(picture),
          _Overview(picture),
          _Overview(picture),
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Picture picture;

  const _CustomAppBar(this.picture);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.indigo,
        expandedHeight: 200,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          centerTitle: true,
          title: Container(
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              color: Colors.black45,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Text(
                  picture.title ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              )),
          background: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(picture.getFullBackdropPath()),
          ),
        ));
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Picture picture;

  const _PosterAndTitle(this.picture);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Hero(
            tag: picture.title ?? '',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  height: 150,
                  width: 110,
                  placeholder: 'assets/images/no-image.jpg',
                  image: picture.getFullPosterImage()),
            ),
          ),
          const SizedBox(width: 12),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(picture.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  picture.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                        size: 26,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        picture.date.toString(),
                        style: TextStyle(color: Colors.blueGrey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  //final Movie movie;
  final Picture picture;

  const _Overview(this.picture);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text(
        picture.explanation ?? '',
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
      ),
    );
  }
}
