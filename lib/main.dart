//todo                                                  /*  ॐ નમઃ શિવાય  */
// flutter build apk --release
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:herdmannew/UiScreens/Splesh/SplashScreen.dart';
import 'package:herdmannew/component/Gobal_Widgets/tost.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'Model_local/Bredding_Calving.dart';
import 'Model_local/Breeding_Abortion.dart';
import 'Model_local/Breeding_Dry.dart';
import 'Model_local/Breeding_PD.dart';
import 'Model_local/Breeding_insemination.dart';
import 'Model_local/Language_model.dart';
import 'Model_local/Milk_PD.dart';
import 'model/Animal_Details_id.dart';
import 'model/Animal_Deworming.dart';
import 'model/Animal_Disposal.dart';
import 'model/Animal_Production.dart';
import 'model/Animal_Treatment.dart';
import 'model/Animal_Treatment_details.dart';
import 'model/Animal_Vaccination.dart';
import 'model/Animal_details.dart';
import 'model/Animal_registration.dart';
import 'model/Animal_reproduction.dart';
import 'model/Animal_timeline.dart';
import 'model/Animal_weight_entry_model.dart';
import 'model/Breeding_reproduction_id.dart';
import 'model/Get_Master_Farmer.dart';
import 'model/Master_Farmer.dart';
import 'model/Master_Service.dart';
import 'model/Master_UserHerds.dart';
import 'model/Master_UserLots.dart';
import 'model/Master_breed.dart';
import 'model/Master_calvingType.dart';
import 'model/Master_calvingTypeOption.dart';
import 'model/Master_dewormingType.dart';
import 'model/Master_diagnosis.dart';
import 'model/Master_disposal.dart';
import 'model/Master_disposalSubOptions.dart';
import 'model/Master_dryOffReason.dart';
import 'model/Master_feature.dart';
import 'model/Master_inseminator.dart';
import 'model/Master_medicineLedger.dart';
import 'model/Master_medicineRoute.dart';
import 'model/Master_medicineType.dart';
import 'model/Master_paramter.dart';
import 'model/Master_pd1.dart';
import 'model/Master_pd2.dart';
import 'model/Master_reproductveProblem.dart';
import 'model/Master_sex.dart';
import 'model/Master_sire.dart';
import 'model/Master_sireStock.dart';
import 'model/Master_smsSetting.dart';
import 'model/Master_species.dart';
import 'model/Master_status.dart';
import 'model/Master_systemAffected.dart';
import 'model/Master_treatmentComplaint.dart';
import 'model/Master_userFeatureAccessDetail.dart';
import 'model/Master_vaccinationType.dart';
import 'model/Milk_production_id.dart';
import 'model/Notification_Gloable.dart';
import 'model/Vehicle_data.dart';
import 'model/Vehicle_purpose.dart';
import 'model/Visit_Registration.dart';

Future<void> main() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(

      );
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );
  var dir = await getApplicationDocumentsDirectory();
  var path = "${dir.path}/databases";
  Hive
    ..init(path)
    ..registerAdapter(MasterbreedAdapter());
  Hive
    ..init(path)
    ..registerAdapter(BreedinginseminationAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastercalvingTypeAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastercalvingTypeOptionAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterdewormingTypeAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterdiagnosisAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterdisposalAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterdisposalSubOptionsAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterdryOffReasonAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterfeatureAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterinseminatorAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastermedicineLedgerAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastermedicineRouteAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterparamterAdapter());
  Hive
    ..init(path)
    ..registerAdapter(Masterpd1Adapter());
  Hive
    ..init(path)
    ..registerAdapter(Masterpd2Adapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterreproductveProblemAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterserviceAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastersexAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastersireAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastersireStockAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastermedicineTypeAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterspeciesAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastersmsSettingAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterstatusAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastersystemAffectedAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastertreatmentComplaintAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasteruserFeatureAccessDetailAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterUserHerdsAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterUserlotsAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MastervaccinationTypeAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimaldetailsAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalDewormingAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalDisposalAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalProductionAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalreproductionAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimaltimelineAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalTreatmentAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalTreatmentdetailsAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalVaccinationAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalweightentrymodelAdapter());
  Hive
    ..init(path)
    ..registerAdapter(BreedingreproductionidAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalDetailsidAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MilkproductionidAdapter());
  Hive
    ..init(path)
    ..registerAdapter(VisitRegistrationAdapter());
  Hive
    ..init(path)
    ..registerAdapter(VehiclepurposeAdapter());
  Hive
    ..init(path)
    ..registerAdapter(VehicledataAdapter());
  Hive
    ..init(path)
    ..registerAdapter(BreedingAbortionAdapter());
  Hive
    ..init(path)
    ..registerAdapter(BreedingDryAdapter());
  Hive
    ..init(path)
    ..registerAdapter(BreedingPDAdapter());
  Hive
    ..init(path)
    ..registerAdapter(BreedingCalvingAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MasterFarmerAdapter());
  Hive
    ..init(path)
    ..registerAdapter(GetMasterFarmerAdapter());
  Hive
    ..init(path)
    ..registerAdapter(LanguagemodelAdapter());
  Hive
    ..init(path)
    ..registerAdapter(MilkPDTestAdapter());
  Hive
    ..init(path)
    ..registerAdapter(AnimalRegistrationAdapter());
  Hive
    ..init(path)
    ..registerAdapter(NotificationGloableAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(navigatorKey: navigatorKey,
      title: 'Herdman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.blue),iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.white))),floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blue),primarySwatch: Colors.blue, fontFamily: "Poppins"),
      home:  SpleshScreen(),
    );
  }
}


