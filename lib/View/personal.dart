import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app/Models/PhotoModel.dart';
import 'package:social_media_app/Providers/photo/provider.dart';

import '../Providers/user_provider/provider.dart';

class PersonalAccountScreen extends StatefulWidget {
  const PersonalAccountScreen({Key? key}) : super(key: key);

  @override
  State<PersonalAccountScreen> createState() => _PersonalAccountScreenState();
}

class _PersonalAccountScreenState extends State<PersonalAccountScreen> {
  List<String> imagesList = [
    'Images/profile.jpeg',
    'Images/profile_2.jpeg',
    'Images/profile_3.jpeg',
    'Images/profile_4.jpeg',
    'Images/add_icon.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: Platform.isIOS ? true : false,
          title: FutureBuilder(
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
                  return Row(
                    children: [
                      Text(userProvider.userModel![0].name!),
                      const Icon(Icons.arrow_drop_down_outlined)
                    ],
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 20.h,
                    width: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(image: AssetImage(imagesList[0])),
                    ),
                  ),
                  Column(
                    children: [
                      userProvider.userModel != null
                          ? Text(userProvider.userModel!.length.toString())
                          : const Text('...'),
                      Text(
                        'Posting',
                        style: TextStyle(
                            color: const Color(0xFF000093),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      userProvider.userModel != null
                          ? Text(
                              "${userProvider.userModel!.length * userProvider.userModel!.length * 3}")
                          : const Text('...'),
                      Text(
                        'Follower',
                        style: TextStyle(
                            color: const Color(0xFF000093),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      userProvider.userModel != null
                          ? Text(
                              "${userProvider.userModel!.length * userProvider.userModel!.length}")
                          : const Text('...'),
                      Text(
                        'Following',
                        style: TextStyle(
                            color: const Color(0xFF000093),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userProvider.userModel != null
                      ? Text(
                          "@${userProvider.userModel![0].name.toString().split(' ').first}")
                      : const Text('....'),
                  const SizedBox(
                    width: 30,
                  ),
                  userProvider.userModel != null
                      ? Text(
                          userProvider.userModel![0].address!.city.toString())
                      : const Text('....'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: imagesList.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.blueAccent,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: AssetImage(imagesList[index]),
                          ),
                        ),
                        userProvider.userModel != null &&
                                index != imagesList.length - 1
                            ? Text(
                                userProvider.userModel![index].name.toString())
                            : index == 4
                                ? const Text('')
                                : const Text('...')
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _tabSection(context)
            ],
          ),
        ));
  }
}

Widget _tabSection(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  final photoProvider = Provider.of<PhotoProvider>(context, listen: false);
  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const TabBar(tabs: [
          Tab(
            text: "",
            icon: Icon(Icons.menu),
          ),
          Tab(text: "", icon: Icon(Icons.play_arrow)),
        ]),
        SizedBox(
          //Add this to give height
          height: MediaQuery.of(context).size.height,
          child: TabBarView(children: [
            FutureBuilder<List<PhotoModel>>(
                future: photoProvider.getPhotos(context),
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
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: width / (height / 2)),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Image.network(
                                snapshot.data![index].url.toString(),
                                fit: BoxFit.fill,
                              ),
                            );
                            //     return Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: InkWell(
                            //         onTap: () {
                            //           /*Navigator.push(context, MaterialPageRoute(builder: (_){
                            //
                            // return Order(stock: list[i],);
                            // }));
                            //
                            //  */
                            //         },
                            //         child: Container(
                            //           height: 1000.0,
                            //           color: Colors.white,
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.start,
                            //             crossAxisAlignment: CrossAxisAlignment.start,
                            //             children: [
                            //               Row(
                            //                 mainAxisAlignment: MainAxisAlignment.end,
                            //                 children: [
                            //                   Icon(
                            //                     Icons.delete,
                            //                     color: Color(0xFF800000),
                            //                     size: 50.0,
                            //                   ),
                            //                 ],
                            //               ),
                            //               Padding(
                            //                 padding: const EdgeInsets.only(bottom: 8.0),
                            //                 child: Container(
                            //                   height: 30,
                            //                   width: MediaQuery.of(context).size.width,
                            //                   color: Color(0xFF800000),
                            //                   child: Center(
                            //                       child: Text(
                            //                     'A',
                            //                     style: TextStyle(
                            //                         color: Colors.white,
                            //                         fontWeight: FontWeight.bold),
                            //                   )),
                            //                 ),
                            //               ),
                            //               //  Image.network('http://192.168.43.95/Online_Qurbani_Project/images'+ list[i].image,width:MediaQuery.of(context).size.width*0.2,height:MediaQuery.of(context).size.height*0.05,),
                            //               Image.network('data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAH4AvQMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAADAQIEBQYABwj/xAA6EAACAQMDAgMHAgMGBwAAAAABAgMABBESITEFQRNRcQYiMmGBkfAHoRSxwTNCUtHh8RUWIyQ0Q1P/xAAZAQADAQEBAAAAAAAAAAAAAAABAgMABAX/xAAhEQACAgEEAwEBAAAAAAAAAAAAAQIRAxIhMVEEE0EiMv/aAAwDAQACEQMRAD8A9LjzUhSaaiCiqBntS2YUA07FKPUU7Ga1hoTFdjzod3cRWdtLcXLhIolLMx4AFeGe0Xt51jqV5I9vdyWtqHPhRQuV27aiOT3+tMlYrdHu4xT1xXz7ae2/tDAwZOqTvv8ABKdY/erfp36k9XhmD3MvjJn3lKggj+f71tLApI9lupViUknFYf2g6tqZo4wSD3pV9uOndVtvd1RykfC3eqW46vZTsVyM+RqUm0y0EmU8sbvJqIJpNWnSMkE8Zq6lktTECCuazHUZ8XMWj4dVLZShpE8t9GmrC6q3HTo/ChXD5J5FZSEePJGI8Z1bmtfZRrAgMjZ9KzYdJcW0ugcHNJJHJcSDIIWpfS0jnYHBxV6lpGF2Aorck9iL02Lw4wKnFadHEF4p+mqImR9FLoo2K7FE1AdFMli1Id6k4oMqnG1CzUZvqNo0jlHY6azN77PKJco2xHetnexyYY53xWRvLi+ExVRkD50ljxVlcf1JjzsrfanN+o6KM4P2ryITfOkM5zzVNBP2HrUf6mL4nvIwXzqyt/1MsmwGcj1BrxQSNmpFpia5iiPBb3vQbn9hW0B9h6H+oXtk3VenLa2zlLUqHbsZD2HoOa89ZhqwBsOM0Tqcnjl2kbQpGAgO4FR/FTOE3x5mnWyJP9MICTRAxG30oSuTwOew5/Of2p2zd/PcVmzUHhnMbZG1WSXMdx/5OoMNhIp3H+dVAOSTuaIhGxz9fOg6Y6tcBL29venyKGctEd0cHZqjydbaXTqzkb5qwSVWhaKVQ8TDdWwBVB1CxNlOQp1QtvG55I8j8xSaUOpsv+l9cZJhqbbNem+zt7D1CMMxA+VeIxNtkc1Z9L6zddN/sZD6E0kodFY5K5Pom38G2UEMMD50k3tLZ2rhZpVBJwMmvCrj286k0ZTKgkedZy86zeXj6p7hyc554rRhIWU4/D6xtb+G4iDo2QfnTnvYU5Yfevnj2e9vLqytBBNIxwMAmonU/bvqcsjeDNhfPyrVIzcKPpZJo3UFSKUyoDgsK+ebD9Tb+3t1UjWw5PFS7z9Urh/DMRbOfeGOKP66NcOz3wyJjmmSOujORgV4jJ+psjw/9NtwPKq8/qpdqHXSx8qH66N+ez12/wCoxGYwBwWPzqGbNGw3unNeF/8AON6/VGvJXYKf/WDxVsP1KuVGFibHbOKVwmGM4GPymKarLneijp0+NwaSPpdwzcEDzro1I51FsUyLjaidMkxNcSdkhI+pIH+dGXoUzdzRH6ZJZWsrb++VBzQU43QzhJK6K6VzJLqJ2G4pytpG31z+fI0A+u9PU7Z/PzY04iJUcnYnftnz/wB/50ZWz3+/56ioYBG2fqPz0oo1Y32HO44/DSsZEjxB3+/59KcjFt8DB+n53qMvkBvxlu34aKM6stu3z8+375H1oDEyORfU+a1I/wDIj8GYroYEAFQcE9x5VBjYA7HAx2/PL+VGjc5xjv2/PWgaioEEsZaN1wykgj500QzntWoCxSxrMwBYjDeo/wBMUqmEdhU3kaZVY01dmVNpM3K01enTsfhrWeLDnGFrvGiXgCh7ZB9UezNR9JuCeKMOhTseav8A+MX5VxvscGt7JB9UClX2emI+Kl/5dfO7Vat1J+xoLdSk/wAVZSmK440R09niB7z1D6j0VoE1qc1NbqcgO7UCfqRkUqxzTJysDUK2KPwWA3rhCTvRriXJwvFA8RhsKtuRNqCOwFEVsHigorc4oibneuNnYiUJAFqH1iQSdMnHkuaMRkHeonUGmXp0xgbSwG+3IrQrUg5L0MyuHYnSpO/NOAwx1MB5Ab/nakdpnPvscetcAO/5+b12nAHRtgUGB9z+Y2p+kHk5+f58v5UFSe3p+fWlL43P0HlQoayTzsT6+nf+ho8EE0x/6UTuc/3ELY+3zwa7oUP8deaUHuqQTnjPat/1Hrlt0GOCFoV8VwANKZLNXNlzaHpStnZg8b2R1t0jBNFLHIImhkEvZChz9vzmrK26NdPH4krw20eP/Y+5+laOS2k6/wBNmlminhuYwTA8GC6+SnzB2yKz3TbKKGeSFpHmfYSLKGyDzgqwH8vStjk8vDpmzY44JbrUgEiNAzxZZgrEBiNj5EfKgHJ4NeoWtq3/AAqK2ngiMRQZWRsDB3G3NUHtD0eBbeC26R0yEzZZp7lbojwwPNW7fPP0p3GvpFSv4Yvfzrjk0i79xXZpLGoUJmkdCO9O1Y4puSTRsGkFpPzphRs96kYxRECnmjqF0WV7Qk002zGrMoopCEo6mBwoqzZk0w2VWukAUMqtHUwaTQSOgj4oBPu5FHljQREkjC81T3HUBChYJgH4c81zpWdb25LASaQSccVFmmR7aYFgMrpA75NUd7etc5bLBVHGagOxBIBbPrV4Y6dkMmRtUic8Sg/HtmgmSJO+fz/eop1EbsSabVznoO8+RhRj50LVqb3jTe1OjGXUEZBYAj60GFI2nsyB062jmmiVl3YLuGOeN/tVt0qxuL68F51IBpj8IHEY/O9Q+itHNMInI9waiK1KSR+A0VuD4rjGR2Febmk09uT2sEFpXRB671U9KMENiHd3bDJDuw+dD6n1EXFvbG7gPiNMiazsxBOCMj1NHt+m23TTJc3BA1Es7sdyfmao+v8AVIeoWFw1toH8MwljZTnUVxmp42lJUWyx1YpJ9FNee0Ey3M/8Lcuy6yqrJ72rn6KoxsB8smqoX8+tJUVUk1YVo1AZmPO/lv286r/EJzgnz2qXA664QoZtEJwF51MxX+or1eDwOWXFj1y4jklt76GK9to11SAMNSgclSOcf05p1wITcSfwzaoScxnOcr2qjs219QhZUCqXVdIbGx2IPrnereC3eC2hVx8S5Q5zkZqM4pbl4Tb2YVY1xk0xtIO1EZDo2NMWHIzmkQ7BMa5WqQIvMU0x4PFYUGWPeh6snAqS8eobChrbkcn7UUwNA8nzobNg1JeM6eKhOCG4pkK0S728eQHWxCZ7DmqqeRWwzmQ5GQKLcl7mQooOAcMQNhUWdwshc4LcDyUdqaKSNNtnS5CKZSAOy8k+tRs8k80p1PlmOcGm4qiJtijYb9+KSurqIp2e1Etj/wBxH60On2/9snrWZvpo7KfwJdecE1peldXNvEocHLNknzrKQDIX1q3tlyyjkV5+VI9rx7o2s0Np1W3jkliWReQH4+1Z/ra9Oitp7KMxm4ZGGhB8O3epEcv8DZNcSajBH8WGAOPrXn9x1UypcSeGouLhveIGyr8v5VPDic3aKZs0cez6Kz+8ccHcbdqfAQsgDOUQ7MwXUcenem4yTgY+VLGoLZIJUfFXqcHhpWy2tQ5uFWN4ppY/dt1iUkOx21HbtzvXolt0eK46JDZPbgSwRFUk1HOec/XyrD9DktrG3fqbjSyHEar59hW09n+uz3Vq79QIiJ+E7Y4rhzzk/wCVsj0/HwRUbk92ZqSFomaNxhlJBHkaaFKjfijzarsvdgNpeRiQTvgk6W9Dg49KC0mkaSPlT0zmb3FUqaSUKBkGgtg7igyO47UaFciZCy6Dmo7hi+FNBWYqRqFO/icPkCtTA5Wtx5DLsaC6jPFLLckvsKG8hJzTIVtEDqF68pMceyeYNRbaFWRpZfgU6QP8TGk8NpCFByTwBRMeDAY2O+S37YqmyVIXdu2AmIDlQOPtTD86WQ5II3zzSHeqIm3Z3ekPNdXDmsA45o9muZ1JIAHPP9BQPKpfTgPFTW+jUcBs96NWBui+s7STKfCwJ7HB+xxV/Z2TKwyvrVJfX0fT4liDO9xpJUashc+YHNL0zqk1hGF8aWQ6clQhI+u1c2Xx3L+WduDzVDaSLL2s6gtt0+K0/wDuxyvyH4KwLqV3/u9q1s8Fr1sf8Rnl0nOgIJNhj6bZ+dR+rdGtrWxkfRMJOVDNwftTYYrGtP0n5GV5ZX8M9GuWUgr9TiprwxsuIgQx+ILVap28scUcXDIcAkGqNWRUqQguJFUQLsivqx5nirvpd7cSyASSDwxjChRgVQkM0wGlsseDtmrW0hcNGG8GNZD7uuTc/QZrOCYfZLsthcta9dmjnJ8K8A0kjghSAAfrQ7lZIpDHIuGH700dMt7y01JPJLMr6SxJXQexC/aiQ3TXvTv+4BW4t/dYY8tj/Q0ko/Roy+ABIVzzSLJqO42rkwwIHNNDaSQRSUO3QRwrcDimqoLbr9qJb6Ru29ELoOBQ4NyRpE7io+DnepEs4Ub1DLknIO1OhGCl02Nsq8yMN96rndpGy5yaJdzNOyluwoPengtrYMkrdLgXhQfOuOM7cUvam04h1cK4ikogsXvV30q2OhTupJ3bcaRjzHFU0MZlkCKQD86vLeAQdPmKyMsyFmV12/uE4ooWXRI6xDDDDBGA7OxLRtq1HbnJPI+WaHNFckI5yYioKvECB6kdjUezkPUVkD/2wUln+HIPPG37fWtB0C4AgCMuvThUY7emRSySqwxbuirmhW6u0t2j8OX4fHU7OuATqHmN/tR/ai502aqrYYOuEYg48v2xVletHbXlvbwa83ALO7nJC54HqRvVZ7VTNJasCQVaYBPdwQB/rmkQ76RlC2picAZ7CjwMxcIDz9KjU477VQQNMhEy69ZJbDMRz6VZQNgRJHG7NG3u+78P1qoLuSMncEEGtBa3Mo8PMjMrjhu1ALYe2a88XUGERU6iOQw352oPUMWfUen3CD3JlMUvzBOCD9D/AC8qsFkxOQw7Yz3FA6zGJrCLOzLcpv67H/OtQE9wULBJGRzurFaNNbq6lhtUK6XRcyMDy7H967+Lfwz5VCnZe9gLtKsmkZo4LY941GNyQfhrnmLDAGKIENuQ3Y5FRxqG2af4hY4rjvTJCWf/2Q==',
                            //                 //height:MediaQuery.of(context).size.height*0.08,
                            //                 height: 175,
                            //                 width: 350,
                            //                 fit: BoxFit.fill,
                            //                 filterQuality: FilterQuality.high,
                            //                 /* errorBuilder: (context, Object exception,stackTrace) {
                            //       return Text('Your error widget...');
                            //     }
                            //
                            //     */
                            //               ),
                            //
                            //               Column(
                            //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   SizedBox(height: 15),
                            //                   Text('Pakistan',
                            //                       style: TextStyle(
                            //                           fontWeight: FontWeight.bold,
                            //                           fontSize: 18,
                            //                           color: Color(0xFF800000))),
                            //                   Text('  Stock ID: ',
                            //                       style: TextStyle(
                            //                           fontWeight: FontWeight.bold,
                            //                           fontSize: 18,
                            //                           color: Color(0xFF800000))),
                            //
                            //                   // Text(list[i].image.toString()),
                            //                 ],
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                          });
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                }),
            FutureBuilder<List<PhotoModel>>(
                future: photoProvider.getPhotos(context),
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
                      return GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: width / (height / 2)),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [

                                  Image.network(
                                    snapshot.data![index].thumbnailUrl.toString(),
                                    fit: BoxFit.fill,
                                  ),
                                  Icon(Icons.play_arrow,size: 50,color: Colors.yellow,),
                                ],
                              ),
                            );
                            //     return Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: InkWell(
                            //         onTap: () {
                            //           /*Navigator.push(context, MaterialPageRoute(builder: (_){
                            //
                            // return Order(stock: list[i],);
                            // }));
                            //
                            //  */
                            //         },
                            //         child: Container(
                            //           height: 1000.0,
                            //           color: Colors.white,
                            //           child: Column(
                            //             mainAxisAlignment: MainAxisAlignment.start,
                            //             crossAxisAlignment: CrossAxisAlignment.start,
                            //             children: [
                            //               Row(
                            //                 mainAxisAlignment: MainAxisAlignment.end,
                            //                 children: [
                            //                   Icon(
                            //                     Icons.delete,
                            //                     color: Color(0xFF800000),
                            //                     size: 50.0,
                            //                   ),
                            //                 ],
                            //               ),
                            //               Padding(
                            //                 padding: const EdgeInsets.only(bottom: 8.0),
                            //                 child: Container(
                            //                   height: 30,
                            //                   width: MediaQuery.of(context).size.width,
                            //                   color: Color(0xFF800000),
                            //                   child: Center(
                            //                       child: Text(
                            //                     'A',
                            //                     style: TextStyle(
                            //                         color: Colors.white,
                            //                         fontWeight: FontWeight.bold),
                            //                   )),
                            //                 ),
                            //               ),
                            //               //  Image.network('http://192.168.43.95/Online_Qurbani_Project/images'+ list[i].image,width:MediaQuery.of(context).size.width*0.2,height:MediaQuery.of(context).size.height*0.05,),
                            //               Image.network('data:image/jpeg;base64,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',
                            //                 //height:MediaQuery.of(context).size.height*0.08,
                            //                 height: 175,
                            //                 width: 350,
                            //                 fit: BoxFit.fill,
                            //                 filterQuality: FilterQuality.high,
                            //                 /* errorBuilder: (context, Object exception,stackTrace) {
                            //       return Text('Your error widget...');
                            //     }
                            //
                            //     */
                            //               ),
                            //
                            //               Column(
                            //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   SizedBox(height: 15),
                            //                   Text('Pakistan',
                            //                       style: TextStyle(
                            //                           fontWeight: FontWeight.bold,
                            //                           fontSize: 18,
                            //                           color: Color(0xFF800000))),
                            //                   Text('  Stock ID: ',
                            //                       style: TextStyle(
                            //                           fontWeight: FontWeight.bold,
                            //                           fontSize: 18,
                            //                           color: Color(0xFF800000))),
                            //
                            //                   // Text(list[i].image.toString()),
                            //                 ],
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                          });
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                }),          ]),
        ),
      ],
    ),
  );
}
