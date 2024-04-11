import 'package:flutter/material.dart';

import '../worldstates.dart';
class DetailsScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      tests;
  DetailsScreen({Key? key,  required this.name,required this.image,required this.totalCases,required this.totalDeaths,required this.totalRecovered,required this.active,required this.critical,required this.todayRecovered, required this.tests} ) : super(key: key);
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
        title:Text(widget.name),
      ),
      body:Column(
       mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Stack(
            alignment:Alignment.topCenter,
            children:[
              Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height* .067),
                child: Card(
                  //now here we will use our reausible row widget to make our work easire for us
                  child: Column(
                    children: [
                      SizedBox(height:MediaQuery.of(context).size.height*.06),
                      ReausibleRow(title:'TotalCases', value:widget.totalCases.toString(),),
                      ReausibleRow(title:'TotalDeaths', value:widget.totalDeaths.toString(),),
                      ReausibleRow(title:'TotalRecovered', value:widget.totalRecovered.toString(),),
                      ReausibleRow(title:'Active', value:widget.active.toString(),),
                      ReausibleRow(title:'Critical', value:widget.critical.toString(),),
                      ReausibleRow(title:'TodayRecovered', value:widget.todayRecovered.toString(),),
                      ReausibleRow(title:'Tests', value:widget.tests.toString(),),
                    ],
                  )
                ),
              ),
              CircleAvatar(
                  radius:60,
                  child:Image.network(widget.image))
            ]
          )
        ]
      )
    );
  }
}
