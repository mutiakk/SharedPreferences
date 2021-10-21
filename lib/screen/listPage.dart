import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_try/api/api.dart';
import 'package:shared_try/model/model_user.dart';
import 'package:shared_try/screen/detailPage.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future<List<Datum>> getDataList() async {
    var response = await http.get(Env().ListUser());
    if (response.statusCode == 200) {
      print("Found");
      ListUser listUser = listUserFromJson(response.body);
      // Support support= Support.fromJson(response.body.)
      List<Datum> datum = listUser.data;
      return datum;
    } else {
      throw Exception("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List User'),),
      body: SafeArea(
        child: FutureBuilder(
          future: getDataList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    data:{'mantap':snapshot.data[index]}
                                  )));
                        },
                        child: listUser(
                            snapshot.data[index].avatar,
                            snapshot.data[index].firstName,
                            snapshot.data[index].lastName));
                  });
            }
            if (snapshot.hasError) {
              return Text('No Data');
            }
            return Text('failed');
          },
        ),
      ),
    );
  }

  Widget listUser(String images, String fname, String lname) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  image: DecorationImage(
                    image: NetworkImage(images),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(fname + " " + lname),
              ),
            )
          ],
        ),
      ),
    );
  }
}
