import 'package:get/get.dart';

class QuestionController extends GetxController {
  RxInt mark = 0.obs;
  RxBool isTrue =false.obs;
  RxBool isFalse =false.obs;
  RxBool isSendingCertificate =false.obs;

  void changeMark(bool answer, bool correctAnswer) {

    if(answer){
     correctAnswer ? mark.value = 1 : mark.value = 0;
     isTrue.value =true;
     isFalse.value = false;
     update();
    }else {
      correctAnswer ? mark.value = 0 : mark.value = 1;
      isTrue.value = false;
      isFalse.value = true;
      update();
    }

  }
}
