import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Taxi Fare Calculator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Controllers for TextFields
  final TextEditingController distanceCtrl = TextEditingController();
  final TextEditingController rateCtrl = TextEditingController();
  final TextEditingController waitingCtrl = TextEditingController();
  final TextEditingController tipCtrl = TextEditingController();

  double baseFare = 0;
  double waitingCharge = 0;
  double commission = 0;

  // Calculate fare
  void calculateFare() {
    double distance = double.tryParse(distanceCtrl.text) ?? 0;
    double rate = double.tryParse(rateCtrl.text) ?? 0;
    double waiting = double.tryParse(waitingCtrl.text) ?? 0;

    baseFare = distance * rate;
    waitingCharge = waiting * rate;
    commission = (baseFare + waitingCharge) * 0.05;

    setState(() {}); // Refresh UI
  }

  // View final fare
  void viewFinalFare() {
    double tip = double.tryParse(tipCtrl.text) ?? 0;
    double finalFare = baseFare + waitingCharge - commission + tip;

    //Navigator.push(
     // context,
      //MaterialPageRoute(
       // builder: (context) => FinalFare(finalFare: finalFare),
      //),
   // );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.local_taxi, size: 70, color: Colors.amber),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Taxi Fare Calculator",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input Fields
                  TextField(
                    controller: distanceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Distance (km)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: rateCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Rate per km",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: waitingCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Waiting Time (optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: tipCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Tip (optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Fare Summary Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        row("Base Fare", baseFare),
                        const SizedBox(height: 8),
                        row("Waiting Charge", waitingCharge),
                        const SizedBox(height: 8),
                        row("Commission (5%)", commission),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Buttons
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: calculateFare,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "Calculate Fare",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: viewFinalFare,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 122, 239),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "View Final Fare",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper to show rows in summary box
  Widget row(String text, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Text("Rs. ${value.toStringAsFixed(2)}"),
      ],
    );
  }
}