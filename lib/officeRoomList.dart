import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OfficeRoomList extends StatefulWidget {
  const OfficeRoomList({super.key});

  @override
  State<OfficeRoomList> createState() => _OfficeRoomListState();
}

class _OfficeRoomListState extends State<OfficeRoomList> {
  int _currentNavIndex = 2;
  String _currentFilter = 'Upcoming';

  List<dynamic> officeRooms = [];
  List<dynamic> reservations = []; // ⬅️ Keep as List of Lists now (important!)

  final List<String> images = [
    'assets/officeroom2.jpg',
    'assets/officeRoom3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    fetchOfficeRooms();
    fetchReservations();
  }

  Future<void> fetchOfficeRooms() async {
    try {
      final res = await http.get(
        Uri.parse('http://localhost:8000/ELACO/table/offices'),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          officeRooms = data['offices'];
        });
      }
    } catch (e) {
      print('Error fetching rooms: $e');
    }
  }

  Future<void> fetchReservations() async {
    try {
      final resp = await http.get(
        Uri.parse(
            'http://localhost:8000/ELACO/booking/getReservationPrivateOffice'),
        headers: {'Content-Type': 'application/json'},
      );

      if (resp.statusCode == 200) {
        final data = json.decode(resp.body);
        final allNested = data['data'] as List;

        setState(() {
          reservations = allNested;
          // ✅ FIX 1: Keep as List<List<dynamic>>, DO NOT flatten using .expand()
        });

        print('Saved reservations: $reservations');
      } else {
        print('Failed with status: ${resp.statusCode}');
      }
    } catch (e) {
      print('Error fetching reservations: $e');
    }
  }

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  void _setFilter(String filter) {
    setState(() {
      _currentFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text(
                    "My Trips",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterChip("Upcoming", _currentFilter == "Upcoming"),
                  _buildFilterChip("Finished", _currentFilter == "Finished"),
                  _buildFilterChip("Favorites", _currentFilter == "Favorites"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: officeRooms.length,
                itemBuilder: (context, index) {
                  final room = officeRooms[index];
                  final image = images[index % images.length];

                  return _buildRoomCard(room, image, index); // ✅ Pass index too
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return GestureDetector(
      onTap: () => _setFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.black : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard(dynamic room, String imagePath, int index) {
    final descriptions = room['description'] ?? [];
    final prices = room['prices'] ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border, color: Colors.black),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: prices.map<Widget>((priceObj) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${priceObj["price"]}DT / ${priceObj["duration"]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room['Name'] ?? 'Meeting Room',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '12 Dec - 22 Dec, 1 Room - 2 Adults',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  children: descriptions.map<Widget>((desc) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(desc, style: const TextStyle(fontSize: 12)),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        // prices.isNotEmpty
                        '5 DT / 1h'
                        // : 'N/A',
                        // style: const TextStyle(
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/course-detail1',
                          arguments: {
                            'room': room,
                            'reservations': reservations[index],
                            // ✅ Pass correct reservations[index] as you wanted!
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          const Text('Reserve', style: TextStyle(fontSize: 13,    color: Colors.white,
)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
