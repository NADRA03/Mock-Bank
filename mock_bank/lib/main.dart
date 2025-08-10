import 'package:flutter/material.dart';
import 'dart:async';
import 'styles.dart';  

void main() {
  runApp(MockBankApp());
}

class MockBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mock Bank',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 12345.67;
  List<Map<String, String>> transactions = [
    {"title": "Coffee Shop", "amount": "-\$4.50"},
    {"title": "Salary", "amount": "+\$2000.00"},
    {"title": "Online Store", "amount": "-\$120.99"},
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        balance += ([-50, -20, 15, 30, 100]..shuffle()).first;
        transactions.insert(0, {
          "title": "Random Transaction",
          "amount":
              "\$${(5 + (20 * (0.5 - (DateTime.now().second % 2)))).toStringAsFixed(2)}",
        });
        if (transactions.length > 5) transactions.removeLast();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mock Bank"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Balance", style: AppTextStyles.heading),
            SizedBox(height: AppSpacing.sm),
            Text(
              "\$${balance.toStringAsFixed(2)}",
              style: AppTextStyles.balance,
            ),
            SizedBox(height: AppSpacing.lg),
            Text("Recent Transactions", style: AppTextStyles.heading),
            SizedBox(height: AppSpacing.sm),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final txn = transactions[index];
                  return ListTile(
                    title: Text(txn["title"]!),
                    trailing: Text(
                      txn["amount"]!,
                      style: txn["amount"]!.startsWith("+")
                          ? AppTextStyles.positiveAmount
                          : AppTextStyles.negativeAmount,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppSpacing.md),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatbotScreen()),
                  );
                },
                icon: Icon(Icons.chat),
                label: Text("Ask AI Chatbot"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatbotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Chatbot")),
      body: Center(
        child: Text(
          "AI Chatbot Coming Soon 🤖",
          style: AppTextStyles.heading,
        ),
      ),
    );
  }
}

