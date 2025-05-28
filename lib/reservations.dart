import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReservationTableScreen extends StatefulWidget {
  const ReservationTableScreen({Key? key}) : super(key: key);

  @override
  State<ReservationTableScreen> createState() => _ReservationTableScreenState();
}

class _ReservationTableScreenState extends State<ReservationTableScreen> with SingleTickerProviderStateMixin {
  List<Reservation> _reservations = [];
  List<Reservation> _filteredReservations = [];
  bool _isLoading = true;
  String? _error;
  String? _userId;
  Timer? _refreshTimer;
  late AnimationController _animationController;
  String _currentFilter = 'All';
  
  // Color constants
  final Color primaryColor = const Color.fromARGB(255, 223, 224, 224);
  final Color backgroundColor = Colors.white;
  final Color textColor = Colors.black;
  final Color cardColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadUserIdAndFetchReservations();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUserIdAndFetchReservations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      
      if (userJson != null) {
        final userMap = jsonDecode(userJson);
        setState(() {
          _userId = userMap['_id'];
        });
        
        if (_userId != null) {
          await _fetchReservations();
          
          // Set up auto-refresh every 30 seconds
          _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
            _fetchReservations();
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _error = "User not logged in";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = "Error loading user data: ${e.toString()}";
      });
    }
  }

  Future<void> _fetchReservations() async {
    if (_userId == null) return;
    
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final response = await http.get(
        Uri.parse('http://localhost:8000/ELACO/booking/getReservationById/$_userId'),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['data'] != null) {
          final allReservations = List<Reservation>.from(
            data['data'].map((res) => Reservation.fromJson(res))
          );
          
          setState(() {
            _reservations = allReservations;
            _filteredReservations = _filterReservations(allReservations, _currentFilter);
            _isLoading = false;
          });
          _animationController.reset();
          _animationController.forward();
        } else {
          setState(() {
            _reservations = [];
            _filteredReservations = [];
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to fetch reservations: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _cancelReservation(String reservationId) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:8000/ELACO/booking/cancel/$reservationId'),
      );
      
      if (response.statusCode == 200) {
        setState(() {
          _reservations = _reservations.map((res) {
            if (res.id == reservationId) {
              return res.copyWith(status: 'canceled');
            }
            return res;
          }).toList();
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Reservation cancelled successfully'),
              ],
            ),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('Failed to cancel reservation');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Error: ${e.toString()}'),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
        ),
      );
    }
  }

  List<Reservation> _filterReservations(List<Reservation> reservations, String filter) {
    if (filter == 'All') {
      return reservations;
    } else if (filter == 'Confirmed') {
      // Handle both 'completed' from backend and 'confirmed' in UI
      return reservations.where((res) => 
        res.status.toLowerCase() == 'completed' || res.status.toLowerCase() == 'confirmed'
      ).toList();
    } else {
      return reservations.where((res) => 
        res.status.toLowerCase() == filter.toLowerCase()
      ).toList();
    }
  }
  
  void _applyFilter(String filter) {
    setState(() {
      _currentFilter = filter;
      _filteredReservations = _filterReservations(_reservations, filter);
    });
    
    // Add animation effect when filtering
    _animationController.reset();
    _animationController.forward();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'confirmed': // Handle both cases
        return Colors.green;
      case 'pending':
        return primaryColor;
      case 'canceled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: TextStyle(color: textColor, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchReservations,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              ),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_filteredReservations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 48, color: primaryColor.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              _currentFilter == 'All'
                ? 'No reservations found'
                : 'No $_currentFilter reservations',
              style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchReservations,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              ),
              child: Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _fetchReservations,
                color: primaryColor,
                backgroundColor: Colors.white,
                child: AnimationLimiter(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filteredReservations.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: _buildReservationCard(_filteredReservations[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Back arrow button
              IconButton(
                icon: Icon(Icons.arrow_back, color: textColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Reservations',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _currentFilter == 'All'
                        ? '${_reservations.length} ${_reservations.length == 1 ? 'reservation' : 'reservations'} found'
                        : '${_filteredReservations.length} $_currentFilter ${_filteredReservations.length == 1 ? 'reservation' : 'reservations'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _fetchReservations,
                icon: Icon(Icons.refresh_rounded, color: primaryColor),
                tooltip: 'Refresh',
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildFilterChip('All', _currentFilter == 'All'),
                _buildFilterChip('Pending', _currentFilter == 'Pending'),
                _buildFilterChip('Confirmed', _currentFilter == 'Confirmed'),
                _buildFilterChip('Canceled', _currentFilter == 'Canceled'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: primaryColor.withOpacity(0.2),
        highlightColor: primaryColor.withOpacity(0.1),
        onTap: () {
          if (!isSelected) {
            _applyFilter(label);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : textColor.withOpacity(0.7),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReservationCard(Reservation reservation) {
    final dateFormatted = DateTime.parse(reservation.date).toLocal();
    final formattedDate = DateFormat('EEEE, MMM d').format(dateFormatted);
    final isPending = reservation.status.toLowerCase() == 'pending';
    final displayStatus = reservation.status.toLowerCase() == 'completed' ? 'Confirmed' : reservation.status;
    
    return Slidable(
      key: ValueKey(reservation.id),
      enabled: isPending,
      endActionPane: isPending ? ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => _cancelReservation(reservation.id),
          confirmDismiss: () async {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Cancel Reservation?'),
                content: Text('Are you sure you want to cancel this reservation? This action cannot be undone.'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('No', style: TextStyle(color: Colors.grey)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: Text('Yes, Cancel'),
                  ),
                ],
              ),
            ) ?? false;
          },
        ),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cancel Reservation?'),
                  content: Text('Are you sure you want to cancel this reservation? This action cannot be undone.'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('No', style: TextStyle(color: Colors.grey)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _cancelReservation(reservation.id);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: Text('Yes, Cancel'),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.cancel_outlined,
            label: 'Cancel',
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildCardHeader(reservation, formattedDate, displayStatus),
            _buildCardContent(reservation),
            if (isPending) _buildCancelButton(reservation),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(Reservation reservation, String formattedDate, String displayStatus) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: _getStatusColor(reservation.status).withOpacity(0.08),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getStatusColor(reservation.status).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getStatusIcon(reservation.status),
              color: _getStatusColor(reservation.status),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${reservation.checkIn} - ${reservation.checkOut}',
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _getStatusColor(reservation.status).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              displayStatus.toUpperCase(),
              style: TextStyle(
                color: _getStatusColor(reservation.status),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'confirmed':
        return Icons.check_circle_outline;
      case 'pending':
        return Icons.access_time;
      case 'canceled':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  Widget _buildCardContent(Reservation reservation) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.table_restaurant,
            title: 'Table Number',
            value: reservation.numTable,
          ),
          Divider(color: Colors.grey.withOpacity(0.2), height: 24),
          _buildInfoRow(
            icon: Icons.payment,
            title: 'Payment Method',
            value: reservation.paymentMethod,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.attach_money,
            title: 'Total Price',
            value: '${reservation.price} TND',
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool isHighlighted = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: primaryColor, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: textColor.withOpacity(0.6),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                fontSize: isHighlighted ? 16 : 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCancelButton(Reservation reservation) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Cancel Reservation?'),
              content: Text('Are you sure you want to cancel this reservation? This action cannot be undone.'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('No', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _cancelReservation(reservation.id);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: Text('Yes, Cancel'),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cancel_outlined, size: 18),
            const SizedBox(width: 8),
            Text('Cancel Reservation'),
          ],
        ),
      ),
    );
  }
}

class Reservation {
  final String id;
  final String date;
  final String checkIn;
  final String checkOut;
  final String numTable;
  final double price;
  final String paymentMethod;
  final String status;

  Reservation({
    required this.id,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.numTable,
    required this.price,
    required this.paymentMethod,
    required this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'] ?? '',
      date: json['date'] ?? '',
      checkIn: json['check_in'] ?? '',
      checkOut: json['check_out'] ?? '',
      numTable: json['numTable']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Reservation copyWith({
    String? id,
    String? date,
    String? checkIn,
    String? checkOut,
    String? numTable,
    double? price,
    String? paymentMethod,
    String? status,
  }) {
    return Reservation(
      id: id ?? this.id,
      date: date ?? this.date,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      numTable: numTable ?? this.numTable,
      price: price ?? this.price,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
    );
  }
}