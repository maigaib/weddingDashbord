import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {

  final Widget titre;
  final Widget nombre;
  final Widget cercle;
  const MyBox({required this.titre, required this.nombre, required this.cercle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        //height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.yellow[400],
        ),
       child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
         children: [
                cercle,
                 SizedBox(width: 10,),
                 Container(
                  margin: EdgeInsets.only(top:30),
                   child: Column(children: [
                                   nombre,
                                   titre,
                   ],),
                 )
         ],
       ),
      ),
    );
  }
}

class MyContainerWidget extends StatelessWidget {
   final IconData icon;
   final double cercleWidth ;
   final double cercleIconSize ;
  const MyContainerWidget({required this.icon, required this.cercleWidth, required this.cercleIconSize});
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(bottom:60),
            width: cercleWidth, // Définissez la largeur souhaitée du conteneur
            height: cercleWidth, // Définissez la hauteur souhaitée du conteneur
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Utilisez BoxShape.circle pour un conteneur circulaire
              color: Colors.white,
            ),
            child: Center(
              child: Icon(
               icon,
                color: Colors.black, // Couleur de l'icône
                size: cercleIconSize, // Taille de l'icône
              ),
            ),
                 );
  }
}
