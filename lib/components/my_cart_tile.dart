import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:hotelapp/models/cart_item.dart';
import 'package:hotelapp/models/hotele.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4), // Border width
                  decoration: BoxDecoration(color: Color.fromARGB(255, 255, 81, 0), shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      
                      child: Image.asset(
                        cartItem.hotel.imagePath,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
              
                  const SizedBox(width: 10,),
              
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.hotel.name),
              
                      Text(cartItem.hotel.price.toString()+'0 zł')
              
                    ],
                  ),

                  const Spacer(),
                  
                 
              
              
                ],
              ),
            )
          ],
          ),
      ),
    );
  }
}