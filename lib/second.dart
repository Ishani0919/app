import 'package:flutter/material.dart';
import 'second.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
  url: 'https://cysxgxirmwuqovyscylv.supabase.co',
    anonKey: 'sb_publishable_gAfr4RuI3NO-jbE-23pbTg_w_RKNNtU',
  );

  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Taxi Fare Calculator",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
  final supabase = Supabase.instance.client;

  // Controllers
  final TextEditingController distanceCtrl = TextEditingController();
  final TextEditingController rateCtrl = TextEditingController();
  final TextEditingController waitingCtrl = TextEditingController();
  final TextEditingController tipCtrl = TextEditingController();

  double baseFare = 0;
  double waitingCharge = 0;
  double commission = 0;

  int? currentId; // store selected record ID
  List<Map<String, dynamic>> fareList = []; // store all records

  @override
  void initState() {
    super.initState();
    fetchFares();
  }

  // READ
  Future<void> fetchFares() async {
    try {
      final data = await supabase.from('newDB').select();
      setState(() {
        fareList = List<Map<String, dynamic>>.from(data);
      });
      print("Fetched fares: $fareList");
    } catch (e) {
      print("Fetch error: $e");
    }
  }

  
  Future<void> saveFare() async {
    double distance = double.tryParse(distanceCtrl.text) ?? 0;
    double rate = double.tryParse(rateCtrl.text) ?? 0;
    double waiting = double.tryParse(waitingCtrl.text) ?? 0;
    double tip = double.tryParse(tipCtrl.text) ?? 0;
    double total = baseFare + waitingCharge - commission + tip;

    try {
      final response = await supabase
          .from('newDB')
          .insert({
            'distance': distance,
            'rate': rate,
            'waiting': waiting,
            'tip': tip,
            'total': total,
          })
          .select();

      if (response.isNotEmpty) {
        currentId = response[0]['id'];
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Fare saved!")));
        fetchFares();
      }
    } catch (e) {
      print("Insert error: $e");
    }
  }

  // UPDATE
  Future<void> updateFare() async {
    if (currentId == null) return;

    double distance = double.tryParse(distanceCtrl.text) ?? 0;
    double rate = double.tryParse(rateCtrl.text) ?? 0;
    double waiting = double.tryParse(waitingCtrl.text) ?? 0;
    double tip = double.tryParse(tipCtrl.text) ?? 0;
    double total = baseFare + waitingCharge - commission + tip;

    try {
      await supabase.from('newDB').update({
        'distance': distance,
        'rate': rate,
        'waiting': waiting,
        'tip': tip,
        'total': total,
      }).eq('id', currentId!);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fare updated!")));
      fetchFares();
      currentId = null;
      clearFields();
    } catch (e) {
      print("Update error: $e");
    }
  }

  //  DELETE
  Future<void> deleteFare(int id) async {
    try {
      await supabase.from('newDB').delete().eq('id', id);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fare deleted!")));
      fetchFares();
      if (currentId == id) {
        currentId = null;
        clearFields();
      }
    } catch (e) {
      print("Delete error: $e");
    }
  }

  void calculateFare() {
    double distance = double.tryParse(distanceCtrl.text) ?? 0;
    double rate = double.tryParse(rateCtrl.text) ?? 0;
    double waiting = double.tryParse(waitingCtrl.text) ?? 0;

    baseFare = distance * rate;
    waitingCharge = waiting * rate;
    commission = (baseFare + waitingCharge) * 0.05;

    setState(() {});
  }

  void clearFields() {
    distanceCtrl.clear();
    rateCtrl.clear();
    waitingCtrl.clear();
    tipCtrl.clear();
    setState(() {
      baseFare = 0;
      waitingCharge = 0;
      commission = 0;
    });
  }

  void selectRecord(Map<String, dynamic> record) {
    currentId = record['id'];
    distanceCtrl.text = record['distance'].toString();
    rateCtrl.text = record['rate'].toString();
    waitingCtrl.text = record['waiting'].toString();
    tipCtrl.text = record['tip'].toString();
    calculateFare();
  }

  void viewReceipt() {
    double tip = double.tryParse(tipCtrl.text) ?? 0;
    double finalFare = baseFare + waitingCharge - commission + tip;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalFare(
          finalFare: finalFare,
          baseFare: baseFare,
          commission: commission,
          waiting: waitingCharge,
          tip: tip,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Icon
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
              child: const Icon(
                Icons.local_taxi,
                size: 70,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Taxi Fare Calculator",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 20),

            // Input Form Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildTextField(distanceCtrl, "Distance (km)", Icons.directions_car),
                    const SizedBox(height: 12),
                    buildTextField(rateCtrl, "Rate", Icons.attach_money),
                    const SizedBox(height: 12),
                    buildTextField(waitingCtrl, "Waiting Time", Icons.timer),
                    const SizedBox(height: 12),
                    buildTextField(tipCtrl, "Tip", Icons.card_giftcard),
                    const SizedBox(height: 16),

                    // Buttons with icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.save),
                            label: const Text("Save"),
                            onPressed: () {
                              calculateFare();
                              saveFare();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.update),
                            label: const Text("Update"),
                            onPressed: updateFare,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                  
                      label: const Text("View Receipt"),
                      onPressed: viewReceipt,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                     
                      label: const Text("Clear"),
                      onPressed: clearFields,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 58, 190, 10),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Saved Fares",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Saved Fares List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: fareList.length,
              itemBuilder: (context, index) {
                final fare = fareList[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.local_taxi, color: Colors.amber),
                    title: Text(
                        "ID ${fare['id']} - Total: Rs ${fare['total'].toStringAsFixed(2)}"),
                    subtitle: Text(
                        "Distance: ${fare['distance']}, Rate: ${fare['rate']}, Waiting: ${fare['waiting']}, Tip: ${fare['tip']}"),
                    onTap: () => selectRecord(fare),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteFare(fare['id']),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build input fields with icons
  Widget buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
