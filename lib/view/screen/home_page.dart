import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:government_service/provider/change_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/data.dart';
import 'g_service.dart';
import 'my_web.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityResult cres = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    Provider.of<ChangeProvider>(context, listen: false).checkingConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        title: Text("Gov. Service App",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer<ChangeProvider>(
        builder: (BuildContext context, ChangeProvider value, Widget? child) {
          bool isConnection =
              value.connectivityResult != ConnectivityResult.none;
          return isConnection
              ? GridView.builder(
                  padding: EdgeInsets.all(15),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 4 / 5),
                  itemCount: Data.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Gservice(
                                sname: Data.list[index].title.toString(),
                                url: Data.list[index].web_url.toString());
                          },
                        ));

                        print(Data.list[index].title);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Data.list[index].color,boxShadow: [BoxShadow(color: Colors.black45)]),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Image.network(
                              "${Data.list[index].img_url}",
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Text("${Data.list[index].title}",style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: isConnection ? Colors.green : Colors.red),
                  child: Text(
                    isConnection ? "Connected" : " Disconnected",
                    style: TextStyle(color: Colors.white),
                  ),
                );
        },
      ),

      bottomSheet: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            bool isConnection = snapshot.data != ConnectivityResult.none;

            if (isConnection) {
              // mobile mobile
              if (cres != snapshot.data) {
                Future.delayed(
                  Duration(seconds: 1),
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Connection"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                );
              }

              cres = snapshot.data!;
              return SizedBox();
            } else {
              return Container(
                color: Colors.red,
                width: double.infinity,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  "No Connection",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          }),
    );
  }
}
