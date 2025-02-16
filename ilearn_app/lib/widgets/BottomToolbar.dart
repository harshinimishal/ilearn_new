import 'package:flutter/material.dart';

class BottomToolbar extends StatelessWidget {
  const BottomToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildToolbarItem(Icons.edit_note, 'Edit'),
          _buildToolbarItem(Icons.push_pin_outlined, 'Pin'),
          _buildToolbarItem(Icons.flash_on_outlined, 'Quick'),
          _buildToolbarItem(Icons.download_outlined, 'Download'),
        ],
      ),
    );
  }

  Widget _buildToolbarItem(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Icon(
          icon,
          color: const Color(0xFF121F49),
          size: 24,
        ),
      ),
    );
  }
}