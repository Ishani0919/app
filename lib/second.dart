import 'package:flutter/material.dart';

class FinalFare extends StatelessWidget {
  final double finalFare;
  final double baseFare;
  final double commission;
  final double waiting;
  final double tip;

  const FinalFare({
    super.key,
    required this.finalFare,
    required this.baseFare,
    required this.commission,
    required this.waiting,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Taxi Receipt"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gradient Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(25)),
                    gradient: const LinearGradient(
                      colors: [Colors.amber, Colors.orangeAccent],
                    ),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.local_taxi, size: 60, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        "Taxi Fare Receipt",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Breakdown
                      fareRow(Icons.money, "Base Fare", baseFare, Colors.blue),
                      fareRow(Icons.timer, "Waiting Charge", waiting, Colors.orange),
                      fareRow(Icons.monetization_on, "Tip", tip, Colors.green),
                      fareRow(Icons.percent, "Commission (5%)", commission, Colors.red),

                      const Divider(height: 40, thickness: 2),

                      // Total Fare
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Fare",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rs. ${finalFare.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.done),
                          label: const Text(
                            "Done",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fareRow(IconData icon, String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 18,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            "Rs. ${value.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
