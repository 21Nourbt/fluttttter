import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../services/subscription_service.dart';
import '../widgets/plan_card.dart';
import 'select_dates_screen.dart';
import './main_layout.dart';

class ChoosePlanScreen extends StatefulWidget {
  @override
  _ChoosePlanScreenState createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  List<Subscription> subscriptions = [];
  bool isLoading = true;
  int selectedIndex = 0;
  int activeTab = 0; // 0: Office, 1: Meeting Room, 2: OpenSpace
  String? error;

  final List<String> roomTypes = ['office', 'meeting room', 'openspace'];
  final List<String> defaultDescription = [
    "7/7 Access",
    "Wi-Fi",
    "Kitchen Access",
    "Coffee (extra)",
    "Printer access"
  ];

  @override
  void initState() {
    super.initState();
    loadSubscriptions(); // initial load
  }

  Future<void> loadSubscriptions() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final type = roomTypes[activeTab];
      final fetched =
          await SubscriptionService.fetchSubscriptionsByRoomType(type);
      setState(() {
        subscriptions = fetched;
        isLoading = false;
        selectedIndex = 0;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MainLayout(
  //     currentIndex: 0,
  //     child: SafeArea(
  //       child: Column(
  //         children: [
  //           _buildAppBar(),
  //           _buildTabs(),
  //           SizedBox(height: 24),
  //           Expanded(
  //             child: isLoading
  //                 ? Center(child: CircularProgressIndicator())
  //                 : error != null
  //                     ? _buildErrorDisplay()
  //                     : _buildSubscriptionList(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildTabs(),
            SizedBox(height: 24),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : error != null
                      ? _buildErrorDisplay()
                      : _buildSubscriptionList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Choose your Plan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(width: 36),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildTab(0, "Office Room"),
          _buildTab(1, "Meeting Room"),
          _buildTab(2, "OpenSpace"),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isActive = activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => activeTab = index);
          loadSubscriptions();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorDisplay() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
          SizedBox(height: 16),
          Text('Unable to load plans',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Text(error!, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildSubscriptionList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Available Plans",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];
                final isOpenSpace = roomTypes[activeTab] == 'openspace';
                final useDefaultDescription =
                    isOpenSpace && (subscription.description.isEmpty);

                final List<String> features = useDefaultDescription
                    ? defaultDescription
                    : subscription.description;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildPlanCard(
                    index,
                    subscription.Name,
                    features,
                    "${subscription.price} TND",
                    subscription.subscriptionType,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildPlanCard(int index, String title, List<String> features,
      String price, String duration) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Color.fromARGB(255, 60, 247, 235)
                : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color:
                          Color.fromARGB(255, 60, 247, 235).withOpacity(0.15),
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ]
              : [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: Offset(0, 2))
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Color.fromARGB(255, 60, 247, 235)
                        : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? Color.fromARGB(255, 60, 247, 235)
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                SizedBox(width: 12),
                Text(title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(price,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text(duration.toLowerCase(),
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text("• ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 60, 247, 235))),
                      Expanded(
                          child: Text(feature.trim(),
                              style: TextStyle(fontSize: 14))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {
          final selected = subscriptions[selectedIndex];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectDatesScreen(
                roomType: selected.Name,
                duration: selected.subscriptionType,
                price: selected.price.toDouble(),
                id: selected.id,
              ),
            ),
          );
        },
        child: Text(
          "Continue to Purchase",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
