import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zjcwhjdeljaygjulvgcx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpqY3doamRlbGpheWdqdWx2Z2N4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ4MTA2MzQsImV4cCI6MjA3MDM4NjYzNH0.nWYO8lN8dzg2cn19ghj4VCdNnTDA1p9F7PHxkGEJ2ik',
  );
  runApp(MockBankApp());
}

class MockBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mock Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryGreen,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: TextTheme(
          titleLarge: AppTextStyles.heading,  
          bodyMedium: TextStyle(fontSize: 16), 
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 0.0;
  List<Map<String, dynamic>> transactions = [];
  bool isLoading = true;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    const userId = '22222222-2222-2222-2222-222222222222';

    final accountResponse = await supabase
        .from('accounts')
        .select()
        .eq('user_id', userId)
        .eq('status', 'active')
        .limit(1)
        .maybeSingle();

    if (accountResponse == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final account = accountResponse;
    final accountId = account['id'] as String;
    final accountBalance = (account['balance'] as num).toDouble();

    final txnResponse = await supabase
        .from('transactions')
        .select()
        .eq('account_id', accountId)
        .order('created_at', ascending: false)
        .limit(5);

    if (txnResponse == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    setState(() {
      balance = accountBalance;
      transactions = List<Map<String, dynamic>>.from(txnResponse);
      isLoading = false;
    });
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.cardBackground,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppSpacing.lg, horizontal: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Balance",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              "\$${balance.toStringAsFixed(2)}",
              style: AppTextStyles.balance,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, dynamic> txn) {
    final amount = txn['amount'].toString();
    final isPositive = txn['type'] == 'deposit' || txn['type'] == 'transfer';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            isPositive ? AppColors.positive.withOpacity(0.2) : AppColors.negative.withOpacity(0.2),
        child: Icon(
          isPositive ? Icons.arrow_downward : Icons.arrow_upward,
          color: isPositive ? AppColors.positive : AppColors.negative,
        ),
      ),
      title: Text(
        txn['description'] ?? 'No description',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        '${isPositive ? '+' : '-'}\$${amount}',
        style: isPositive ? AppTextStyles.positiveAmount : AppTextStyles.negativeAmount,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mock Bank"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBalanceCard(),
                  SizedBox(height: AppSpacing.lg),
                  Text("Recent Transactions", style: AppTextStyles.heading),
                  SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: transactions.isEmpty
                        ? Center(child: Text("No transactions found"))
                        : Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: ListView.separated(
                              separatorBuilder: (_, __) => Divider(height: 1),
                              itemCount: transactions.length,
                              itemBuilder: (context, index) =>
                                  _buildTransactionTile(transactions[index]),
                            ),
                          ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatbotScreen()),
                        );
                      },
                      icon: Icon(Icons.chat, color: Colors.white),  // set icon color white
                      label: Text(
                        "Ask AI Chatbot",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,  // set text color white
                        ),
                      ),
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



