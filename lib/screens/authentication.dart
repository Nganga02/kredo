import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/appstate_provider.dart' show authenticationProvider;

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {

  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  
  @override
  void initState() {
    _focusNodes[0].requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Widget _buildDigitBox(int index) {
    return SizedBox(
      width: 20,
      height: 20,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        maxLength: 1,
        cursorRadius: Radius.circular(10),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.none,
        obscureText: true,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          focusColor: Colors.green.shade700,
          counterText: "",
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade700),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  Widget _buildKey(String label, {VoidCallback? onPressed, Widget? child}) {
    return TextButton(
      onPressed: onPressed ?? () {},
      key: ValueKey(label),
      child: child ?? Text(label, style: GoogleFonts.abel(
        fontSize: 22
      )),
    );
  }

  Widget _buildKeyboard() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', '⌫'],
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((label) {
            if (label == '') {
              return const SizedBox(width: 60); // empty space
            } else if (label == '⌫') {
              return _buildKey(label, onPressed: _handleBackspace, child: const Icon(Icons.backspace_outlined));
            } else {
              return _buildKey(label, onPressed: () => _handleDigit(label));
            }
          }).toList(),
        );
      }).toList(),
    );
  }

  void _handleDigit(String digit) {
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.isEmpty) {
        _controllers[i].text = digit;
        if (i < _focusNodes.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
        break;
      }
    }
  }

  void _handleBackspace() {
    for (int i = _controllers.length - 1; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        _controllers[i].clear();
        _focusNodes[i].requestFocus();
        break;
      }
    }
  }

  void _submitCode() {
    final code = _controllers.map((c) => c.text).join();
    print("Entered Code: $code");
    // TODO: validate or send this code
  }

  @override
  Widget build(BuildContext context) {
    final pin = ref.watch(authenticationProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Pin",
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(
                      4,
                      _buildDigitBox,
                    ).expand((widget) => [widget, SizedBox(width: 15)]).toList()
                    ..removeLast(),
            ),
            Container(
              height: MediaQuery.of(context).size.width,
              width: double.infinity,
              child: _buildKeyboard()
            ),
            ElevatedButton(
              onPressed: _submitCode,
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
