import 'package:flutter/material.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/widgets/base_app_bar.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/widgets/popup_menu_widget.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/models/posts.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/blocs/posts_bloc.dart';

class PostIndexScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PostIndexScreenState();
  }
}

class PostIndexScreenState extends State<PostIndexScreen> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllPosts();
  }

  //  @override
  //  void dispose() {
  //    bloc.dispose();
  //    super.dispose();
  //  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('Post'),
        appBar: AppBar(),
        widgets: <Widget>[
          PopupMenuWidget(),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.allPosts,
        builder: (context, AsyncSnapshot<Posts> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(Icons.add),
        onPressed: (){ }
      ),
    );
  }

  Widget buildList(AsyncSnapshot<Posts> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.results.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.map),
            title: Text('TODO EDIT: snapshot.data.results[index].your_field_name'),
            subtitle: Text('TODO EDIT: snapshot.data.results[index].your_field_name.toString()'),
            trailing: Icon(Icons.more_vert),
            onTap: () {},
          )
        );
      },
    );
  }
}

