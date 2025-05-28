// lib/widgets/purchase_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/web_view_screen.dart';
import '../services/user_subscription_service.dart';
// import 'webview_screen.dart';

class PurchaseButton extends StatefulWidget {
  final String subId;
  final String chosenDate;
  final double price;

  const PurchaseButton({
    Key? key,
    required this.subId,
    required this.chosenDate,
    required this.price,
  }) : super(key: key);

  @override
  State<PurchaseButton> createState() => _PurchaseButtonState();
}

class _PurchaseButtonState extends State<PurchaseButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: _isLoading ? null : _onPressed,
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                "Continue to Purchase",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Future<void> _onPressed() async {
    setState(() => _isLoading = true);

    final resp = await UserSubscriptionService.createUserSubscription(
      subId: widget.subId,
      startDate: widget.chosenDate,
      amount: widget.price,
    );

    setState(() => _isLoading = false);

    if (resp['success'] == true) {
      final paymentUrl = resp['data']['paymentUrl'] as String;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WebViewScreen(payUrl: paymentUrl),
        ),
      );
    } else {
  final message = resp['message'] ?? 'Failed to initiate payment';
  // ← guard against using a dead context
  // if (!mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
  }
}
