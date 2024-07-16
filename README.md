
# Gov.-Service-App

A Gov.-Service-App project created in flutter. Gov.-Service-App supports both ios and android, clone the appropriate branches mentioned below:

* For Mobile: https://github.com/rajiyanareja1517/Gov.-Service-App
 

Download or clone this repo by using the link below:

```
https://github.com/rajiyanareja1517/Gov.-Service-App.git
```

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- screens/
|- utils/
|- view/
|- provider/
|- main.dart
```

### screens

This directory screens all the screen of the application together in one place. A separate file is created for each type as shown in example below:

```
screens/
|- Gservice.dart
|- HomePage.dart
|- SplashScreen.dart
```

### utils

Contains the common file(s) and utilities used in a project. The folder structure is as follows:

```

|- utils/
    |- data/

```


### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:flutter/material.dart';
import 'package:government_service/provider/change_provider.dart';
import 'package:government_service/view/screen/home_page.dart';
import 'package:government_service/view/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ChangeProvider();
      },
      builder: (context,_) {
        return MaterialApp(
          title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: {
            "home":(context)=>HomePage(),
            "/":(context)=>SplashScreen(),
        },
        );
      }
    );
  }
}



```


![Screenshot_20240714_185130](https://github.com/user-attachments/assets/88808cf6-d957-4ea0-b27e-58b40d995ebf)
![Screenshot_20240714_185202](https://github.com/user-attachments/assets/b4aa5334-4591-42af-bc68-47e022b49fb7)
![Screenshot_20240714_185718](https://github.com/user-attachments/assets/47a55e07-a22a-41f8-b3ed-f9a81f4ddafd)
![Screenshot_20240714_185754](https://github.com/user-attachments/assets/5f7a189d-12f2-4810-b53f-ca4146614606)
![Screenshot_20240714_185809](https://github.com/user-attachments/assets/27505dc8-2317-417b-9202-275f06161889)
![Screenshot_20240714_185821](https://github.com/user-attachments/assets/80be0423-e42d-4475-9ad4-50cab2affbf2)


## Conclusion

Again to note, this is example can appear as my code for what it is - but it is an example only. If you liked my work, don’t forget to ⭐ star the repo to show your support.
