import 'package:health_connect/config/global.params.dart';
import 'package:flutter/material.dart';
import 'package:health_connect/theme/light_color.dart';
// Menu
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
        child: Container(
         child: ListView(
        children:  [
          const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/backg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child :Center(
                  child:CircleAvatar(
                    backgroundImage: AssetImage('assets/images/man.png'),
                    radius: 50,
                  )
              )
          ),
          ...(GlobalParams.menus as List).map((item) {
            return  Column(
              children: [
                ListTile(
                  title:  Text('${item['title']}', style: TextStyle(fontSize: 18),),
                  leading: item['icon'],
                  trailing:  Icon(Icons.arrow_right , color: LightColor.green),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "${item['route']}");
                  },
                ),
                SizedBox(
                  height: 10, // add some spacing between the divider and the previous item
                  child: Divider(
                    color: LightColor.green,
                    thickness: 1, // set the thickness of the divider
                    indent: 10, // set the left padding of the divider
                    endIndent: 10, // set the right padding of the divider
                  ),
                ),
              ],
            );
          })
        ],
      ),
        ),
    );
  }
}

