import 'package:flutter/material.dart';
import 'package:flutter_aisa/conseils.dart';
import 'package:flutter_aisa/etape.dart';
import 'package:flutter_aisa/poisson.dart';
import 'package:flutter_aisa/suivi.dart';
import 'api.dart';

class TabsSegment extends StatefulWidget {
  @override
  _TabsSegmentState createState() => _TabsSegmentState();
}

class _TabsSegmentState extends State<TabsSegment> {
  late int choice = 0;
  late Api api = Api();
  var getData;
  late List<Widget> culturesWidget = [];

  selectData() {
    culturesWidget = [];
    getData.forEach((item) {
      culturesWidget.add(
        GestureDetector(
          onTap: () {
            setState(() {
              choice = item['id'];
              selectData();
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            width: 85,
            height: 85,
            child: CircleAvatar(
              backgroundImage: NetworkImage(api.path() + item['image_culture']),
            ),
            decoration: BoxDecoration(
                color: item['id'] == choice ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      );
    });
  }

  _get_culture() async {
    var data = await api.get('liste-culture');
    print(data);

    setState(() {
      choice = data[0]['id'];
      getData = data;

      data.forEach((item) {
        culturesWidget.add(
          GestureDetector(
            onTap: () {
              setState(() {
                choice = item['id'];
                selectData();
                // print('index : ' + item['id'].toString());
                // print('choice : $choice');
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: 85,
              height: 85,
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(api.path() + item['image_culture']),
              ),
              decoration: BoxDecoration(
                  color: item['id'] == choice ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        );
        // index++;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _get_culture();
  }

  @override
  Widget build(BuildContext context) {
    if (culturesWidget.length == 0) {
      _get_culture();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('AISA'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: culturesWidget,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 160,
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Suivi(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/calendrier.png',
                                  color: Colors.white,
                                  width: 50,
                                  height: 55,
                                ),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Entrer la date de debut suivez votre culture',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          height: 200,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CultureEtape(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/suivi.png',
                                  color: Colors.white,
                                  width: 50,
                                  height: 55,
                                ),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Suivi par étape',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          height: 200,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Conseils(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/conseils.png',
                                  color: Colors.white,
                                  width: 50,
                                  height: 55,
                                ),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Conseils culture',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/poisson.png',
                        color: Colors.blue,
                        width: 60,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Tilapia',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 145,
                  color: Colors.blue,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Poisson(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/alimentations.png',
                                  color: Colors.white,
                                  width: 50,
                                  height: 55,
                                ),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Alimentation des poissons',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          height: 200,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Suivi(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/maintenance.png',
                                  color: Colors.white,
                                  width: 50,
                                  height: 55,
                                ),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Maintenance',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          height: 200,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Conseils(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/attention-removebg-preview.png',
                                  color: Colors.white,
                                  width: 50,
                                  height: 55,
                                ),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Attention',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Image.asset(
                'assets/images/item-girl.png',
                width: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
