# Insta Like Button

[![Package Version](https://img.shields.io/pub/v/insta_like_button?color=red)](https://github.com/lomsa-dev/insta_like_button "Published package version")
[![LICENSE](https://img.shields.io/badge/License-MIT-red.svg)](https://github.com/lomsa-dev/http-mock-adapter#License "Project's LICENSE section")

---
## Installing

### Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  insta_like_button: ^0.1.0
```

### Install it

You can install packages from the command line:

```sh
$ flutter pub get
...
```
### Import it

Now in your Dart code, you can use:

```dart
import 'package:insta_like_button/insta_like_button.dart';
```
---
## Usage & Overview
<img src="https://raw.githubusercontent.com/theiskaa/insta-like-button/develop/example/overview/overview.gif" align = "right" height = "400px">

### With required parameters.
```dart
InstaLikeButton(
  image: AssetImage("example/overview/img.jpg"),
  onChanged: () {
    // Do something...
  },
),
```

### With all parameters (Customized InstaLikeButton).
```dart
InstaLikeButton(
  image: NetworkImage("https://picsum.photos/200/300"),
  onChanged: () {
    // Do something...
  },
  icon: Icons.favorite_border,
  iconSize: 80,
  iconColor: Colors.red,
  curve: Curves.fastLinearToSlowEaseIn,
  height: 200,
  width: MediaQuery.of(context).size.width - 20,
  duration: Duration(seconds: 1),
  onImageError: (e, _) {
    // Do something...
  },
  imageAlignment: Alignment.topLeft,
  imageBoxfit: BoxFit.fill,
  imageScale: 2.0,
  imageColorFilter: ColorFilter.mode(
    Colors.black.withOpacity(0.5),
    BlendMode.dstATop,
  ),
),
```
