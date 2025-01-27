import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotelapp/components/my_button.dart';
import 'package:hotelapp/models/hotele.dart';
import 'package:hotelapp/pages/pobyt.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(); // Pole Imię
  final _surnameController = TextEditingController(); // Pole Nazwisko
  final _phoneController = TextEditingController(); // Pole Numer telefonu
  DateTime? _startDate;
  DateTime? _endDate;

  // Oblicza liczbę dni pomiędzy datami z dodaniem 1
  int get _daysBetweenWithOne {
    if (_startDate != null && _endDate != null) {
      return _endDate!.difference(_startDate!).inDays + 1;
    }
    return 0;
  }

  void _updateTotalItemCount(BuildContext context) {
    if (_startDate != null && _endDate != null) {
      final days = _daysBetweenWithOne;
      Provider.of<Restaurant>(context, listen: false).setTotalItemCount(days);
    }
  }

  void _showSuccessDialog() {
    _updateTotalItemCount(context); // Aktualizacja przed pokazaniem dialogu
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Składanie zamówienia"),
          content: const Text("Zamówienie zostało zrealizowane"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeliveryPage(),
                  ),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _processPayment() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Proszę wybrać datę wynajmu od i do.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Aktualizacja danych w Provider
      final restaurant = Provider.of<Restaurant>(context, listen: false);
      restaurant.customerName = _nameController.text;
      restaurant.customerSurname = _surnameController.text;
      restaurant.customerPhone = _phoneController.text;
      restaurant.rentalStartDate = _startDate;
      restaurant.rentalEndDate = _endDate;

      _updateTotalItemCount(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Składanie zamówienia...'),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        _showSuccessDialog();
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime initialDate = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? DateTime.now());
    final DateTime firstDate = DateTime(2000);
    final DateTime lastDate = DateTime(2101);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null; 
          }
        } else {
          _endDate = picked;
        }
      });
      _updateTotalItemCount(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Zamówienie"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Dane',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Imię',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać imię';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Nazwisko',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać nazwisko';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Numer telefonu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę podać numer telefonu';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  TextButton(
                    onPressed: () => _selectDate(context, true),
                    child: Text(
                      _startDate == null
                          ? "Wybierz datę od"
                          : "${_startDate!.toLocal()}".split(' ')[0],
                    ),
                  ),
                  Text(" - "),
                  TextButton(
                    onPressed: () => _selectDate(context, false),
                    child: Text(
                      _endDate == null
                          ? "Wybierz datę do"
                          : "${_endDate!.toLocal()}".split(' ')[0],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                _startDate != null && _endDate != null
                    ? 'Liczba dni: ${_daysBetweenWithOne}'
                    : 'Wybierz daty wynajmu',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: Consumer<Restaurant>(
                    builder: (context, restaurant, child) =>
                        Text(restaurant.displayCardReceipt()),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: MyButton(
                  onTap: _processPayment,
                  text: 'Zapłać',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
