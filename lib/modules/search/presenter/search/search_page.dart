import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:githubsearch/modules/search/presenter/search/search_bloc.dart';
import 'package:githubsearch/modules/search/presenter/search/state/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final bloc = Modular.get<SearchBloc>();

  TextEditingController searchController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: TextField(
              controller: searchController,
              onChanged: bloc.add,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search...'
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc,
              builder: (context, snapshot) {

                final state = bloc.state;

                if(state is SearchStart){
                  return Center(
                    child: Text('Digite um texto'),
                  );
                }

                if(state is SearchError && searchController.text.isNotEmpty){
                  return Center(
                    child: Text('Houve um erro'),
                  );
                }

                if(searchController.text.isEmpty){
                  return Container();
                }

                if(state is SearchLoading){
                  return Center(child: CircularProgressIndicator());
                }

                final list = (state as SearchSuccess).list;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];
                      return ListTile(
                        leading: item.img == null ? Container() : CircleAvatar(
                          backgroundImage: NetworkImage(item.img),
                        ),
                        title: Text(item.title ?? ""),
                      );
                    });
              }
            ),
          )
        ],
      ),
    );
  }
}
