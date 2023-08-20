import 'package:get/get.dart';
class NavigationController extends GetxController {
  RxInt? selectedIndex=0.obs;
  navigate(int value) {
    selectedIndex!.value=value;
  }
}