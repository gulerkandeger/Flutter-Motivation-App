import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motivasyon_page/cubit/ilham_cubit.dart';
import 'package:motivasyon_page/entity/my_colors.dart';
import 'package:motivasyon_page/pages/ilham_tema_page.dart';
import 'package:motivasyon_page/service/ilham_service.dart';
import 'package:motivasyon_page/state/ilham_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IlhamNoktasi extends StatefulWidget {

  @override
  State<IlhamNoktasi> createState() => _IlhamNoktasiState();
}

class _IlhamNoktasiState extends State<IlhamNoktasi> {

  bool favori = false;
  PageController _controller = PageController();
  var _firestore = IlhamNoktasiService();

  String selectedGorsel = 'ilham2.png';
  String selectedFont = 'font1';

  Future<void> gorselGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      selectedGorsel = sp.getString("gorsel")!;
    });
  }

  Future<void> fontGoster() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      selectedFont = sp.getString("font")!;
    });
  }


  @override
  void initState() {
    super.initState();
    context.read<IlhamNoktasiCubit>().getIlhamlar();
    setState(() {
      gorselGoster();
      fontGoster();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.mc_pureWhite,
      body: BlocBuilder<IlhamNoktasiCubit, IlhamState>(
        builder: (context, state){
          if (state is IlhamLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is IlhamErrorState) {
            return Text('${state.error}');
          }
          else if (state is IlhamSuccessState) {
            return Container();
          }
          else if (state is IlhamLoadedState && state.ilhamList.isNotEmpty){
            return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "images/$selectedGorsel", fit: BoxFit.cover,),
                  ),
                  PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.ilhamList.length,
                    itemBuilder: (context, index) {
                      final yourData = state.ilhamList[index];
                      favori = yourData['favori'];
                      return Container(
                        padding: EdgeInsets.only(
                            right: 20, left: 20, top: 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text("${yourData['ilham']}", textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black,fontFamily: '$selectedFont'),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: favori
                                    ? IconButton(
                                  iconSize: 40,
                                  icon: Icon(Icons.favorite,
                                    color: Colors.red,),
                                  onPressed: () {
                                    setState(() {
                                      favori = !favori;
                                      yourData['favori'] = favori;
                                      _firestore.ilhamFavGuncelleme(yourData['id'],favori);
                                    });
                                  },
                                ):
                                IconButton(
                                  iconSize: 40,
                                  icon: Icon(Icons.favorite_border,
                                    color: Colors.black54,),
                                  onPressed: () {
                                    setState(() {
                                      favori = !favori;
                                      yourData['favori'] = favori;
                                      _firestore.ilhamFavGuncelleme(yourData['id'],favori);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, right: 5),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        iconSize: 35,
                        icon: Icon(Icons.palette_outlined,color: Colors.black54,),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>IlhamTema()));
                        },
                      ),
                    ),
                  ),
                ]
            );
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
