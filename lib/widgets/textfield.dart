import 'package:flutter/material.dart';


class PassTextField extends StatefulWidget {
  const PassTextField({
    required this.key,
    required this.hintText,
    required this.password,
    required this.keyboardType,
  }) : super(key: key);

  final Key key;
  final String hintText;
  final TextEditingController password;
  final TextInputType keyboardType;

  @override
  State<PassTextField> createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {

  late bool strongPass = false;

  void onPassChangeCallBack(String password) {
    setState(() {
      strongPass = password.length > 8 &&
          RegExp(r'[A-Z]').hasMatch(password) &&     // has uppercase
          RegExp(r'[a-z]').hasMatch(password) &&     // has lowercase
          RegExp(r'[0-9]').hasMatch(password) &&     // has digit
          RegExp(r'[!@#\$&*~%^()_\-+=\[\]{};:"\\|,.<>?/]').hasMatch(password);
    });
  }

  late bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        keyboardType: widget.keyboardType,
        controller: widget.password,
        obscureText: !visibility,
        autocorrect: false,
        enableSuggestions: false,
        onChanged: onPassChangeCallBack,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: strongPass ? Colors.green.shade700 : Colors.red, width: 2.0),
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                visibility = !visibility;
              });
            },
            icon: Icon(visibility ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
