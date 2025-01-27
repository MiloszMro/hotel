import 'package:hotelapp/models/hotel.dart';


class CartItem {
  Hotel hotel;
  int quantity;

  CartItem({
    required this.hotel,
    this.quantity = 1,
  });

  double get totalPrice {
    return (hotel.price) * quantity;
  }
}