import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class gridCat extends StatefulWidget {
  gridCat({Key? key}) : super(key: key);

  @override
  State<gridCat> createState() => _gridCatState();
}

class _gridCatState extends State<gridCat> {
  var isSelected = false;
  var selectedIndex = 10000;
  var trigger = false;

  static const REST_API_KEY =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDIyZjE3NUU4MjlmMGE4ODgxMEIyODU5ZjJFNTU0QzEyNjEyNzUyOUYiLCJpc3MiOiJuZnQtc3RvcmFnZSIsImlhdCI6MTY4NTgzOTUyMjA1NywibmFtZSI6ImV0aHNlb3VsIn0.gbCfSd1YcBHWxyhvSVytMKZPeNr0mNftqi_J-DCJUU4';
  Dio dio = new Dio();

  Future<Map<String, dynamic>> mintRequest({required String filePath}) async {
    Response response;
    response = await dio.post('https://api.nft.storage/upload',
        data: {'image': '$filePath'},
        options: Options(
            contentType: "Blob/File",
            headers: {"Authorization": "Bearer ${REST_API_KEY}"}));
    return response.data;
  }

  final myProducts = [
    'assets/images/cat/1.png',
    'assets/images/cat/2.png',
    'assets/images/cat/3.png',
    'assets/images/cat/4.png',
    'assets/images/cat/5.png',
    'assets/images/cat/6.png',
    'assets/images/cat/7.png',
    'assets/images/cat/8.png',
    'assets/images/cat/9.png',
    'assets/images/cat/10.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        elevation: 0,
        title: Text(
          'MarketPlace',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(children: [
        Column(
          children: [
            Container(height: 200, color: Colors.white),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 3,
                    mainAxisExtent: 215,
                  ),
                  itemCount: myProducts.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: InkWell(
                        onTap: () {
                          if (isSelected == false) {
                            isSelected = true;
                            selectedIndex = index;
                            setState(() {});
                          } else {
                            isSelected = false;
                            selectedIndex = 10000000;
                            setState(() {});
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              child: Image.asset(myProducts[index]),
                            ),
                            (isSelected && selectedIndex == index)
                                ? Image.asset('assets/icons/CheckCircle.png',
                                    width: 40)
                                : Text("")
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 600),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () async {
                  var result;
                  var workingInProgress = false;

                  //trigger false => true
                  trigger = true;

                  if (isSelected == true) {
                    result = await mintRequest(
                        filePath: 'assets/images/cat/${selectedIndex + 1}.png');
                    print(result);
                  }
                },
                child: Container(
                  width: 360,
                  height: 60,
                  child: Center(
                    child: Text(
                      'MINTING',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: isSelected ? Colors.purple : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
            )
          ],
        ),
        (trigger == true)
            ? Container(
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      alignment: AlignmentDirectional.center,
                      decoration: new BoxDecoration(
                        color: Colors.white70,
                      ),
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: new BorderRadius.circular(10.0)),
                        width: 300.0,
                        height: 200.0,
                        alignment: AlignmentDirectional.center,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Center(
                              child: new SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child: new CircularProgressIndicator(
                                  value: null,
                                  strokeWidth: 7.0,
                                ),
                              ),
                            ),
                            new Container(
                              margin: const EdgeInsets.only(top: 25.0),
                              child: new Center(
                                child: new Text(
                                  "loading.. wait...",
                                  style: new TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container()
      ]),
    );
  }
}
