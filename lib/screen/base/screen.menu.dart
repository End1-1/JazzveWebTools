part of 'screen.dart';

extension ScreenMenu on Screen {
  Widget menuHeader(BuildContext context) {
    return Row(
      children: [
        if (menuButton) IconButton(onPressed: _showMenu, icon: Icon(Icons.menu))
      ],
    );
  }

  Widget menu(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.8;
    return BlocBuilder<AnimBloc, ASAnim>(builder: (builder, state) {
      if (state.runtimeType == ASAnim) {
        return Container();
      }
      return Stack(
        children: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: state is ASAnimMenuOpen
                  ? InkWell(
                      onTap: () {
                        _menuPos = -width;
                        BlocProvider.of<AnimBloc>(prefs.context())
                            .add(AEAnimGo(ASAnimMenuClose()));
                      },
                      child: Container(color: Colors.black38))
                  : Container()),
          AnimatedPositioned(
              width: width,
              height: MediaQuery.sizeOf(context).height,
              left: state is ASAnimMenuOpen ? 0 : -width,
              duration: const Duration(milliseconds: 300),
              child: GestureDetector(
                  onPanUpdate: (d) {
                    if (_menuPos - d.delta.dx > 0) {
                      return;
                    }
                    if ((_menuPos - d.delta.dx).abs() > width * 0.5) {
                      _menuPos = -width;
                      hideMenu();
                      return;
                    }
                    _menuPos -= d.delta.dx;
                  },
                  onPanEnd: (d) {
                    _menuPos = -width;
                    hideMenu();
                  },
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      color: Color(0xffffffff),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Image.asset('assets/icon.png', height: 50),
                                columnSpace(),
                                Text('Jazzve Web Tools')
                              ]),
                              const Divider(thickness: 5, color: Colors.indigo),
                              rowSpace(),
                              _menuItem(
                                  _revenu,
                                  'assets/revenue.png',
                                  locale().revenue,
                                  Screen.currentPageName == 'revenu'),
                              _menuItem(
                                  _orderRemovalRequest,
                                  'assets/orderremove.png',
                                  locale().orderRemovalRequest,
                                  Screen.currentPageName ==
                                      'orderremovalrequest'),
                              _menuItem(
                                  _dishRemovalRequest,
                                  'assets/removedish.png',
                                  locale().dishRemovalRequest,
                                  Screen.currentPageName ==
                                      'dishRemovalRequest'),
                              rowSpace(),
                              Row(
                                children: [
                                  Text(prefs.getString('appversion') ??
                                      'Unknown')
                                ],
                              )
                            ],
                          )
                        ],
                      ))))
        ],
      );
    });
  }

  Widget _menuItem(
      VoidCallback callback, String image, String text, bool disabled) {
    final smallBoldText = const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14);
    final smallHintText = const TextStyle(
        fontWeight: FontWeight.normal, color: Colors.black38, fontSize: 14);
    return InkWell(
        onTap: disabled ? () {} : callback,
        child: Container(
            child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: Container(
                      decoration: const BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(color: Colors.black38)),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Image.asset(image,
                          height: 40,
                          colorBlendMode: disabled
                              ? BlendMode.colorBurn
                              : BlendMode.clear))),
              columnSpace(),
              Text(text, style: disabled ? smallBoldText : smallHintText)
            ],
          ),
          const Row(children: [
            Expanded(child: Divider()),
          ])
        ])));
  }

  void hideMenu() {
    BlocProvider.of<AnimBloc>(prefs.context()).add(AEAnimGo(ASAnimMenuClose()));
  }

  void _orderRemovalRequest() {
    hideMenu();
    Screen.currentPageName = 'orderremovalrequest';
    Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => OrderRemovalRequestScreen()));
  }

  void _dishRemovalRequest() {
    hideMenu();
    Screen.currentPageName = 'dishRemovalRequest';
    Navigator.push(prefs.context(),
        MaterialPageRoute(builder: (builder) => DishRemovalRequestScreen()));
  }

  void _revenu() {
    hideMenu();
    Screen.currentPageName = 'revenu';
    Navigator.push(
        prefs.context(), MaterialPageRoute(builder: (builder) => HomeScreen()));
  }
}
