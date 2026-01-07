import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomField extends StatelessWidget {

  final IconData icon;
  final String title,subtitle;
  final VoidCallback onTap;

  const CustomField({ required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF00695C);

    return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}
}