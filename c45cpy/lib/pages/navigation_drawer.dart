import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/dummy_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var items = [
      ['Inicio', Icons.home, DummyPage(title: 'Home')],
      ['Perfil', Icons.account_circle, DummyPage(title: 'Perfil')],
      ['Eventos', Icons.event_note, DummyPage(title: 'Eventos')],
      [
        'Notificaciones',
        Icons.notifications_active,
        DummyPage(title: 'Notificaciones')
      ],
      ['Contacto', Icons.contact_phone, DummyPage(title: 'Contacto')],
    ];

    return Drawer(
      child: Container(
        color: Colors.blue[100],
        child: Column(
          children: <Widget>[
            MiDrawerHeader(),
            for (var i = 0; i < items.length; i++) ...[
              MiDrawerBodyItem(
                text: items[i][0],
                icon: items[i][1],
                onTap: () => {
                  Navigator.of(context).pop(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => items[i][2]),
                    //Navigator.popAndPushNamed(context, items[i][2])
                    //Navigator.pushReplacementNamed(context, items[i][2]),
                  )
                },
              ),
              Divider()
            ],
            Spacer(),
            Divider(),
            ListTile(
              title:
                  Text('App v0.1.0', style: TextStyle(color: Colors.blue[300])),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MiDrawerHeader extends StatelessWidget {
  const MiDrawerHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('images/bg_header.jpeg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Welcome to Flutter",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
}

class MiDrawerBodyItem extends StatelessWidget {
  MiDrawerBodyItem(
      {Key key,
      IconData this.icon,
      String this.text,
      GestureTapCallback this.onTap})
      : super(key: key);
  IconData icon;
  String text;
  GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    final TextStyle display1 = Theme.of(context).textTheme.headline5;

    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text, style: GoogleFonts.lato(textStyle: display1)),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
