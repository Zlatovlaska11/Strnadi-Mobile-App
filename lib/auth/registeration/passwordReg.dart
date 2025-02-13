/*
 * Copyright (C) 2024 Marian Pecqueur
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:strnadi/auth/authorizator.dart';
import 'package:strnadi/auth/registeration/nameReg.dart';
import 'package:strnadi/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegPassword extends StatefulWidget {
  final dynamic email;
  final dynamic consent;
  final dynamic name;
  final dynamic surname;
  final dynamic nickname;

  
  const RegPassword({ super.key, required this.email, required this.consent, required this.name, required this.surname, required this.nickname});

  @override
  State<RegPassword> createState() => _RegPasswordState();

}

class _RegPasswordState extends State<RegPassword> {

  final _GlobalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  late bool _termsAgreement = false;


  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Register'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _GlobalKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Hesol',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Heslo',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegName(email: _emailController.text, consent: _termsAgreement ))),
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
