import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kredo/provider/appstate_provider.dart';
import 'package:kredo/widgets/svg_icon.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
   CustomBottomNavigationBar({
    super.key
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(selectedIndexProvider);
    final setIndex = ref.read(selectedIndexProvider.notifier);
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
                  setIndex.state = 0;
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
                  setIndex.state = 1;
                },
                child: FaIcon(
                  FontAwesomeIcons.exchange,

                  color: currentIndex == 1
                      ? Theme.of(
                          context,
                        ).bottomNavigationBarTheme.selectedIconTheme!.color
                      : Theme.of(
                          context,
                        ).bottomNavigationBarTheme.unselectedIconTheme!.color,
                ),
              ),
              InkWell(
                onTap: () {
                  setIndex.state = 2;
                },
                child: Icon(
                  Icons.settings,
                  color: currentIndex == 2
                      ? Theme.of(
                          context,
                        ).bottomNavigationBarTheme.selectedIconTheme!.color
                      : Theme.of(
                          context,
                        ).bottomNavigationBarTheme.unselectedIconTheme!.color,
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
