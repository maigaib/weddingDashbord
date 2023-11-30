import 'package:flutter/material.dart';
import 'package:weddingadministration/modeles/prestataire.dart';
import 'package:weddingadministration/responsive/desktop_body.dart';
import 'package:weddingadministration/responsive/pages/clientsPage.dart';
import 'package:weddingadministration/responsive/pages/mariagesPage.dart';


var defaultBackgroundColor = Colors.white;
var appBarColor = Color.fromRGBO(253, 139, 139, 1);
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Text(' '),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
//================================================ttouched=====================================================================================
var myDrawer  = (BuildContext context)=>  Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      Container(
        height: 100,
        child: DrawerHeader(
          child: Icon(
            Icons.favorite,
            size: 40,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'D A S H B O A R D',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.handshake),
          title: Text(
            'P R E S T A T A I R E S',
            style: drawerTextColor,
          ),
           onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DesktopScaffold()),
      );
    },
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.room_service),
          title: Text(
            'P R E S T A T I O N S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.supervisor_account),
          title: Text(
            'C L I E N T S',
            style: drawerTextColor,
          ),
          onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ClientScaffold()),
      );
    },
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.attachment),
          title: Text(
            'R E L A T I O N S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.favorite_rounded),
          title: Text(
            'M A R I A G E S',
            style: drawerTextColor,
          ),
          onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MariageScaffold()),
      );
    },
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'P A R A M E T R E S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.info),
          title: Text(
            'A  P R O P O S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            'D E C O N N E X I O N',
            style: drawerTextColor,
          ),
        ),
      ),
    ],
  ),
);
