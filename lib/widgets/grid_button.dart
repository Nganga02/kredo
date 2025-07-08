import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GridButton extends StatelessWidget {
  const GridButton({super.key, required this.buttonName, required this.page, required this.denominations,});
  
  final String buttonName;
  final String page;
  final Map<String, String?> denominations;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        splashColor: Colors.grey.shade900.withAlpha(1),
        onTap: (){
          Navigator.pushNamed(context, page, arguments: denominations);
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(buttonName),
              SizedBox(height: 10,),
              SvgPicture.asset('assets/icons/focused96.svg',
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
