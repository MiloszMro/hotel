import 'package:hotelapp/pages/koszyk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../models/hotel.dart';
import '../models/hotele.dart';

class HotelTitle extends StatelessWidget {
  final Hotel hotel;
  final void Function()? onTab;

  const HotelTitle({super.key, required this.hotel, this.onTab});

  void addToCart(BuildContext context, Hotel hotel){

    context.read<Restaurant>().addToCart(hotel);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTab,
          child: Container(
            color: Theme.of(context).colorScheme.tertiary,
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotel.name),
                      Text(
                        hotel.price.toString()+"0 zł", 
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: (){ addToCart(context, hotel);
                         Navigator.push(
                        context,
                         MaterialPageRoute(builder: (context) => CartPage()),
                         );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 81, 0),
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        ),
                        child: Text(
                          "Wynajmij",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 12.0, 
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(width: 15,),
                ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(hotel.imagePath, height: 120,),
                )
            
              ],
            ),
          ),
        ),

        Divider(color: Theme.of(context).colorScheme.background,)
      ],
    );
  }
}