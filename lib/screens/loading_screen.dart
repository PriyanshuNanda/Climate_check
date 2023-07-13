import 'package:flutter/material.dart';
import 'package:climate/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climate/screens/location_screen.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocation();
  }
  void getLocation() async {
    //for getting the location
    WeatherModel weatherModel=WeatherModel();
    dynamic jData= await weatherModel.getLocationData();
    print(jData);
      if(context.mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LocationScreen(locationWeather: jData,);
        }));
      }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:SpinKitRipple(color: Colors.cyanAccent,size: 300,),
      ),
    );
  }
}
