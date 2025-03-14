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

import 'package:flutter/gestures.dart';
import 'package:strnadi/auth/authorizator.dart';
import 'package:strnadi/auth/registeration/nameReg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class RegMail extends StatefulWidget {
  const RegMail({super.key});

  @override
  State<RegMail> createState() => _RegMailState();
}

class _RegMailState extends State<RegMail> {
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

    // this doesn't makes sense but it works so i will leave it here
    final halfScreen = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      appBar: AppBar(title: const Text('Registrace')),
      body: Center(
        child: Form(
          key: _GlobalKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: halfScreen),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Zadejte Váš Email',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: 'Email',
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (_GlobalKey.currentState?.validate() ?? false) {
                            // Proceed to next page if validation is successful
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (_) => RegName(
                                  email: _emailController.text,
                                  consent: _termsAgreement,
                                ),
                              ),
                            );
                          } else {
                            // Optionally, show an error message if validation fails
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      CheckboxListTile(
                        title: const Text('I agree to the terms and conditions'),
                        value: _termsAgreement,
                        onChanged: (value) {
                          setState(() {
                            _termsAgreement = value!;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_GlobalKey.currentState?.validate() ?? false) {
                                // Proceed to the next screen if the form is valid
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegName(
                                      email: _emailController.text,
                                      consent: _termsAgreement,
                                    ),
                                  ),
                                );
                              } else {
                                // Optionally, show an error message if validation fails
                                _showMessage('Please fix the errors before proceeding.');
                              }
                            },
                            child: const Text('Pokracovat', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'By continuing, you agree to the ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(Uri.parse('https://new.strnadi.cz/podminky-pouzivani'));
                            },
                        ),
                      ],
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
