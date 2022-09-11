import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_project/Provider/PhotoSize.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PhotoSize>(
        create: (context) => PhotoSize(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  final player = AudioPlayer();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Center(
              child: Consumer<PhotoSize>(builder: (context, value, child) {
            return Column(
              children: [
                Container(
                  height: 300,
                  width: 300,
                  child: Column(
                    children: [
                      AnimatedContainer(
                        color: Colors.amber,
                        child: Image.network(
                            "https://picsum.photos/id/237/200/300",
                            fit: BoxFit.fill),
                        duration: const Duration(milliseconds: 200),
                        width: value.play ? 300.0 : 150.0,
                        height: value.play ? 300.0 : 150.0,
                      ),
                    ],
                  ),
                ),
                FloatingActionButton(
                    backgroundColor: Colors.green,
                    child:
                        value.play ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                    onPressed: () async {
                      value.resize();

                      if (value.play) {
                        await player.setAudioSource(AudioSource.uri(Uri.parse(
                            'http://cast1.my-control-panel.com:7099/live')));

                        await player.play();
                      } else
                        await player.pause();
                    })
              ],
            );
          }))),
    );
  }
}
