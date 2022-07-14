import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverHeader(),
            pinned: true,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey, width: 1))),
                child: Text(index.toString()),
              );
            }, childCount: 60),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomSliverHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    double maxShrinkOffset = this.maxExtent - this.minExtent;
    double t = (shrinkOffset / maxShrinkOffset).clamp(0.0, 1.0) as double;
    double left = MediaQuery.of(context).size.width / 2.5;
    double imageLeft = Tween<double>(begin: 0, end: left).transform(t);
    double imageY = (MediaQuery.of(context).size.width - 100) / 2 + imageLeft;
    double imageX = Tween<double>(begin: 100, end: 36).transform(t);
    double imageSize = Tween<double>(begin: 100, end: 66).transform(t);
    return Stack(
      children: [
        Image.asset(
          shrinkOffset >= 150 ? 'images/bg_small.png' : 'images/bg.png',
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
        ),
        Column(
          children: [
            Container(
              height: kToolbarHeight + 60,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/icon_header.png',
                        width: 20.0,
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Text(
                        'User Settings',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 22.0, top: 8.0),
                    child: Text(
                      'V6.6.99',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: imageX,
          left: imageY,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: PhysicalModel(
                  clipBehavior: Clip.antiAlias,
                  shadowColor: Colors.black.withOpacity(0.6),
                  elevation: 6,
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  child: Image.asset(
                    'images/avatar.jpg',
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 260;

  @override
  double get minExtent => kToolbarHeight + 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
