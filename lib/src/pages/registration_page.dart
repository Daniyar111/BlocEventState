import 'package:flutter/material.dart';

import 'registration_form.dart';

class RegistrationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registration Form'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: RegistrationForm(),
        ),
      ),
    );
  }
}
