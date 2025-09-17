import 'package:camera_id_demo_android/widgets/dynamic_image_conainer.dart';
import 'package:flutter/material.dart';

class ProfileCard2 extends StatelessWidget {
  const ProfileCard2({super.key, this.imageUrl, this.filePath});
  final String? imageUrl;
  final String? filePath;
  final Color darkBlue = const Color(0xFF263238);
  final Color lightGrey = const Color(0xFFECEFF1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Bar
              _buildTopBar(),
              // Main Content
              _buildMainContent(),
              // Bottom Bar
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: const Center(
        child: Text(
          'COMPANY NAME',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Section: Profile and Name
              _buildLeftSection(),
              const SizedBox(width: 20),
              // Middle Section: Contact Details
              _buildMiddleSection(),
            ],
          ),
          //  const SizedBox(height: 20),
          // // Right Section: QR Code and Barcode
          // _buildRightSection(),
        ],
      ),
    );
  }

  Widget _buildLeftSection() {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: const Color(0xFFCFD8DC),
            child: DynamicImageContainer(
              filePath: filePath,
              imageUrl: imageUrl,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your Name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Job Position',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.phone, '+0 123 456 7890'),
          _buildInfoRow(Icons.smartphone, '+0 123 456 7890'),
          _buildInfoRow(Icons.print, '+0 123 456 7890'),
          _buildInfoRow(Icons.email, 'name@companyname.com'),
          _buildInfoRow(Icons.language, 'www.companyname.com'),
          _buildInfoRow(Icons.location_on, 'Your Company Address'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: darkBlue),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildRightSection() {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Container(width: 80, height: 80, color: darkBlue),
          const SizedBox(height: 10),
          Container(height: 40, color: darkBlue),
          const SizedBox(height: 10),
          _buildIdDetails(),
        ],
      ),
    );
  }

  Widget _buildIdDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ABCD1234567890',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        _buildDetailRow('Employee ID', '0001'),
        _buildDetailRow('Date of Issue', '01 Jan 2015'),
        _buildDetailRow('Date of Expiry', '01 Jan 2016'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label :',
          style: const TextStyle(fontSize: 10, color: Colors.black54),
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      child: const Center(
        child: Text(
          'WWW.COMPANYNAME.COM',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
