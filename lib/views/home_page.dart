import 'dart:io';

import 'package:downloader_flutter/bloc/app_bloc.dart';
import 'package:downloader_flutter/bloc/app_event.dart';
import 'package:downloader_flutter/bloc/app_state.dart';
import 'package:downloader_flutter/models/data_model.dart';
import 'package:downloader_flutter/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_downloader/image_downloader.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int progress = 0;

  // final ReceivePort _receivePort = ReceivePort();
  // static downloadingCallback(id, status, progress) {
  //   ///Looking up for a send port
  //   SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

  //   ///ssending the data
  //   sendPort!.send([id, status, progress]);
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   ///register a send port for the other isolates
  //   IsolateNameServer.registerPortWithName(
  //       _receivePort.sendPort, "downloading");

  //   ///Listening for the data is comming other isolataes
  //   _receivePort.listen((message) {
  //     setState(() {
  //       progress = message[2];
  //     });

  //     print(progress);
  //   });

  //   FlutterDownloader.registerCallback(downloadingCallback);
  // }

//   Future Download(String url, String title) async {
//     try {
//       //new Approach
//       var id = await ImageDownloader.downloadImage(
//           'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg');
//       if (id != null) {
//         print('Image is saved $id');
//       }
//       return 'success';
//     } catch (e) {
//       print(e);
//     }
//   }
   Future Download(String url, String title) async {
    try {
      //new Approach
      var id = await ImageDownloader.downloadImage(url);
      if (id != null) {
        print('Image is saved ${id}');
      }
      return 'success';
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    UserDataSource userDataSource = UserDataSource();
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc')),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(
            child: ElevatedButton(
                onPressed: () {
                  // UserBloc().add(LoadingUserEvent)
                  BlocProvider.of<UserBloc>(context)
                      .add(const LoadingUserEvent());
                },
                child: const Text('Fetch Data')),
          );
        }
        if (state is UserLoadedState) {
          List<UserModel> usersList = state.users;
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SingleChildScrollView(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 80,
                            child: Image.network(
                                usersList[index].thumbnailUrl.toString())),
                        Text(
                          usersList[index].id.toString(),
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () async {
                              await Download(userList[index].thumbnailUrl.toString(),userList[index].id.toString());
//                               dynamic list =
//                                   (usersList[index].thumbnailUrl.toString());
//                               List<File> files = [];
//                               for (var url in list) {
//                                 try {
//                                   var ImageId =
//                                       await ImageDownloader.downloadImage(
//                                           url,
//                                           destination: AndroidDestinationType
//                                               .directoryDownloads
//                                             ..subDirectory(
//                                                 "flutter_downloader"));
//                                   var path = await ImageDownloader.findPath(
//                                       ImageId.toString());
//                                   await ImageDownloader.open(path.toString());
//                                   files.add(File(path.toString()));
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                                 setState(() {
//                                   progress = 100;
//                                 });
//                               }
                              
                            },
                            icon: const Icon(Icons.download))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
// }
//    Download(usersList[index].thumbnailUrl.toString(),
//                                   usersList[index].title.toString());


  // final status = await Permission.storage.request();

  //                             if (status.isGranted) {
  //                               final externalDir =
  //                                   await getExternalStorageDirectory();

  //                               final id = await FlutterDownloader.enqueue(
  //                                 url:
  //                                     "https://jsonplaceholder.typicode.com/photos",
  //                                 savedDir: externalDir!.path,
  //                                 fileName: "download",
  //                                 showNotification: true,
  //                                 openFileFromNotification: true,
  //                               );
  //                             } else {
  //                               print("Permission deined");
  //                             }
