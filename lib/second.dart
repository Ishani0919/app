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
    this.baseFare = 0,
    this.commission = 0,
    this.waiting = 0,
    this.tip = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taxi Receipt"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: Colors.white,
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon and Title
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.local_taxi,
                              size: 70,
                              color: Colors.amber.shade700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Taxi Fare Receipt",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Fare Details
                    Text("Base Fare: Rs. $baseFare"),
                    Text("Commission: Rs. $commission"),
                    Text("Waiting Charge: Rs. $waiting"),
                    Text("Tip: Rs. $tip"),

                    const Divider(height: 30, thickness: 2),

                    Center(
                      child: Text(
                        "Total Fare: Rs. $finalFare",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
}
