import 'package:flutter/material.dart';
import 'package:moshaf/asset.dart';
import 'package:moshaf/modules/quran_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Asset asset = Asset();
  int pageNumber = 0;
  List<List<QuranModel>> pages = [];
  double scale = 1;
  String basmala = "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏";

  void getData() async {
    pages = await asset.fetchData(pageNumber);
    print(pages.length);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Padding(
          padding: const EdgeInsets.only(right: 65.0),
          child: Text('القرآن الكريم',style: TextStyle(
              fontSize: 28,
            color: Colors.black,
          ),),
        ),
        actions: const [
          Icon(
            Icons.search,
            size: 35,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: Drawer(
        child:ListView.builder(itemBuilder: (context, index)=> ListTile(
          
        ))
      ),
      body: pages == null ?
      Center(child: CircularProgressIndicator()) :
      PageView.builder(
        itemCount: 604,
        itemBuilder: (context, index) {

          List<InlineSpan> listTextSpan = [];

          bool isBasmala = false;

          Set<String?> surah={};

          Set<int? > jozzo = {};

          for (QuranModel quranmodel in pages[index]) {
            surah.add(quranmodel.suraNameAr);
            jozzo.add(quranmodel.jozz);

            if(quranmodel.ayaNo==1){
              listTextSpan.add(
               WidgetSpan(
                   child: Padding(
                     padding: const EdgeInsets.only(bottom: 8.0),
                     child: Container(
                       alignment: Alignment.center,
                       width: double.infinity,
                       height: 70,
                       decoration: BoxDecoration(
                         image: DecorationImage(
                           fit: BoxFit.cover,
                             image:AssetImage('assets/images/head.png') )
                       ),
                       child: Text('${surah.first}',style: TextStyle(
                         fontSize: 25
                       ),),
                     ),
                   ))
              );
            }
            if(quranmodel.suraNameAr != "الفَاتِحة"&& quranmodel.suraNameAr !="التوبَة"&& quranmodel.ayaNo == 1){
              listTextSpan.add(
                  WidgetSpan(
                      child: Center(
                        child: Text('${basmala}\n',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HafsSmart'
                        ),),
                      )
                  )
              );
            }
          listTextSpan.add(TextSpan(
              text: '${quranmodel.ayaText}',
              style: TextStyle(
                fontSize: 25,
              )
          ));
          }

          return Row(
            textDirection: (index+1)%2 ==0? TextDirection.rtl:TextDirection.ltr,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text.rich(
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'HafsSmart',
                          ),
                          TextSpan(
                              children: listTextSpan)),
                    ),
                    Spacer(),
                    Text((index + 1).toString(), style: TextStyle(
                      fontSize: 18,
                    ),)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
// WidgetSpan(
// //   child: Container(
// //     margin: const EdgeInsets.symmetric(horizontal: 1),
// //     width: 38,
// //     height: 38,
// //     decoration: const BoxDecoration(
// //         image: DecorationImage(
// //             image:
// //                 AssetImage('assets/images/Ayahpng.png'))),
// //     child: Center(
// //       child: Text(
// //         '${ayahs[i]['aya_no']}',
// //         style: const TextStyle(
// //           fontSize: 15,
// //         ),
// //       ),
// //     ),
// //   ),
// // )

