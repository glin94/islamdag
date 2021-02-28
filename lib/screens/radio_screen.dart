import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';

class RadioScreen extends StatefulWidget {
  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  var playerState = FlutterRadioPlayer.flutter_radio_paused;
  var volume = 0.8;
  @override
  void initState() {
    super.initState();
    initRadioService();
  }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init("Радио", "Прямой эфир",
          "http://online.radiovatan.ru:8000/live", "false");
    } on PlatformException {
      print("Ошибка регистрации сервиса");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/radio_bg.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                centerTitle: true,
                title: Text("Радио"),
                backgroundColor: Colors.transparent,
                elevation: 0,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/radio_background.png",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                fit: BoxFit.cover,
              ),
              Slider(
                  value: volume,
                  min: 0,
                  max: 1.0,
                  onChanged: (value) => setState(() {
                        volume = value;
                        _flutterRadioPlayer.setVolume(volume);
                      })),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: StreamBuilder(
                  stream: _flutterRadioPlayer.isPlayingStream,
                  initialData: playerState,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    String returnData = snapshot.data;
                    print("object data: " + returnData);
                    switch (returnData) {
                      case FlutterRadioPlayer.flutter_radio_stopped:
                        return RaisedButton(
                            color: Theme.of(context).accentColor,
                            child: Text("Начать слушать заново"),
                            onPressed: () async {
                              await initRadioService();
                            });
                        break;
                      case FlutterRadioPlayer.flutter_radio_loading:
                        return CircularProgressIndicator();
                      case FlutterRadioPlayer.flutter_radio_error:
                        return RaisedButton(
                            color: Theme.of(context).accentColor,
                            child: Text("Повторить"),
                            onPressed: () async {
                              await initRadioService();
                            });
                        break;
                      default:
                        return IconButton(
                            color: Colors.white,
                            iconSize: 70,
                            onPressed: () async {
                              print("button press data: " +
                                  snapshot.data.toString());
                              await _flutterRadioPlayer.playOrPause();
                            },
                            icon: snapshot.data ==
                                    FlutterRadioPlayer.flutter_radio_playing
                                ? Icon(
                                    FlutterIcons.pause_circle_outline_mdi,
                                  )
                                : Icon(
                                    FlutterIcons.play_circle_outline_mdi,
                                  ));
                        break;
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
