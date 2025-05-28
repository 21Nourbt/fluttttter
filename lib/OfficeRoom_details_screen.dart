import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'web_view_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class OfficeRoomReservationScreen extends StatefulWidget {
  final Map<String, dynamic> room;
  final List<Map<String, dynamic>> reservations;

  const OfficeRoomReservationScreen({
    Key? key,
    required this.room,
    required this.reservations,
  }) : super(key: key);

  @override
  _OfficeRoomReservationScreenState createState() =>
      _OfficeRoomReservationScreenState();
}

class _OfficeRoomReservationScreenState
    extends State<OfficeRoomReservationScreen> {
  DateTime get nowInTunisia =>
      DateTime.now().toUtc().add(const Duration(hours: 1));

  late SharedPreferences prefs;
  String? userId;
  DateTime? selectedDate;
  String? checkInTime;
  String? checkOutTime;
  DateTime focusedDay = DateTime.now().toUtc().add(const Duration(hours: 1));

  List<Map<String, dynamic>> reservations = [];
  bool isLoading = false;
  String paymentMethod = 'points';
  int userPoints = 0;
  int totalPrice = 0;
  final List<String> _allTimeSlots = [];
  int _currentStep = 0;
  final PageController _pageController = PageController();

  final List<Color> _colorScheme = [
    const Color(0xFF1ED8C6), // Primary (from logo)
    const Color(0xFFFFFFFF), // Background (white)
    const Color(0xFF000000), // Text (black)
    const Color(0xFF718096), // Light Text (unchanged, you can adjust this)
  ];

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
    _initializePreferences();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    print(widget.reservations);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initializePreferences() async {
    setState(() => isLoading = true);
    prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    setState(() {
      if (userJson != null) {
        final userMap = jsonDecode(userJson);
        userId = userMap['_id'];
        print('User ID: $userId');
      }
      isLoading = false;
    });
    if (userId != null) {
      await _fetchUserPoints();
    }
  }

  void _generateTimeSlots() {
    _allTimeSlots.clear();
    for (int h = 8; h < 24; h++) {
      _allTimeSlots.add('${h.toString().padLeft(2, '0')}:00');
      _allTimeSlots.add('${h.toString().padLeft(2, '0')}:30');
    }
  }

  int _timeToMinutes(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  String _minutesToTime(int minutes) {
    final h = (minutes ~/ 60).toString().padLeft(2, '0');
    final m = (minutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> _fetchReservationsForDate(DateTime date) async {
    setState(() {
      isLoading = true;
      reservations = [];
      checkInTime = null;
      checkOutTime = null;
      totalPrice = 0;
    });

    try {
      final resp = await http.get(
        Uri.parse('http://localhost:8000/ELACO/booking/getReservation'),
        headers: {'Content-Type': 'application/json'},
      );

      if (resp.statusCode == 200) {
        final decoded = json.decode(resp.body);
        List<Map<String, dynamic>> allReservations = [];

        if (decoded['data'] is List && decoded['data'].isNotEmpty) {
          if (decoded['data'][0] is List) {
            allReservations =
                List<Map<String, dynamic>>.from(decoded['data'][0]);
          } else {
            allReservations = List<Map<String, dynamic>>.from(decoded['data']);
          }
        }

        setState(() {
          reservations = allReservations.where((res) {
            final resDateStr = res['date'].toString().split('T')[0];
            final resDate = DateTime.parse(resDateStr);
            return resDate == DateTime(date.year, date.month, date.day);
          }).toList();
        });
      }
    } catch (e) {
      _showErrorSnackBar('Failed to load reservations');
    }
    setState(() => isLoading = false);
  }

  bool _isRangeAvailable(int start, int end) {
    for (final reservation in reservations) {
      final resStart = _timeToMinutes(reservation['check_in']);
      final resEnd = _timeToMinutes(reservation['check_out']);
      if (start < resEnd && end > resStart) return false;
    }
    return true;
  }

  List<String> get availableTimeSlots {
    if (selectedDate == null) return [];

    // Tunisia timezone
    final nowInTunisia = DateTime.now().toUtc().add(const Duration(hours: 1));
    final tunisiaSelectedDate =
        selectedDate!.toUtc().add(const Duration(hours: 1));

    // Calculate starting minute
    int startingMinutes;
    if (nowInTunisia.year == tunisiaSelectedDate.year &&
        nowInTunisia.month == tunisiaSelectedDate.month &&
        nowInTunisia.day == tunisiaSelectedDate.day) {
      // Today -> Start from next 30 min
      startingMinutes =
          ((nowInTunisia.hour * 60 + nowInTunisia.minute) ~/ 30 + 1) * 30;
    } else {
      // Future date -> Start from 8:00 (8 * 60 = 480)
      startingMinutes = 8 * 60;
    }

    return _allTimeSlots.where((slot) {
      final slotMinutes = _timeToMinutes(slot);

      if (slotMinutes < startingMinutes)
        return false; // ✅ Skip before startingMinutes

      for (final reservation in widget.reservations) {
        final resDateUtc = DateTime.parse(reservation['date']);
        final resDateTunisia = resDateUtc.toUtc().add(const Duration(hours: 1));

        if (resDateTunisia.year == tunisiaSelectedDate.year &&
            resDateTunisia.month == tunisiaSelectedDate.month &&
            resDateTunisia.day == tunisiaSelectedDate.day) {
          final resStart = _timeToMinutes(reservation['check_in']);
          final resEnd = _timeToMinutes(reservation['check_out']);
          if (slotMinutes >= resStart && slotMinutes < resEnd) {
            return false; // Slot is reserved
          }
        }
      }
      return true; // Slot is available
    }).toList();
  }

  List<String> get availableCheckOutSlots {
    if (checkInTime == null) return [];

    final checkInMinutes = _timeToMinutes(checkInTime!);
    List<String> valid = [];

    for (int i = checkInMinutes + 30; i <= 1440; i += 30) {
      if (i - checkInMinutes < 60) continue;

      bool isAvailable = true;

      for (final reservation in widget.reservations) {
        // ✅ Adjust reservation date to Tunisia timezone
        final resDateUtc = DateTime.parse(reservation['date']);
        final resDateTunisia = resDateUtc
            .toUtc()
            .add(const Duration(hours: 1)); // Correct to Tunisia

        if (resDateTunisia.year == selectedDate!.year &&
            resDateTunisia.month == selectedDate!.month &&
            resDateTunisia.day == selectedDate!.day) {
          final resStart = _timeToMinutes(reservation['check_in']);
          final resEnd = _timeToMinutes(reservation['check_out']);

          if (i > resStart && checkInMinutes < resEnd) {
            isAvailable = false;
            break;
          }
        }
      }

      if (isAvailable) {
        valid.add(_minutesToTime(i));
      } else {
        break;
      }
    }

    return valid;
  }

  void _calculatePrice() {
    if (checkInTime == null || checkOutTime == null) {
      setState(() => totalPrice = 0);
      return;
    }

    final start = _timeToMinutes(checkInTime!);
    final end = _timeToMinutes(checkOutTime!);
    final durationHours = (end - start) / 60;
    print("hi0");
    print(widget.room);
    print("object");
    print(widget.room["numTable"]);

    final prices = widget.room['prices'];
    try {
      if (prices is List && prices.isNotEmpty) {
        final prices = widget.room['prices'] as List;
        final hourly =
            (prices.firstWhere((p) => p['duration'] == '1h')['price'] as num)
                .toInt();

        int price;
        if (durationHours == 2) {
          price =
              (prices.firstWhere((p) => p['duration'] == '2h')['price'] as num)
                  .toInt();
        } else if (durationHours == 5) {
          price = (prices.firstWhere(
                  (p) => p['duration'] == '1/2 Day (5h)')['price'] as num)
              .toInt();
        } else {
          price = (durationHours * hourly).round();
        }

        setState(() => totalPrice = price);
      } else if (widget.room["Name"] == "Open space") {
        int price = (durationHours * 1.5).round();
        setState(() => totalPrice = price);
      } else {
        int price = (durationHours * 5).round();
        setState(() => totalPrice = price);
      }
    } catch (e) {
      setState(() => totalPrice = 0);
    }
  }

  Future<void> _fetchUserPoints() async {
    if (userId == null) return;
    setState(() => isLoading = true);
    try {
      final resp = await http.get(
        Uri.parse('http://localhost:8000/ELACO/Points/$userId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body);
        if (data is Map && data.containsKey('points')) {
          setState(() => userPoints = (data['points'] as num).toInt());
        }
      }
    } catch (e) {
      _showErrorSnackBar('Failed to load user points');
    }
    setState(() => isLoading = false);
  }

  // void _showErrorSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       backgroundColor: Colors.red[700],
  //       behavior: SnackBarBehavior.floating,
  //       margin: const EdgeInsets.all(16),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //     ),
  //   );
  // }

  void _showErrorSnackBar(String message) {
    // if (!mounted) return; // ← guard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorScheme[1],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Room Reservation',
          style: TextStyle(
            color: _colorScheme[2],
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios_new, color: _colorScheme[2], size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading && userId == null
          ? Center(
              child: CircularProgressIndicator(
                color: _colorScheme[2],
              ),
            )
          : Column(
              children: [
                // Progress indicator
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStepIndicator(0, 'Details'),
                      _buildProgressLine(0),
                      _buildStepIndicator(1, 'Payment'),
                      _buildProgressLine(1),
                      _buildStepIndicator(2, 'Confirm'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Main content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildReservationDetailsStep(),
                      _buildPaymentMethodStep(),
                      _buildConfirmationStep(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProgressLine(int step) {
    return Container(
      width: 40,
      height: 2,
      color: _currentStep > step ? _colorScheme[2] : Colors.grey[300],
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    bool isCompleted = _currentStep > step;
    bool isCurrent = _currentStep == step;

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color:
                isCompleted || isCurrent ? _colorScheme[2] : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    '${step + 1}',
                    style: TextStyle(
                      color: isCurrent ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isCurrent ? _colorScheme[2] : _colorScheme[3],
            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildReservationDetailsStep() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room info card
              // _buildRoomInfoCard(),
              // const SizedBox(height: 24),

              // Calendar section
              _buildSectionHeader('Select Date'),
              _buildCalendarCard(),
              const SizedBox(height: 24),

              // Time selection
              _buildSectionHeader('Select Time'),
              _buildTimeSelectionCard(),
              const SizedBox(height: 40),

              // Next button
              _buildNextButton(
                  isEnabled: selectedDate != null &&
                      checkInTime != null &&
                      checkOutTime != null,
                  onPressed: _nextStep),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _colorScheme[2],
        ),
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          TableCalendar(
            firstDay: nowInTunisia,
            lastDay: nowInTunisia.add(const Duration(days: 365)),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (day, focus) async {
              setState(() {
                focusedDay = focus;
                selectedDate = day;
              });
              await _fetchReservationsForDate(day);
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: _colorScheme[2],
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: _colorScheme[2].withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _colorScheme[2],
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: _colorScheme[2]),
              rightChevronIcon:
                  Icon(Icons.chevron_right, color: _colorScheme[2]),
            ),
          ),
          if (selectedDate != null)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Text(
                'Selected: ${DateFormat('EEEE, MMM d, yyyy').format(selectedDate!)}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: _colorScheme[2],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimeSelectionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The two dropdowns side by side
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-in time',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _colorScheme[2],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDropdown(
                      value: checkInTime,
                      hint: 'Start time',
                      items: availableTimeSlots,
                      onChanged: (v) {
                        setState(() {
                          checkInTime = v;
                          checkOutTime = null;
                          _calculatePrice();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16), // space between them
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-out time',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _colorScheme[2],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDropdown(
                      value: checkOutTime,
                      hint: 'End time',
                      items: availableCheckOutSlots,
                      onChanged: (v) {
                        setState(() {
                          checkOutTime = v;
                          _calculatePrice();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Duration info under them
          if (checkInTime != null && checkOutTime != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 18, color: _colorScheme[3]),
                  const SizedBox(width: 8),
                  Text(
                    'Duration: ${_calculateDuration()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: _colorScheme[3],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _calculateDuration() {
    if (checkInTime == null || checkOutTime == null) return '';

    final start = _timeToMinutes(checkInTime!);
    final end = _timeToMinutes(checkOutTime!);
    final durationMinutes = end - start;

    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;

    if (minutes == 0) {
      return hours == 1 ? '1 hour' : '$hours hours';
    } else {
      return '$hours hour${hours != 1 ? "s" : ""} $minutes min';
    }
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: TextStyle(color: _colorScheme[3])),
          icon: Icon(Icons.keyboard_arrow_down, color: _colorScheme[3]),
          isExpanded: true,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: _colorScheme[2]),
              ),
            );
          }).toList(),
          onChanged: items.isEmpty ? null : onChanged,
        ),
      ),
    );
  }

  Widget _buildPaymentMethodStep() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Price summary card
              _buildPriceSummaryCard(),
              const SizedBox(height: 24),

              // Payment methods
              _buildSectionHeader('Payment Method'),
              _buildPaymentMethodsCard(),
              const SizedBox(height: 40),

              // Navigation buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: _colorScheme[2]),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(color: _colorScheme[2]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _colorScheme[2],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration',
                style: TextStyle(
                  color: _colorScheme[3],
                  fontSize: 14,
                ),
              ),
              Text(
                _calculateDuration(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: _colorScheme[2],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _colorScheme[2],
                  fontSize: 16,
                ),
              ),
              Text(
                '\$$totalPrice',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _colorScheme[2],
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPaymentOption(
            'points',
            'Pay with Points',
            'Available: $userPoints points',
            Icons.star_border,
          ),
          const Divider(height: 1),
          _buildPaymentOption(
            'online',
            'Pay Online',
            'Credit/Debit Card',
            Icons.credit_card,
          ),
          const Divider(height: 1),
          _buildPaymentOption(
            'cash',
            'Pay with Cash',
            'Pay on arrival',
            Icons.money,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
      String value, String title, String subtitle, IconData icon) {
    final isSelected = paymentMethod == value;

    return InkWell(
      onTap: () => setState(() => paymentMethod = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                icon,
                color: isSelected ? _colorScheme[2] : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: _colorScheme[2],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: _colorScheme[3],
                    ),
                  ),
                ],
              ),
            ),
            Radio(
              value: value,
              groupValue: paymentMethod,
              activeColor: _colorScheme[2],
              onChanged: (v) => setState(() => paymentMethod = v as String),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationStep() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _colorScheme[2],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Reservation details card
                    _buildDetailsCard(),
                    const SizedBox(height: 24),

                    // Payment details card
                    _buildPaymentDetailsCard(),
                  ],
                ),
              ),
            ),

            // Buttons
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _previousStep,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: _colorScheme[2]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(color: _colorScheme[2]),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onReserve,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _colorScheme[2],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      disabledBackgroundColor: _colorScheme[2].withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Confirm Booking',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildDetailsCard() {
  //   final dateStr = selectedDate != null
  //       ? DateFormat('EEEE, MMMM d, yyyy').format(selecte

  Widget _buildDetailsCard() {
    final dateStr = selectedDate != null
        ? DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!)
        : '---';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.event, color: _colorScheme[2], size: 20),
              const SizedBox(width: 8),
              Text(
                'Reservation Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _colorScheme[2],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Room',
              '${widget.room['name']} (Table #${widget.room['numTable']})'),
          const Divider(height: 24),
          _buildDetailRow('Date', dateStr),
          const SizedBox(height: 12),
          _buildDetailRow('Time', '$checkInTime - $checkOutTime'),
          const SizedBox(height: 12),
          _buildDetailRow('Duration', _calculateDuration()),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    String paymentLabel;
    switch (paymentMethod) {
      case 'points':
        paymentLabel = 'Pay with Points';
        break;
      case 'online':
        paymentLabel = 'Pay Online';
        break;
      case 'cash':
        paymentLabel = 'Pay with Cash';
        break;
      default:
        paymentLabel = 'Payment Method';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment, color: _colorScheme[2], size: 20),
              const SizedBox(width: 8),
              Text(
                'Payment Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _colorScheme[2],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Payment Method', paymentLabel),
          if (paymentMethod == 'points')
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _buildDetailRow('Available Points', userPoints.toString()),
            ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _colorScheme[2],
                ),
              ),
              Text(
                '\$$totalPrice',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: _colorScheme[2],
                ),
              ),
            ],
          ),
          if (paymentMethod == 'points')
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _colorScheme[2].withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: _colorScheme[2]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You will use ${(totalPrice / 1.5).ceil()} points for this reservation',
                      style: TextStyle(
                        fontSize: 12,
                        color: _colorScheme[2],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: _colorScheme[3],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _colorScheme[2],
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(
      {required bool isEnabled, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _colorScheme[2],
          disabledBackgroundColor: _colorScheme[2].withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<void> _onReserve() async {
    if (selectedDate == null || checkInTime == null || checkOutTime == null) {
      _showErrorSnackBar('Please select a date and time');
      return;
    }

    final start = _timeToMinutes(checkInTime!);
    final end = _timeToMinutes(checkOutTime!);
    final duration = end - start;

    if (duration < 60 || duration % 30 != 0) {
      _showErrorSnackBar('Minimum booking is 1 hour');
      return;
    }

    if (paymentMethod == 'points' && userPoints * 1.5 < totalPrice) {
      _showErrorSnackBar('You don\'t have enough points for this reservation');
      return;
    }

    setState(() => isLoading = true);

    try {
      final bookingData = {
        'date': selectedDate!.toIso8601String().split('T')[0],
        'check_in': checkInTime,
        'check_out': checkOutTime,
        'id_user': userId,
        'numTable': widget.room['numTable'],
        'price': paymentMethod == 'points' ? 0 : totalPrice,
        'paymentMethod': paymentMethod,
        'points': paymentMethod == 'points'
            ? (userPoints - (totalPrice / 1.5)).floor()
            : userPoints,
      };

      if (paymentMethod == 'online') {
        final bookingData1 = {'amount': totalPrice * 1000};
        final formattedDate = selectedDate!.toIso8601String().split('T')[0];
        final resp = await http.post(
          Uri.parse(
              'http://localhost:8000/ELACO/booking/payment?start_time=$checkInTime&end_time=$checkOutTime&numTable=${widget.room['numTable']}&date=$formattedDate'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(bookingData1),
        );

        final result = json.decode(resp.body);
        if (result['status'] == "success") {
          final redirectUrl = result['result']['payUrl'];
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewScreen(payUrl: redirectUrl)),
          );
        } else {
          _showErrorSnackBar(result['message'] ?? 'Payment failed');
        }
      } else {
        final resp = await http.post(
          Uri.parse('http://localhost:8000/ELACO/booking/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(bookingData),
        );
        if (resp.statusCode == 201) {
          // if (!mounted) return; // ← guard
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Reservation successful!'),
              backgroundColor: Colors.green[700],
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
          Navigator.pop(context, true);
        } else {
          throw Exception('Booking failed: ${resp.statusCode}');
        }
      }
    } catch (e) {
      _showErrorSnackBar('Error: ${e.toString()}');
    } finally {
      setState(() => isLoading = false);
    }
  }
}
