import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kredo/model/airtime_deno.dart';

class AirtimeButton extends StatelessWidget {
  const AirtimeButton({
    super.key,
    required this.amount,
    this.discount,
    this.onTap,
  });

  final String amount;
  final String? discount;
  final void Function(BuildContext context, String amount )? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap!(context, amount);
      },// Handle button tap
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            amount,
            style: GoogleFonts.dmSerifText(
              textStyle: Theme.of(context).textTheme.titleLarge,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).colorScheme.primary
            ),
          ),
          discount == null ? Container() : Text("$discount Off",
            style: GoogleFonts.robotoCondensed(
              textStyle: Theme.of(context).textTheme.titleMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
