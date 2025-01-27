import 'package:hotelapp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotelapp/components/my_button.dart';
import 'package:hotelapp/components/my_cart_tile.dart';
import 'package:hotelapp/models/hotele.dart';
import 'package:hotelapp/pages/p%C5%82atnosc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurat, child) {
        final userCart = restaurat.cart;

        return Scaffold(
          body: Column(
            children: [
              
              Expanded(
                flex: 2,
                child: Container(),
              ),

              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Icon(Icons.star, color: Colors.amber, size: 32.0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              
              Expanded(
                flex: 3,
                child: userCart.isEmpty 
                    ? Center(child: Text("Brak zamówień..."))
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          final cartItem = userCart[index];
                          return ListTile(
                            title: MyCartTile(cartItem: cartItem),
                          );
                        },
                      ),
              ),

            
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Czy na pewno chcesz anulować wynajem?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Anuluj"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  restaurat.clearCart();

                                 
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                    (route) => false, 
                                  );
                                },
                                child: const Text("Wyczyść"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: MyButton(
                      text: "Wynajmij",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentPage(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
