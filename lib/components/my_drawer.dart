import 'package:flutter/material.dart';
import 'package:hotelapp/components/my_drawer_tile.dart';
import 'package:hotelapp/pages/ustawienia.dart';
import 'package:hotelapp/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    final authService = AuthService();
    authService.singOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Text(
              "hotelapp",
              style: TextStyle(
                fontSize: 50,
                color: Color.fromARGB(255, 255, 81, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(),
          ),

          MyDrawerTile(
            text: "H O M E", 
            icon: Icons.home, 
            onTap: () => Navigator.pop(context),
          ),
           MyDrawerTile(
            text: "U S T A W I E N I A", 
            icon: Icons.settings, 
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage() ),);
            }
          ),

          const Spacer(),

           MyDrawerTile(
            text: "W Y L O G U J", 
            icon: Icons.logout, 
            onTap: logout,
          ),

          const SizedBox(height: 25),

        ],
      ),
    );
  }
}