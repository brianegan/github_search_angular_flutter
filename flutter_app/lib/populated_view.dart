import 'package:flutter/material.dart';
import 'package:github_search_common/github_search_common.dart';

class PopulatedView extends StatelessWidget {
  final List<SearchResultItem> items;

  PopulatedView({Key key, @required this.items, bool visible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return InkWell(
          onTap: () => showItem(context, item),
          child: Container(
            alignment: FractionalOffset.center,
            margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 16.0),
                  child: Hero(
                    tag: item.full_name,
                    child: ClipOval(
                      child: Image.network(
                        item.owner.avatar_url,
                        width: 56.0,
                        height: 56.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: 6.0,
                          bottom: 4.0,
                        ),
                        child: Text(
                          "${item.full_name}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${item.html_url}",
                          style: TextStyle(
                            fontFamily: "Hind",
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showItem(BuildContext context, SearchResultItem item) {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            body: GestureDetector(
              key: Key(item.owner.avatar_url),
              onTap: () => Navigator.pop(context),
              child: SizedBox.expand(
                child: Hero(
                  tag: item.full_name,
                  child: Image.network(
                    item.owner.avatar_url,
                    width: MediaQuery.of(context).size.width,
                    height: 300.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
