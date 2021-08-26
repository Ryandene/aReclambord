import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardVendorScreen extends StatefulWidget {
  DashboardVendorScreen({Key key}) : super(key: key);
  @override 
  _DashboardVendorScreenState createState() => _DashboardVendorScreenState();
}

class _DashboardVendorScreenState extends State<DashboardVendorScreen>{
  final _dashboardVendorScaffoldKey = GlobalKey<ScaffoldState>();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      key: _dashboardVendorScaffoldKey,
      body: StaggeredGridView.count(
        crossAxisCount: 3,//no of columns
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        padding: EdgeInsets.only(top:5.0, bottom: 5.0, left: 5.0, right: 5.0),
        children: <Widget>[
          stackCard("Welcome to Vendor Dashboard"),
          stackCard("Inventory"),
          stackCard("Purchase"),
          stackCard("New Listings"),
          stackCard("My Analysis"),
          stackCard("Progress"),
        ],
        staggeredTiles: [
          StaggeredTile.extent(3, 150.0),
          StaggeredTile.extent(1, 140.00),
          StaggeredTile.extent(2, 140.00),
          StaggeredTile.extent(2, 160.00),
          StaggeredTile.extent(1, 160.00),
          StaggeredTile.extent(3, 150.00),
          //(how many columns occupy, height of the tile)
        ],
      ),
    );
  }

  stackCard(String ctitle) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white24,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: Icon(Icons.album, size: 50),
            title: Text(
              ctitle,
              style: TextStyle(fontSize: 25.0),
            ),
            subtitle: Text(
              'Go to inventory',
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          // ButtonBar(
          //   children: <Widget>[
          //     ElevatedButton(
          //       child: const Text("Go"),
          //       onPressed: (){}
          //     ),
          //     ElevatedButton(
          //       child: const Text("See"),
          //       onPressed: (){}
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

}