import 'package:flutter/material.dart';
import 'second.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FareCalculator(),
=======
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
<<<<<<< HEAD
=======
        title: Text("App1"),
        
      ),
     
>>>>>>> a2895f7d7dad5497280bc18fe720a04dc476e1e4
=======
>>>>>>> SEU_IS_20_ICT_007
>>>>>>> 42b822008295a2d4dbfc0bfdd9c707c5f28c9b1a
    );
  }
}

<<<<<<< HEAD
class FareCalculator extends StatefulWidget {
  const FareCalculator({super.key});

  @override
  State<FareCalculator> createState() => _FareCalculatorState();
}

class _FareCalculatorState extends State<FareCalculator> {
=======
class HEAD {
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Controllers for TextFields
>>>>>>> 42b822008295a2d4dbfc0bfdd9c707c5f28c9b1a
  final TextEditingController distanceCtrl = TextEditingController();
  final TextEditingController rateCtrl = TextEditingController();
  final TextEditingController waitingCtrl = TextEditingController();
  final TextEditingController tipCtrl = TextEditingController();

  double baseFare = 0;
  double waitingCharge = 0;
  double commission = 0;

  void calculate() {
    double distance = double.tryParse(distanceCtrl.text) ?? 0;
    double rate = double.tryParse(rateCtrl.text) ?? 0;
    double waiting = double.tryParse(waitingCtrl.text) ?? 0;

    baseFare = distance * rate;
    waitingCharge = waiting * rate;
    commission = (baseFare + waitingCharge) * 0.05;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taxi Fare Calculator"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_taxi, size: 80, color: Colors.amber),
                    const SizedBox(height: 10),
                    const Text(
                      "Taxi Fare Calculator",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller: distanceCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Distance (km)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: rateCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Rate per km",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: waitingCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Waiting Time",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: tipCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Tip",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          row("Base Fare", baseFare),
                          row("Waiting Charge", waitingCharge),
                          row("Commission (5%)", commission),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: calculate,
                        child: const Text("Calculate Fare"),
                      ),
                    ),
                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          double tip = double.tryParse(tipCtrl.text) ?? 0;

                          double finalFare =
                              baseFare + waitingCharge + tip - commission;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FinalFare(
                                finalFare: finalFare,
                                baseFare: baseFare,
                                waiting: waitingCharge,
                                tip: tip,
                                commission: commission,
                              ),
                            ),
                          );
                        },
                        child: const Text("View Final Fare"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget row(String text, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text("Rs. ${value.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}