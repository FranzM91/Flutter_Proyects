import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manilab_coquito/screens/home/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = new HomeController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refreshView);
    });
    super.initState();
  }

  void refreshView() {
    setState(() {});
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Stack(
            children: [
              Text(
                'Fabulas de Esopo',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.white,
                ),
              ),
              const Text(
                'Fabulas de Esopo',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ],
          )
        ),
        backgroundColor: const Color.fromARGB(255, 96, 170, 226),
      ),
      body: SingleChildScrollView(
        // child: ListView.builder(
        //   itemCount: _controller.listFabula.length,
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       title: Text(_controller.listFabula[index].name),
        //       leading: _controller.listFabula[index].imageUrl,
        //       onTap: () {
        //         // navigate to other screen
        //         Navigator.pushNamed(context, 'fabula');
        //       },
        //     );
        //   },
        // ),
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
          child: Column(
            children: [
              SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                itemCount: _controller.listFabula.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (c, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'fabula', arguments: _controller.listFabula[i]);
                    },
                    child: SizedBox(
                      height: 125,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // () {
                          //   if (i % 2 == 0) {
                          //     return Expanded(
                          //       child: Container(
                          //         color: Colors.redAccent,
                          //       ),
                          //     );
                          //   } else {
                          //     return Expanded(
                          //       child: Container(
                          //         color: Colors.blueAccent,
                          //       ),
                          //     );
                          //   }
                          // }(),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 100,
                                height: 100,
                                // margin: EdgeInsets.only(right: 14),
                                // color: const Color(0xffD0D0D0),
                                // child: Image(image: _controller.listFabula[i].imageHeader),
                                // dorber radius
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: _controller.listFabula[i].imageHeader,
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.rectangle
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 2,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            // "El asno y el lobo",
                                            _controller.listFabula[i].name,
                                            style: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          // "No Cambies de oficio, si no recibes beneficio",
                                          _controller.listFabula[i].message,
                                          style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // SizedBox(
                                        //   height: 8,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const Icon(
                                        //       Icons.star,
                                        //       color: Colors.black,
                                        //     ),
                                        //     Text(
                                        //       "4.8",
                                        //       style: GoogleFonts.workSans(
                                        //         textStyle: TextStyle(
                                        //           fontSize: 14,
                                        //           color: Colors.black,
                                        //           fontStyle: FontStyle.normal,
                                        //           fontWeight: FontWeight.w600,
                                        //         ),
                                        //       ),
                                        //       maxLines: 1,
                                        //       overflow: TextOverflow.ellipsis,
                                        //     ),
                                        //     SizedBox(
                                        //       width: 16,
                                        //     ),
                                        //     Flexible(
                                        //       child: Text(
                                        //         "(156 reviews)",
                                        //         style: GoogleFonts.workSans(
                                        //           textStyle: TextStyle(
                                        //             fontSize: 14,
                                        //             color: Colors.black,
                                        //             fontStyle: FontStyle.normal,
                                        //             fontWeight: FontWeight.w600,
                                        //           ),
                                        //         ),
                                        //         maxLines: 1,
                                        //         overflow: TextOverflow.ellipsis,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // return i % 2 == 0 ? ContentRight(i): ContentLeft(i);
                },
                separatorBuilder: (c, i) {
                  // return SizedBox(height: 0.1);
                  return const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  );
                },
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(
      //         parent: AlwaysScrollableScrollPhysics()),
      //     child: Padding(
      //       padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
      //       child: Column(
      //         children: [
      //         ],
      //       ),
      //     ),
      //   ),
      // )
    );
  }

  Widget ContentLeft(int i) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'fabula', arguments: _controller.listFabula[i]);
      },
      child: SizedBox(
        height: 125,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 2,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              // "El asno y el lobo",
                              _controller.listFabula[i].name,
                              style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            // "No Cambies de oficio, si no recibes beneficio",
                            _controller.listFabula[i].message,
                            style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.star,
                          //       color: Colors.black,
                          //     ),
                          //     Text(
                          //       "4.8",
                          //       style: GoogleFonts.workSans(
                          //         textStyle: TextStyle(
                          //           fontSize: 14,
                          //           color: Colors.black,
                          //           fontStyle: FontStyle.normal,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       ),
                          //       maxLines: 1,
                          //       overflow: TextOverflow.ellipsis,
                          //     ),
                          //     SizedBox(
                          //       width: 16,
                          //     ),
                          //     Flexible(
                          //       child: Text(
                          //         "(156 reviews)",
                          //         style: GoogleFonts.workSans(
                          //           textStyle: TextStyle(
                          //             fontSize: 14,
                          //             color: Colors.black,
                          //             fontStyle: FontStyle.normal,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //         maxLines: 1,
                          //         overflow: TextOverflow.ellipsis,
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 100,
                  height: 100,
                  // margin: EdgeInsets.only(right: 14),
                  // color: const Color(0xffD0D0D0),
                  // child: Image(image: _controller.listFabula[i].imageHeader),
                  // dorber radius
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: _controller.listFabula[i].imageHeader,
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.rectangle
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget ContentRight(int i) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'fabula', arguments: _controller.listFabula[i]);
      },
      child: SizedBox(
        height: 125,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 100,
                  height: 100,
                  // margin: EdgeInsets.only(right: 14),
                  // color: const Color(0xffD0D0D0),
                  // child: Image(image: _controller.listFabula[i].imageHeader),
                  // dorber radius
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: _controller.listFabula[i].imageHeader,
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.rectangle
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 2,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              // "El asno y el lobo",
                              _controller.listFabula[i].name,
                              style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            // "No Cambies de oficio, si no recibes beneficio",
                            _controller.listFabula[i].message,
                            style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.star,
                          //       color: Colors.black,
                          //     ),
                          //     Text(
                          //       "4.8",
                          //       style: GoogleFonts.workSans(
                          //         textStyle: TextStyle(
                          //           fontSize: 14,
                          //           color: Colors.black,
                          //           fontStyle: FontStyle.normal,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       ),
                          //       maxLines: 1,
                          //       overflow: TextOverflow.ellipsis,
                          //     ),
                          //     SizedBox(
                          //       width: 16,
                          //     ),
                          //     Flexible(
                          //       child: Text(
                          //         "(156 reviews)",
                          //         style: GoogleFonts.workSans(
                          //           textStyle: TextStyle(
                          //             fontSize: 14,
                          //             color: Colors.black,
                          //             fontStyle: FontStyle.normal,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //         maxLines: 1,
                          //         overflow: TextOverflow.ellipsis,
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
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