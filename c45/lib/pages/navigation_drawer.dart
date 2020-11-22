import 'package:flutter/material.dart';
import '../pages/dummy_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var items = [
      ['Inicio', Icons.home, DummyPage(title: 'A')],
      ['Perfil', Icons.account_circle, DummyPage(title: 'B')],
      ['Eventos', Icons.event_note, DummyPage(title: 'C')],
      ['Notificaciones', Icons.notifications_active, DummyPage(title: 'D')],
      ['Contacto', Icons.contact_phone, DummyPage(title: 'E')],
    ];

    return Drawer(
      child: Column(
        //padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          for (var i = 0; i < items.length; i++) ...[
            createDrawerBodyItem(
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
            title: Text('App v1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

Widget createDrawerBodyItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget createDrawerHeader() {
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
