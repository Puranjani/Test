import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InternShala',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  late AnimationController _animationController;

  Random _random = new Random();
  double _last = 0.0;
  String _direction = '';

  void getRandom(){
    setState(() {
      _last = _random.nextInt(15) * 0.25;
      if(_last.toString().split('.').last == '25'){
        _direction = 'North';
      }else if(_last.toString().split('.').last == '5'){
        _direction = 'West';
      }else if(_last.toString().split('.').last == '75'){
        _direction = 'South';
      }else{
        _direction = 'East';
      }
    });
  }

  String get direction => _direction;

  @override
  void initState() {
    super.initState();
    spinPen();
  }

  void spinPen(){
    _animationController = AnimationController(
      vsync: this, duration: Duration(seconds: 10),
    );
    _animationController.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      color: direction != 'North' ? Colors.green : Colors.orange,
                      child: Text(
                        'North',
                        style: direction != 'North' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white
                        ),
                      )
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      color: direction != 'South' ? Colors.green : Colors.orange,
                      child: Text(
                        'South',
                        style: direction != 'South' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white
                        ),
                      )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.rotate(
                      angle: - 3.14 / 2,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: direction != 'East' ? Colors.green : Colors.orange,
                        child: Text(
                          'East',
                          style: direction != 'East' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                    Transform.rotate(
                      angle: 3.14 / 2,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: direction != 'West' ? Colors.green : Colors.orange,
                        child: Text(
                          'West',
                          style: direction != 'West' ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                RotationTransition(
                  turns: Tween<double>(begin: 0.0, end: _last).animate(
                    CurvedAnimation(
                      parent: _animationController, curve: Curves.easeInOut
                    )
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if(_animationController.isCompleted){
                        setState(() {
                          getRandom();
                          spinPen();
                        });
                        Future.delayed(Duration(
                          seconds: 10),
                          () => showCupertinoModalPopup(
                            context: context,
                            barrierDismissible: false,
                            builder: (_){
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                                child: Center(
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: FloatingActionButton.extended(
                                            onPressed: () => Navigator.pop(context),
                                            label: Text('Back'),
                                            icon: Icon(Icons.arrow_back),
                                            elevation: 0,
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[    
                                                  Text('\t\tPen Pointing to', softWrap: true,style: Theme.of(context).textTheme.headline5,),
                                                  TextButton(child: Text('$direction',style: Theme.of(context).textTheme.headline5!.copyWith(
                                                    color: Colors.orange
                                                  ),),onPressed: (){},),
                                                ],
                                              ),
                                              Text('direction\t\t',softWrap: true,style: Theme.of(context).textTheme.headline5,),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(50),
                                          child: MaterialButton(onPressed: () => Navigator.pop(context), child: Text('OK',style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 23
                                          ),), color: Colors.lightGreen,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                        );
                      }
                    },
                    child: Card(
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/pen.jpg',
                        width: 190,
                        height: 190,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
