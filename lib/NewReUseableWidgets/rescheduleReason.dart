import 'package:flutter/material.dart';
import 'dart:math';

class RescheduleGrid extends StatelessWidget {
  final List<String> dates = [
    "2025-01-30", "2025-01-28", "2025-01-27",
    "2025-01-26", "2025-01-25", "2025-01-24",
    "2025-01-23", "2025-01-22", "2025-01-21"
  ];

  final List<String> riders = [
    "John Doe", "Jane Smith", "Michael Brown",
    "Emily White", "Chris Johnson", "Sophia Miller",
    "David Wilson", "Emma Garcia", "Daniel Lee"
  ];

  final List<String> reasons = [
    "Product Damage", "Customer Not Available", "Wrong Address",
    "Weather Issue", "Technical Problem", "High Traffic",
    "Rider Unavailable", "Payment Issue", "Rescheduled by Customer"
  ];

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    return Container(
      padding: EdgeInsets.all(16),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(3),
        },
        border: TableBorder.all(color: Colors.grey.shade300),
        children: [
          // Table Header
          TableRow(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            children: [
              _buildTableCell("Date", isHeader: true),
              _buildTableCell("Rider Name", isHeader: true),
              _buildTableCell("Reschedule Reason", isHeader: true),
            ],
          ),
          // Table Rows (3 rows with random values)
          for (int i = 0; i < 3; i++)
            TableRow(
              children: [
                _buildTableCell(dates[random.nextInt(dates.length)]),
                _buildTableCell(riders[random.nextInt(riders.length)]),
                _buildTableCell(reasons[random.nextInt(reasons.length)]),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}
