class Hotel {
final String name;
final String imagePath;
final double price;
final HotelCategory category;

  Hotel({
    required this.name, 
    required this.imagePath, 
    required this.price,
    required this.category,
  });

}

enum HotelCategory{
  warszawa,
  poznan,
  gdansk,
  krakow,
  wroclaw
}