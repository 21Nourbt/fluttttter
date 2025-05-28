// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarBookingScreen extends StatefulWidget {
//   @override
//   _CalendarBookingScreenState createState() => _CalendarBookingScreenState();
// }

// class _CalendarBookingScreenState extends State<CalendarBookingScreen> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime? _rangeStart;
//   DateTime? _rangeEnd;
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF9FAFB), // Light background
//       appBar: AppBar(
//         backgroundColor: Color(0xFFF9FAFB),
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "Select dates",
//           style: TextStyle(
//             color: Color(0xFF111827),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Color(0xFF111827)),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: TableCalendar(
//                 firstDay: DateTime.utc(2010, 1, 1),
//                 lastDay: DateTime.utc(2030, 12, 31),
//                 focusedDay: _focusedDay,
//                 selectedDayPredicate: (day) =>
//                     isSameDay(_selectedDay, day),
//                 rangeStartDay: _rangeStart,
//                 rangeEndDay: _rangeEnd,
//                 calendarFormat: CalendarFormat.month,
//                 rangeSelectionMode: _rangeSelectionMode,
//                 startingDayOfWeek: StartingDayOfWeek.sunday,
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() {
//                     if (!isSameDay(_selectedDay, selectedDay)) {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                       _rangeStart = null; 
//                       _rangeEnd = null; 
//                       _rangeSelectionMode = RangeSelectionMode.toggledOff;
//                     }
//                   });
//                 },
//                 onRangeSelected: (start, end, focusedDay) {
//                   setState(() {
//                     _selectedDay = null;
//                     _focusedDay = focusedDay;
//                     _rangeStart = start;
//                     _rangeEnd = end;
//                     _rangeSelectionMode = RangeSelectionMode.toggledOn;
//                   });
//                 },
//                 calendarStyle: CalendarStyle(
//                   todayDecoration: BoxDecoration(
//                     color: Colors.transparent,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Color(0xFF3C5DF7)),
//                   ),
//                   rangeHighlightColor: Color(0xFF3C5DF7).withOpacity(0.3),
//                   selectedDecoration: BoxDecoration(
//                     color: Color(0xFF3C5DF7),
//                     shape: BoxShape.circle,
//                   ),
//                   rangeStartDecoration: BoxDecoration(
//                     color: Color(0xFF3C5DF7),
//                     shape: BoxShape.circle,
//                   ),
//                   rangeEndDecoration: BoxDecoration(
//                     color: Color(0xFF3C5DF7),
//                     shape: BoxShape.circle,
//                   ),
//                   selectedTextStyle: TextStyle(color: Colors.white),
//                   defaultTextStyle: TextStyle(color: Color(0xFF111827)),
//                   weekendTextStyle: TextStyle(color: Color(0xFF6B7280)),
//                 ),
//                 headerStyle: HeaderStyle(
//                   titleCentered: true,
//                   formatButtonVisible: false,
//                   titleTextStyle: TextStyle(
//                     color: Color(0xFF111827),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                   leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF111827)),
//                   rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF111827)),
//                 ),
//                 daysOfWeekStyle: DaysOfWeekStyle(
//                   weekdayStyle: TextStyle(color: Color(0xFF9CA3AF)),
//                   weekendStyle: TextStyle(color: Color(0xFF9CA3AF)),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildDateColumn("Check In", _rangeStart),
//                       Icon(Icons.arrow_right_alt, color: Color(0xFF3C5DF7)),
//                       _buildDateColumn("Check Out", _rangeEnd),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildDetailColumn("Room", "01"),
//                       _buildDetailColumn("Adult", "02"),
//                       _buildDetailColumn("Child", "00"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF3C5DF7),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 5,
//                 ),
//                 child: Text(
//                   "Book Room",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDateColumn(String label, DateTime? date) {
//     String formatted = date != null
//         ? "${date.month}/${date.day}/${date.year}"
//         : "-";
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Color(0xFF6B7280),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           formatted,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF111827),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailColumn(String label, String value) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Color(0xFF6B7280),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF111827),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBookingScreen extends StatefulWidget {
  @override
  _CalendarBookingScreenState createState() => _CalendarBookingScreenState();
}

class _CalendarBookingScreenState extends State<CalendarBookingScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB), // Light background
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAFB),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Select dates",
          style: TextStyle(
            color: Color(0xFF111827),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: CalendarFormat.month,
                rangeSelectionMode: _rangeSelectionMode,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _rangeStart = null; 
                      _rangeEnd = null; 
                      _rangeSelectionMode = RangeSelectionMode.toggledOff;
                    }
                  });
                },
                onRangeSelected: (start, end, focusedDay) {
                  setState(() {
                    _selectedDay = null;
                    _focusedDay = focusedDay;
                    _rangeStart = start;
                    _rangeEnd = end;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF3C5DF7)),
                  ),
                  rangeHighlightColor: Color(0xFF3C5DF7).withOpacity(0.3),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF3C5DF7),
                    shape: BoxShape.circle,
                  ),
                  rangeStartDecoration: BoxDecoration(
                    color: Color(0xFF3C5DF7),
                    shape: BoxShape.circle,
                  ),
                  rangeEndDecoration: BoxDecoration(
                    color: Color(0xFF3C5DF7),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  defaultTextStyle: TextStyle(color: Color(0xFF111827)),
                  weekendTextStyle: TextStyle(color: Color(0xFF6B7280)),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: Color(0xFF111827),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF111827)),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF111827)),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Color(0xFF9CA3AF)),
                  weekendStyle: TextStyle(color: Color(0xFF9CA3AF)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateColumn("Check In", _rangeStart),
                      Icon(Icons.arrow_right_alt, color: Color(0xFF3C5DF7)),
                      _buildDateColumn("Check Out", _rangeEnd),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDetailColumn("Room", "01"),
                      _buildDetailColumn("Adult", "02"),
                      _buildDetailColumn("Child", "00"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3C5DF7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  "Book Room",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDateColumn(String label, DateTime? date) {
    String formatted = date != null
        ? "${date.month}/${date.day}/${date.year}"
        : "-";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          formatted,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}
