import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:torch_light/torch_light.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  double screenBright=0.5;
  void initState() {
   getCurrentBright();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flash  & Brightness Page"),centerTitle: true,
      ),
      body: Center(
        child: Container(decoration: const BoxDecoration(image: DecorationImage
          (image: NetworkImage("https://t3.ftcdn.net/jpg/02/95/40/98/360_F_295409899_0Vh1aThO2RDh0NGOt82sG6qKjMGaLrJB.jpg"),fit: BoxFit.fill
        )
        ),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){
              turnONTorch(context);
              const snackBar = SnackBar(
                    content: Text('flash turned on'),

                 );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

            }, child: const Text("Turn on flash"),



            ),
          const Text(" slide to change brightness level",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),

          Slider(
            value: screenBright,
            onChanged: (val){
            setBright(val);

          }, min: 0,
            max: 1,
          ),
          ElevatedButton(onPressed: (){
            turnOffTorch(context);
            const snackBar = SnackBar(
              content: Text('flash turned off'),

            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, child: const Text("Turn off flash")
          )
    ],),
        ),
      ),
    );
  }

  Future<void> turnONTorch(BuildContext context)async{

    try{
      await TorchLight.enableTorch();

    }on Exception catch(_){
      const Text("can not enable torch");
    }
  }
  Future<void> turnOffTorch(BuildContext context)async{

    try{
      await TorchLight.disableTorch();

    }on Exception catch(_){
      const Text("can not off the torch");
    }
  }
  Future<void> getCurrentBright()async{
    double bright= await ScreenBrightness().current;
    if(bright>1){
      bright/=10;
      screenBright=bright;
      setState(() {

      });
    }
  }
  Future<void> setBright(double value)async{
    await ScreenBrightness().setScreenBrightness(value);
    screenBright=value;
    setState(() {
      
    });

  }
}
