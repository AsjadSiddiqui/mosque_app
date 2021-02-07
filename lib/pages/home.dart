import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/main_bloc.dart';
import '../extensions/string_extension.dart';
import '../widgets/clock.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Timer _timer;
  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   print('SSSSSSS');
    //   setState(() {});
    // });
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double height =
        MediaQuery.of(context).size.height - 55 - statusBarHeight;

    final MainBloc mainBloc = context.watch<MainBloc>();
    const Color textColor = Color(0xFF778089);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          leading: const Icon(Icons.menu),
          backgroundColor: Colors.black,
          title: const Text(
            'MY MASJID',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height - 52,
              width: width,
              // color: Colors.black,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: width,
                      height: height - 153,
                      color: const Color(0xFF131313),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Image.network(
                            mainBloc.masjidImageURL,
                            height: 0.04 * height,
                            width: 0.15 * width,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            mainBloc.masjidName
                                .toLowerCase()
                                .capitalizeFirstofEach,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          Text(
                            mainBloc.masjidNameArabic,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: textColor,
                            ),
                          ),
                          FittedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Text(
                                mainBloc.masjidAddress,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 18,
                            ),
                            child: AnalogClock(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 101,
                      width: width,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 52,
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xFF131313),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withOpacity(0.05),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Fajr Adhan in',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      color: Color(0xFF63C1D5),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: '4',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        color: Color(0xFF63C1D5),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'h ',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF63C1D5),
                          ),
                        ),
                        TextSpan(
                          text: '50',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF63C1D5),
                          ),
                        ),
                        TextSpan(
                          text: 'min',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF63C1D5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
