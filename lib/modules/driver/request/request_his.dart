import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestHistory extends StatelessWidget {
  const RequestHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),),
        centerTitle: true,
        elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _HistoryCard(
            date: "24 Jan 2026",
            issue: "Engine overheating",
            status: "Resolved",
            statusColor: Colors.green,
          ),
          _HistoryCard(
            date: "18 Jan 2026",
            issue: "Battery not responding",
            status: "Mechanic Called",
            statusColor: Colors.orange,
          ),
          _HistoryCard(
            date: "10 Jan 2026",
            issue: "Smoke from engine",
            status: "Emergency",
            statusColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final String date;
  final String issue;
  final String status;
  final Color statusColor;

  const _HistoryCard({
    required this.date,
    required this.issue,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          /// STATUS DOT
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          /// DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          /// STATUS
          Text(
            status,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
