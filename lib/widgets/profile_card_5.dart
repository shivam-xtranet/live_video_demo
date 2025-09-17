import 'package:flutter/material.dart';

class IdCard extends StatelessWidget {
  const IdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.teal[50],
          border: Border.all(color: Colors.teal, width: 4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF0A1931),
              ),
              child: Column(
                children: const [
                  Icon(Icons.business, color: Colors.white, size: 32),
                  SizedBox(height: 4),
                  Text(
                    'COMPANY NAME',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'TAG LINE GOES HERE',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Profile image in circle
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile.jpg'), // your image
            ),
            const SizedBox(height: 8),

            // Name and title
            const Text(
              'JOHN DOE',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF0A1931)),
            ),
            const Text(
              'DESIGNER',
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // Details section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _InfoRow(label: 'ID NO', value: '905750250'),
                _InfoRow(label: 'DOB', value: 'DD/MM/YEAR'),
                _InfoRow(label: 'Blood', value: 'A+'),
                _InfoRow(label: 'Phone', value: '1201248510'),
                _InfoRow(label: 'E-mail', value: 'email@yourdomain.com'),
              ],
            ),
            const SizedBox(height: 12),

            // Barcode placeholder
            Container(
              height: 30,
              color: Colors.black12,
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text('|| ||| |||| | |||', // fake barcode text
                  style: TextStyle(letterSpacing: 2)),
            ),
          ],
        ),
      ),
    );
  }
}

// small widget for info rows
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '$label:',
              style: const TextStyle(
                  color: Colors.teal, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
