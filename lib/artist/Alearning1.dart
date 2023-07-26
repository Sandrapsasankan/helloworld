import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/api_service/api.dart';
import 'package:helloworld/artist/Alearning3.dart';
import 'package:helloworld/customer/learning2.dart';
import 'package:helloworld/customer/video.dart';




class Alearning1 extends StatefulWidget {
  Alearning1({Key? key}) : super(key: key);
  @override
  State<Alearning1> createState() => _Alearning1State();
}

class _Alearning1State extends State<Alearning1> {
  late int id = 0;

  List _loaddata = [];

  _fetchData() async {
    var res = await Api().getData('/api/video_all_view');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;
      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg: "Currently there is no data available",
          backgroundColor: Colors.black,
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text(
              'Videos',
            ),
          ),
          body: Stack(children: [
            SingleChildScrollView(
              child: Container(
                // height: size.height * .45,
                  decoration: BoxDecoration(
                    color: Colors.green,
                  )),
            ),
            SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                                itemCount: _loaddata.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  id = _loaddata[index]['id'];
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 17),
                                              blurRadius: 14,
                                              spreadRadius: -23)
                                        ]),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoPlayerScreens(id: id)));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(
                                              "images/videoooooos.png",
                                              width: 50,
                                              height: 50,
                                            ),
                                            Spacer(),
                                            Text(
                                              _loaddata[index]['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ])))
          ]),


          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>alearning(),));

            },
            label: const Text('New'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ));
  }
}




