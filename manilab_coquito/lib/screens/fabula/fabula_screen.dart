import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:manilab_coquito/db/fabula_model.dart';
import 'package:manilab_coquito/screens/fabula/fabula_controller.dart';

class FabulaScreen extends StatefulWidget {
  const FabulaScreen({super.key});

  @override
  FabulaScreenState createState() => FabulaScreenState();
}

class FabulaScreenState extends State<FabulaScreen> {
  final FabulaController _controller = new FabulaController();
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
    // how to get parameters from the route
    _controller.entity = ModalRoute.of(context)!.settings.arguments! as FabulaModel;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  // image: AssetImage('assets/images/1.jpg'),
                  image: _controller.entity!.imageBody,
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 50.0),
                child: Container(
                  color: Colors.transparent,
                  child: BodyWidget(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget BodyWidget() {
    return Container(
      // child: Image(
      //   // image: AssetImage('assets/images/1.jpg')
      //   image: _controller.entity!.imageBody,
      // ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(height: 20,),
          Text("El asno y el lobo", style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold,),),
          SizedBox(height: 20,),
          Text('Cierto asno, viendo que se le acercaba un lobo y que no podía escapar de él, simuló encontrarse cojo.\n\n'
              'El lobo, acercándose, le preguntó la causa de su cojera. El borrico le respondió que se le había introducido una espina en una de sus patas. Y añadió:\n\n'
              '—Quíteme, por favor, esa espina, señor lobo y devóreme cuando le plazca, sin temor de lastimarse la boca.\n\n'
              'El lobo se dejó convencer mansamente; pero, al levantar la pata del asno, recibió tan terrible coz que se quedó sin un solo diente en las mandíbulas.\n\n'
              '—Bien merecido lo tengo, porque siendo mi oficio carnicero, ¿por qué me metí a curandero? —dijo el lobo.\n'),
          Text("MORALEJA", style: TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold,),),
          Text("No cambies de oficio,\n si no recibes beneficios"),
        ],
      ),
    );
  }
}

