import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotelapp/themes/theme_provider.dart';
 import 'package:getwidget/getwidget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ustawienia"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)
            ),
            margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
            padding: const EdgeInsets.all(25),
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tryb Ciemny",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  ),
               
                GFToggle(
                  value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
                  onChanged: (value) =>Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                ),
              ],
            ),
          )
        ]
      ,)
    );
  }
}