
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserDetailsCard extends StatelessWidget {
  User user;
  UserDetailsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: CircleAvatar(
        radius: 30, // Display the first letter of the user's name
        backgroundColor: Colors.blueAccent,
        child: Text(user.name[0],
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username: ${user.username}',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Email: ${user.email}',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Phone: ${user.phone}',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Address: ${user.address.street}, ${user.address.suite}, ${user.address.city}, ${user.address.zipcode}',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Company: ${user.company.name}',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Website: ',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  TextSpan(
                    text: user.website,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
    );
  }
}
