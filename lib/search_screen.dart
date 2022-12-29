import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
   _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   TextEditingController _filter = TextEditingController(); // 검색 위젯을 컨트롤 하는 위젯
   FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태등을 가지고 있는 위젯
    String _searchText = ""; //현재 검색어값

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(30)),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
<<<<<<< Updated upstream
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white12,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white60,
                          size: 20,
                        )
                    ),
                  ),
                )
=======
                  ),)
>>>>>>> Stashed changes
            ],),
          )
        ],
      ),
    );
  }
}