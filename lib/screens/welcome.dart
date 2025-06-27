import 'package:flutter/material.dart';
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/widgets/grid_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Hello  ${FirebaseAuthRepository.build().displayName!}",
                  style: Theme.of(context).textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.grey.shade900.withAlpha(127),
              ),
              child: Column(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: [
                  GridButton(buttonName: "Buy Airtime"),
                  GridButton(buttonName: "Buy Minutes"),
                  GridButton(buttonName: "Buy Bundles"),
                  GridButton(buttonName: "Buy Monthly"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
