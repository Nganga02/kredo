import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kredo/widgets/svg_icon.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    this.onTap,
    required this.currentIndex,
  });

  final int currentIndex;
  final void Function(int)? onTap;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? double.infinity
              : MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  widget.onTap!(0);
                  setState(() {
                    currentIndex = 0;
                  });
                },
                child: SvgIcon(
                  assetPath: currentIndex == 0
                      ? 'assets/icons/focused48.svg'
                      : 'assets/icons/unfocused48.svg',
                  color: currentIndex == 0
                      ? Theme.of(
                          context,
                        ).bottomNavigationBarTheme.selectedItemColor
                      : Theme.of(
                          context,
                        ).bottomNavigationBarTheme.unselectedItemColor,
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onTap!(1);
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: FaIcon(
                  FontAwesomeIcons.exchange,
                  color: currentIndex == 1
                      ? Theme.of(
                          context,
                        ).bottomNavigationBarTheme.selectedItemColor
                      : Theme.of(
                          context,
                        ).bottomNavigationBarTheme.unselectedItemColor,
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onTap!(2);
                  setState(() {
                    currentIndex = 2;
                  });
                },
                child: Icon(
                  Icons.settings,
                  color: currentIndex == 2
                      ? Theme.of(
                          context,
                        ).bottomNavigationBarTheme.selectedItemColor
                      : Theme.of(
                          context,
                        ).bottomNavigationBarTheme.unselectedItemColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _selectedIndex
// BottomNavigationBar(
// items: <BottomNavigationBarItem>[
// BottomNavigationBarItem(
// icon: SvgIcon(assetPath: 'assets/icons/focused48.svg'),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: FaIcon(FontAwesomeIcons.exchange),
// label: 'History',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.settings),
// label: 'Settings',
// ),
// ],
// ),
