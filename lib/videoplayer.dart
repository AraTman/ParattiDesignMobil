import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:qparattidesign/Animation/constants.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoPlayer extends StatefulWidget {
  String videoLink;
  VideoPlayer({this.videoLink});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        'https://paratti.forbigs.com/Video/${widget.videoLink.toString()}');
    await _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Paratti Design",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Container(
                height: 80,
                width: 260,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/voicered.png'),
                )),
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kRedColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 210,
                height: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logoblack.png'),
                        alignment: Alignment.center,
                        fit: BoxFit.contain)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 350,
              child: Center(
                child: _chewieController != null &&
                        _chewieController
                            .videoPlayerController.value.initialized
                    ? Chewie(
                        controller: _chewieController,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
    //scan barcode asynchronously
  }
}
