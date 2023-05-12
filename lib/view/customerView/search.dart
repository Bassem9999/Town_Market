import 'package:flutter/material.dart';

class Search extends SearchDelegate<String> {   

   List searchData = [];
   Search({ required this.searchData});
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
   return[
    IconButton(onPressed: (){
      query = "";
    }, icon: Icon(Icons.clear))
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){close(context, '');}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var mysearch = query.isEmpty ? searchData : searchData.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemCount: mysearch.length,itemBuilder: (context,i){
      return ListTile(
        leading: Icon(Icons.production_quantity_limits_sharp),
        title:  Text(mysearch[i]),
      );
    });
  }
}