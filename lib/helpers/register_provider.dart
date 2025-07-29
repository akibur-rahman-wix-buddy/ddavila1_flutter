import 'package:provider/provider.dart';
import '../provider/generic_provider.dart';

var providers = [
  ChangeNotifierProvider<GenericDi>(create: ((context) => GenericDi())),
  // ChangeNotifierProvider<SelectedPetProvider>(
  //     create: ((context) => SelectedPetProvider())),
  // ChangeNotifierProvider<WeightGoalProvider>(
  //     create: ((context) => WeightGoalProvider())),

  // ChangeNotifierProvider<PurchaseProvider>(
  //   create: ((context) => PurchaseProvider()),
  // ),

];
