import 'package:app/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchBar extends SearchDelegate<String> {

  final locations = [
    'Bangladesh',
    'Belgium',
    'New York',
    'Nepal',
    'Japan',
    'Britain',
    'London',
    'Austria',
    'China',
    'Denmark',
    'Germany',
    'Iraq'
  ];
  final recentLocations = [
    'Bangladesh',
    'Belgium',
    'New York',
    'Germany',
    'Iraq'
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: (){
          close(context, query);
        },
        icon: Icon(Icons.search),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back),
      );

  @override  /// search button is pressed in the device keyboard
  Widget buildResults(BuildContext context) {
    close(context, query);
    return HomePage();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? locations
        : locations.where((element) {
            final locationLower = element.toLowerCase();
            final queryLower = query.toLowerCase();
            return locationLower.startsWith(queryLower);
          }).toList(); //place.toList();
    return buildSuggestionSuccess(suggestions);
  }

  Widget buildSuggestionSuccess(List<String> suggestions) => ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        final queryText = suggestion.substring(0, query.length);
        final remainingText = suggestion.substring(query.length);

        return ListTile(
          onTap: () {
            query = suggestion;
            close(context, suggestion);
          },
          leading: Icon(Icons.location_city_sharp),
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: remainingText,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ]),
          ),
        );
      });
}
