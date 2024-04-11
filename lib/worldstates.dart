import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/View/countriesList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'Services/Utilities/stateServices.dart';
class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(
      duration:Duration(seconds:3),
      vsync:this)..repeat();
  @override
  void dispose(){
    super.dispose();
  }
  final colorList=<Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
    Color(0xff0b96be),
    Color(0x7C942185)
  ];
  double val1=345;
  double val2=100;
  @override
  Widget build(BuildContext context) {
    StateServices stateServices=StateServices();//creted the instance of our class
    return Scaffold(
          body:SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FutureBuilder(future: stateServices.fetchWorldStatesRecord(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex:1,
                        child:SpinKitCircle(
                          color:Colors.white,
                          size:50.0,
                          controller:_controller
                        )
                      );
                    }else{

                      return Column(
                        children:[
                          PieChart(//here now we have to access our data here
                              dataMap: {

                                  'Total': double.parse(snapshot.data!.cases.toString()),
                                  'Recovered': double.parse(snapshot.data!.recovered.toString()),
                                  'Deaths': double.parse(snapshot.data!.deaths.toString()),
                                  'active':double.parse(snapshot.data!.active.toString()),
                                  'affectedCountries':double.parse(snapshot.data!.population.toString())
                          },
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true
                              ),
                              animationDuration:Duration(milliseconds:2500),
                              chartType:ChartType.ring,
                              legendOptions:LegendOptions(
                                  legendPosition:LegendPosition.left
                              ),
                              colorList:colorList
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*.06),
                            child: Card(
                                child:Column(
                                  children: [
                                    ReausibleRow(title:'total',value:snapshot.data!.cases.toString()),
                                    ReausibleRow(title:'Recovered',value:snapshot.data!.recovered.toString()),
                                    ReausibleRow(title:'Deaths',value:snapshot.data!.deaths.toString()),
                                    ReausibleRow(title:'Active', value: snapshot.data!.active.toString(),),
                                    ReausibleRow(title:'AffectedCountries', value: snapshot.data!.affectedCountries.toString(),)

                                  ]
                                )
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>CountriesListScreen()));
                            },
                            child: Container(
                                height:50,
                                decoration:BoxDecoration(
                                    color:Color(0xff1aa260),
                                    borderRadius:BorderRadius.circular(10)
                                ),
                                child:Center(
                                    child:Text('Tracked Countries')
                                )
                            ),
                          )
                        ]
                      );
                    }
                  }),

                ],
              ),
            ),
          )
    );
  }
}
class ReausibleRow extends StatelessWidget {
  String title,value;

   ReausibleRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right:10,top:10,bottom:10),
      child: Column(
        children:[
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children:[
              Text(title),
              Text(value,)
            ]
          ),
          SizedBox(height:5),
          Divider()
        ]

      ),
    );
  }
}
