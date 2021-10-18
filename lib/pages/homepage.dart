import 'package:dastur_tajriba_network/model/emplist_model.dart';
import 'package:dastur_tajriba_network/model/employe_model.dart';
import 'package:dastur_tajriba_network/services/network.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _loadingData() async {
    // await Future.delayed(Duration(seconds: 3));
    var data = await apiPostList();

    return Future.value(data);

    // return Future.error('error');
  }

  apiPostList() async {
    try {
      return await Network.GET(Network.API_LIST, Network.EmptyParams());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: FutureBuilder(
      future: _loadingData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return  _buildRow(snapshot.data);
        } else {
          return Center(
            child: Text('data not!'),
          );
        }
      },
    ));
  }

Widget _buildRow(String body){
  EmpList empList = Network.parseEmplist(body);
  return ListView.builder(

    itemCount: empList.data.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("name:"+empList.data[index].employee_name,style: TextStyle(color: Colors.green,fontSize: 20),),
                Text("age:"+empList.data[index].employee_age.toString(),style: TextStyle(color: Colors.blue,fontSize: 20))
              ],
            ),
            SizedBox(width: 10,),
            Text("salary:"+empList.data[index].employee_salary.toString(),style: TextStyle(color: Colors.red,fontSize: 20))
          ],
        ),
      );
    }
    
    );
}


}
