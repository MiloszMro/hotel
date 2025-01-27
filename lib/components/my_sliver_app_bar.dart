import 'package:flutter/material.dart';
import 'package:hotelapp/pages/koszyk.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget title;

  const MySliverAppBar({
    super.key, 
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      collapsedHeight: 90,
      floating: false,
      pinned: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage(),));
          }, 
          icon: const Icon(
            Icons.hotel, 
            size: 30, 
            ),),
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text("HotelApp",),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom:  1.0),
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0,top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}