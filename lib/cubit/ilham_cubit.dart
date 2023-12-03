import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motivasyon_page/entity/ilham_model.dart';
import 'package:motivasyon_page/service/ilham_service.dart';
import 'package:motivasyon_page/state/ilham_state.dart';

class IlhamNoktasiCubit extends Cubit<IlhamState>{
  IlhamNoktasiCubit(): super(IlhamInitialState());

  final IlhamNoktasiService ilhamService = IlhamNoktasiService();

  void getIlhamlar() async {
    emit(IlhamLoadingState());
    try {
      List<IlhamNoktasiModel> ilhamList = await ilhamService.ilhamVeriAlma();
      // emit(IlhamLoadedState(ilhamList));
      emit(IlhamLoadedState(ilhamList.map((ilham) => ilham.toMap()).toList()));
    } catch (e) {
      emit(IlhamErrorState('Veri alınamadı.'));
    }
  }

  void updateIlham(String docId, bool favori) async {
    try {
      await ilhamService.ilhamFavGuncelleme(docId, favori);
      emit(IlhamSuccessState());
    } catch (e) {
      emit(IlhamErrorState('Ilham güncellenirken bir hata oluştu.'));
    }
  }
}
