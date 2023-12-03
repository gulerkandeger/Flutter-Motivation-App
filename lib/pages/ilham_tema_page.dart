import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivasyon_page/entity/my_colors.dart';
import 'package:motivasyon_page/pages/ilham_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IlhamTema extends StatefulWidget {

  @override
  State<IlhamTema> createState() => _IlhamTemaState();
}

class _IlhamTemaState extends State<IlhamTema> {

  List<String> temalar = ['ilham1.png','ilham2.png','ilham3.png','ilham4.png',
    'ilham5.png','ilham6.png','ilham7.png','ilham8.png',
    'ilham9.png','ilham10.png','ilham11.png','ilham12.png',
    'ilham13.png',];

  List<String> fontlar = ['font1','font2','font3', 'font4','font5','font6', 'font7',];

  int selectedFontIndex = -1;
  int selectedGorselIndex = -1;

  String? selectedGorsel;
  String? selectedFont;

  Future<void> gorselKayit() async{
    var sp = await SharedPreferences.getInstance();
    sp.setString("gorsel",selectedGorsel!);
  }

  Future<void> fontKayit() async{
    var sp = await SharedPreferences.getInstance();
    sp.setString("font", selectedFont!);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mc_azure2,
      appBar: AppBar(
        backgroundColor: MyColors.mc_azure2,
        title: Text("Temayı Değiştir"),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,top: 50),
              child: Text("Görseller :",style: TextStyle(color: Colors.black26,fontSize: 18),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: temalar.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Stack(
                          children:[
                            SizedBox(
                              child: Card(
                                child: Row(
                                  children: [
                                    Image.asset("images/${temalar[index]}",fit: BoxFit.cover, ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: Visibility(
                                  visible: selectedGorselIndex == index,
                                  child: Icon(Icons.check, color: Colors.black54,size: 40,),
                                ),
                              ),
                            ),
                          ]
                      ),
                      onTap: (){
                        if (selectedGorselIndex == index) {
                          setState(() {
                            selectedGorselIndex = -1;
                          });
                        } else {
                          setState(() {
                            selectedGorselIndex = index;
                          });
                        }
                        setState(() {
                          selectedGorsel = temalar[index];
                          gorselKayit();
                        });
                      },
                    );
                  }
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,top: 50),
              child: Text("Yazı Tipleri :",style: TextStyle(color: Colors.black26,fontSize: 18),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fontlar.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        child: Center(
                          child: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Center(
                                        child: Text("Aa",style: TextStyle(fontFamily:"${fontlar[index]}",fontSize: 20))
                                    )
                                ),
                                Visibility(
                                  visible: selectedFontIndex == index,
                                  child: Icon(Icons.check, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        if (selectedFontIndex == index) {
                          setState(() {
                            selectedFontIndex = -1;
                          });
                        } else {
                          setState(() {
                            selectedFontIndex = index;
                          });
                        }
                        setState(() {
                          selectedFont = fontlar[index];
                          fontKayit();
                        });
                      },
                    );
                  }
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: ElevatedButton(
              child: Text("Uygula"),
              style: ElevatedButton.styleFrom(
                backgroundColor:MyColors.mc_silverChalice,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4.0,
              ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IlhamNoktasi()));
                gorselKayit();
                fontKayit();
              },
            ),
          ),
        ],
      ),
    );
  }
}
