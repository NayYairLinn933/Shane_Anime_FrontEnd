import 'package:flutter/material.dart';

class HotTitle extends StatelessWidget {
  const HotTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Hot Mangas",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              "more",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
