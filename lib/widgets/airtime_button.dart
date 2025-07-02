import 'package:flutter/material.dart';

class AirtimeButton extends StatelessWidget {
  const AirtimeButton({super.key, required this.amount, this.discount});

  final String amount;
  final String? discount;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){},
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Ksh. $amount",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.green.shade700,
              ),),
            discount == null ? Container() : Text("$discount% OFF")
          ]),
    );
  }
}
