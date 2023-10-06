import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import 'package:sizer/sizer.dart';
import 'package:social_media_app/Models/UsersModel.dart';
import 'package:social_media_app/Providers/user_provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<String> profileImages = [
    'Images/profile.jpeg',
    'Images/profile_2.jpeg',
    'Images/profile_3.jpeg',
    'Images/profile_4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: Platform.isIOS ? true : false,
        title: const Text('Instravel'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: profileImages.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: SizedBox(
                  child: Stack(
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.lightBlueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Image.asset(
                          profileImages[index],
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      index == 0
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7.w, vertical: 9.6.h),
                              child: SizedBox(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add_box_outlined,
                                        color: Colors.lightBlueAccent,
                                      ))),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          FutureBuilder<List<UserModel>>(
              future: userProvider.getUsers(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 51.h,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 6.h,
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 3.w),
                                                child: Container(
                                                  height: 5.h,
                                                  width: 13.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                      color: Colors
                                                          .lightBlueAccent,
                                                    ),
                                                  ),
                                                  child: index % 2 == 0
                                                      ? Image.asset(
                                                          profileImages[2],
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          profileImages[3],
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    snapshot.data![index].name!
                                                        .toString(),
                                                  ),
                                                  Text(
                                                      '${index + 1} minute ago'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.more_vert,
                                                  size: 4.h),
                                              onPressed: () {})
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                      width: double.infinity,
                                      child: index % 2 == 0
                                          ? Image.asset(
                                              profileImages[0],
                                              fit: BoxFit.fitWidth,
                                            )
                                          : Image.asset(
                                              profileImages[1],
                                              fit: BoxFit.fitWidth,
                                            ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 5.h,
                                      child: Text(
                                        '  ${snapshot.data![index].company!.catchPhrase!}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 5.h,
                                      child: Text(
                                        '  #${snapshot.data![index].company!.name!.toString()}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        height: 5.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                 Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                   size: 3.h,
                                                ),
                                                Text(
                                                    '${index + 1}.${index}K Like',style:TextStyle(
                                                    fontSize: 9.sp)),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                 Icon(
                                                  Icons.comment,
                                                   size: 3.h,
                                                ),
                                                Text(
                                                    '${index + 1}.${index + 2}K Commment',style:TextStyle(
                                                    fontSize: 9.sp))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                index % 2 == 0
                                                    ? Text(
                                                        '${index + 5}.${index}K Share',style:TextStyle(
                                                    fontSize: 9.sp))
                                                    : Text(
                                                        '${index + 1}.${index + 4}K Share',style: TextStyle(
                                                  fontSize: 9.sp
                                                ),),
                                                 Icon(
                                                  Icons.share,
                                                  size: 3.h,
                                                ),
                                                // const SizedBox(width: 5,),
                                              ],
                                            ),
                                          ],
                                        )),

                                    // Card(
                                    //   child: ListTile(
                                    //       title: Text('Motivation $int'),
                                    //       subtitle: const Text('this is a description of the motivation')),
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              })
        ],
      ),
    );
  }
}
