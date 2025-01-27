import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotelapp/components/my_drawer.dart';
import 'package:hotelapp/components/my_hotel_title.dart';
import 'package:hotelapp/components/my_sliver_app_bar.dart';
import 'package:hotelapp/components/my_tap_bar.dart';
import 'package:hotelapp/models/hotel.dart';
import 'package:hotelapp/models/hotele.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: HotelCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  List<Hotel> _filterMenuByCategory(HotelCategory category, List<Hotel> fullMenu) {
    return fullMenu.where((hotel) => hotel.category == category).toList();
  }

  List<Widget> getHotelTabs(List<Hotel> fullMenu) {
    return HotelCategory.values.map((category) {
      List<Hotel> categoryMenu = _filterMenuByCategory(category, fullMenu);


      return SingleChildScrollView(
        child: Column(
          children: categoryMenu.map((hotel) {
            return HotelTitle(
              hotel: hotel,
              onTab: () {},
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTapBar(tabController: _tabController),
          ),
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) => TabBarView(
            controller: _tabController,
            children: getHotelTabs(restaurant.menu),
          ),
        ),
      ),
    );
  }
}
