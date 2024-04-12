import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/Utilities/stateServices.dart';
import 'detailscreen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  late Future<List<dynamic>> _countriesFuture;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _countriesFuture = StateServices().countriesListApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {}); // Trigger rebuild when text changes
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search for a country',
                  counterStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _countriesFuture,
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10, // You can set a default count
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.red,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                        );
                      },
                    );
                  } else if (searchController.text.isNotEmpty) {
                    final List<dynamic> countries = snapshot.data!;
                    List<dynamic> filteredCountries = countries.where((country) {
                      String name = country['country'];
                      return name.toLowerCase().contains(searchController.text.toLowerCase());
                    }).toList();
                    return ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailsScreen(
                                name: filteredCountries[index]['country'],
                                image: filteredCountries[index]['countryInfo']['flag'],
                                totalCases: filteredCountries[index]['cases'],
                                totalDeaths: filteredCountries[index]['deaths'],
                                totalRecovered: filteredCountries[index]['recovered'],
                                active: filteredCountries[index]['active'],
                                critical: filteredCountries[index]['critical'],
                                todayRecovered: filteredCountries[index]['todayRecovered'],
                                tests: filteredCountries[index]['tests'],
                              )),
                            );
                          },
                          child: ListTile(
                            title: Text(filteredCountries[index]['country']),
                            subtitle: Text(
                              filteredCountries[index]['cases'].toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                            leading: Image.network(
                              filteredCountries[index]['countryInfo']['flag'],
                              height: 40,
                              width: 40,
                            ),
                          ),
                        );
                      },
                    );
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>DetailsScreen(
                                name: snapshot.data![index]['country'],
                                image: snapshot.data![index]['countryInfo']['flag'],
                                totalCases: snapshot.data![index]['cases'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                totalRecovered:snapshot.data![index]['recovered'],
                                active: snapshot.data![index]['active'],
                                critical:snapshot.data![index]['critical'],
                                todayRecovered:snapshot.data![index]['todayRecovered'],
                                tests:snapshot.data![index]['tests'],
                            )));
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(
                              snapshot.data![index]['cases'].toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                            leading: Image.network(
                              snapshot.data![index]['countryInfo']['flag'],
                              height: 40,
                              width: 40,
                            ),
                          ),
                        );
                      },
                    );
                  }

                  // Add a default return statement here
                  return SizedBox(); // You can return any default widget here
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
