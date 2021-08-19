import 'package:flutter/material.dart';
import 'package:insta_like_button/insta_like_button.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Like Button/Card',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // To manage the ImageProvider. in error situation.
  var image;

  @override
  Widget build(BuildContext context) {
    // Initilaze [image] when page build.
    image = NetworkImage("https://picsum.photos/200/300");

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            /// With required parameters.
            InstaLikeButton(
              image: AssetImage("example/overview/img.jpg"),
              onChanged: () {
                // Do something...
              },
            ),
            const SizedBox(height: 30),

            /// With all parameters (Customized InstaLikeButton).
            InstaLikeButton(
              image: image,
              onChanged: () {
                // Do something...
              },
              icon: Icons.favorite_border,
              iconSize: 80,
              iconColor: Colors.blue,
              curve: Curves.fastLinearToSlowEaseIn,
              height: 250,
              width: MediaQuery.of(context).size.width - 20,
              duration: const Duration(seconds: 1),
              onImageError: (e, _) => setState(
                () => image = AssetImage("example/overview/img.jpg"),
              ),
              imageAlignment: Alignment.topLeft,
              imageBoxfit: BoxFit.fill,
              imageScale: 2.0,
              imageColorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.dstATop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
