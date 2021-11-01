import 'package:car_park_app/control/DatabaseCtrl.dart';
import 'package:car_park_app/entities/all.dart';
import 'package:car_park_app/pages/InfoUI.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchResultsListView extends StatefulWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  _SearchResultsListViewState createState() => _SearchResultsListViewState();
}

class _SearchResultsListViewState extends State<SearchResultsListView> {
  @override
  Widget build(BuildContext context) {
    DatabaseCtrl db = new DatabaseCtrl();
    Future<List<String>> allCarParks = db.getAllCarparkAddresses();
    return FutureBuilder(
      future: allCarParks,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<String>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Unable to get data');
          }
          String term = widget.searchTerm;
          List<String> allCarParks = snapshot.data!;
          List<String> filteredCarparks = allCarParks
              .where((element) =>
                  element.toUpperCase().contains(term.toUpperCase()))
              .toList();
          if (filteredCarparks.isEmpty) {
            return ListView(
              padding: EdgeInsets.only(top: 64.0),
              children: [
                SizedBox(
                  height: 12.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.cancel_outlined,
                    color: Colors.pink,
                  ),
                  title: Align(
                    alignment: Alignment(-2.0, 0),
                    child: Text(
                      "Sorry, no results found. Please try again.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }
          if (term != "") {
            return ListView(
              padding: EdgeInsets.only(top: 64.0),
              children: filteredCarparks
                  .map((e) => ListTile(
                        enabled: true,
                        onTap: () async {
                          Carpark carpark = await db.getCarparkByAddress(e);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      InfoUI(carpark: carpark)));
                        },
                        title: Text(
                          e,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                        ),
                      ))
                  .toList(),
            );
          } else {
            return ListView(
              padding: EdgeInsets.only(top: 64.0),
              children: allCarParks
                  .map((e) => ListTile(
                        title: Text(
                          e,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                        ),
                      ))
                  .toList(),
            );
          }
        }
        return Text("Error");
      },
    );
  }
}
