
import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  const SongTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.audio,
      required this.onTap
      });

  final String title;
  final String subTitle;
  final String image;
  final String audio;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap  ,
        leading: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(image),
        ),
        title: Text(title),
        subtitle: Text(subTitle),
        trailing: const Icon(Icons.play_arrow),
      ),
    );
  }
}
