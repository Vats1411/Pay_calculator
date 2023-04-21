import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: HomeScreen(),
));

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  double hoursWorked = 0.0 ;
  double hourlyRate = 0.0 ;
  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;
  String studentName = "Vatsal Patel";
  String studentID = "300874931";



  void calculatePay() {
    final form = _formKey.currentState;
    if (form?.validate() == true) {
      form?.save();
      if (hoursWorked <= 40) {
        regularPay = hoursWorked * hourlyRate;
        overtimePay = 0;
      } else {
        regularPay = 40 * hourlyRate;
        overtimePay = (hoursWorked - 40) * hourlyRate * 1.5;
      }
      totalPay = regularPay + overtimePay;
      tax = (totalPay * 0.18).roundToDouble();;
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Number of Hours Worked'),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Please enter a value';
                }
                if (double.tryParse(value ?? "") == null) {
                  return 'Please enter a valid number';
                }
                if (double.parse(value ?? "") <= 0) {
                  return 'Please enter a value greater than 0';
                }
                return null;
              },
              onSaved: (value) => hoursWorked = double.parse(value ?? ""),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Hourly Rate'),
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return 'Please enter a value';
                }
                if (double.tryParse(value ?? "") == null) {
                  return 'Please enter a valid number';
                }
                if (double.parse(value ?? "") <= 0) {
                  return 'Please enter a value greater than 0';
                }
                return null;
              },
              onSaved: (value) => hourlyRate = double.parse(value ?? "0"),
            ),
            ElevatedButton(
                child: Text('Calculate'),
                onPressed: calculatePay
            ),
            Container(
              color: Color.fromARGB(255, 239, 160, 70),
              padding: EdgeInsets.fromLTRB(50, 10, 50, 50),
              //padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.all(60.0),
              child: Column(
                children: [
                  const Text(
                    'REPORT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Regular Pay = \$$regularPay',
                    style: const TextStyle(
                        fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Overtime Pay = \$$overtimePay',
                    style: const TextStyle(
                        fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total Pay = \$$totalPay',
                    style: const TextStyle(
                        fontSize: 15),

                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tax = \$$tax',
                    style: const TextStyle(
                        fontSize: 15),
                  ),
                ],
              ),

            ),
            Container(
              color: Color.fromARGB(255, 187, 157, 220),
              padding: EdgeInsets.fromLTRB(50, 10, 50, 50),
              child: Column(
                children: <Widget>[
                  Text('About'),
                  SizedBox(height: 8),
                  Text('Student Name: $studentName'),
                  Text('Student ID: $studentID'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
