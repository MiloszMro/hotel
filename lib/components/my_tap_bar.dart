import 'package:flutter/material.dart';
import 'package:hotelapp/models/hotel.dart';

class MyTapBar extends StatelessWidget {
final TabController tabController;

  const MyTapBar({
    super.key, 
    required this.tabController,
    });

  List<Tab> _buildCategoryTabs(){
    return HotelCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs: _buildCategoryTabs(),
      ),
    );
  }
}