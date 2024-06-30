import 'package:herdmannew/Model_local/Breeding_Abortion.dart';
import 'package:herdmannew/model/Animal_registration.dart';
import 'package:herdmannew/model/Vehicle_data.dart';
import 'package:herdmannew/model/Visit_Registration.dart';

import '../../Model_local/Bredding_Calving.dart';
import '../../Model_local/Breeding_Dry.dart';
import '../../Model_local/Breeding_PD.dart';
import '../../Model_local/Breeding_insemination.dart';
import '../../Model_local/Language_model.dart';
import '../../Model_local/Milk_PD.dart';
import '../../UiScreens/DrawerScreens/SyncReport/SyncReport.dart';
import '../../model/Animal_Details_id.dart';
import '../../model/Animal_Deworming.dart';
import '../../model/Animal_Disposal.dart';
import '../../model/Animal_Treatment.dart';
import '../../model/Animal_Treatment_details.dart';
import '../../model/Animal_Vaccination.dart';
import '../../model/Animal_timeline.dart';
import '../../model/Animal_weight_entry_model.dart';
import '../../model/Breeding_reproduction_id.dart';
import '../../model/Get_Master_Farmer.dart';
import '../../model/Master_Service.dart';
import '../../model/Master_UserHerds.dart';
import '../../model/Master_UserLots.dart';
import '../../model/Master_breed.dart';
import '../../model/Master_calvingType.dart';
import '../../model/Master_calvingTypeOption.dart';
import '../../model/Master_dewormingType.dart';
import '../../model/Master_diagnosis.dart';
import '../../model/Master_disposal.dart';
import '../../model/Master_disposalSubOptions.dart';
import '../../model/Master_dryOffReason.dart';
import '../../model/Master_feature.dart';
import '../../model/Master_inseminator.dart';
import '../../model/Master_medicineLedger.dart';
import '../../model/Master_medicineRoute.dart';
import '../../model/Master_medicineType.dart';
import '../../model/Master_paramter.dart';
import '../../model/Master_pd1.dart';
import '../../model/Master_pd2.dart';
import '../../model/Master_reproductveProblem.dart';
import '../../model/Master_sex.dart';
import '../../model/Master_sire.dart';
import '../../model/Master_smsSetting.dart';
import '../../model/Master_species.dart';
import '../../model/Master_status.dart';
import '../../model/Master_systemAffected.dart';
import '../../model/Master_treatmentComplaint.dart';
import '../../model/Master_userFeatureAccessDetail.dart';
import '../../model/Master_vaccinationType.dart';
import '../../model/Milk_production_id.dart';
import '../../model/Vehicle_purpose.dart';

class Con_List {
  static List<Master_breed> M_breed = [];
  static List<Master_service> M_Service = [];
  static List<Master_userFeatureAccessDetail> M_userFeatureAccessDetail = [];
  static List<Master_feature> M_feature = [];
  static List<Master_Userlots> M_Userlots = [];
  static List<Master_UserHerds> M_Userherds = [];
  static List<Master_calvingType> M_calvingType = [];
  static List<Master_calvingTypeOption> M_calvingTypeOption = [];
  static List<Master_dewormingType> M_dewormingType = [];
  static List<Master_diagnosis> M_diagnosis = [];
  static List<Master_disposal> M_disposal = [];
  static List<Master_disposalSubOptions> M_disposalSubOptions = [];
  static List<Master_dryOffReason> M_dryOffReason = [];
  static List<Master_inseminator> M_inseminator = [];
  static List<Master_medicineLedger> M_medicineLedger = [];
  static List<Master_medicineRoute> M_medicineRoute = [];
  static List<Get_Master_Farmer> M_Farmer = [];
  static List<Master_medicineType> M_medicineType = [];
  static List<Master_paramter> M_paramter = [];
  static List<Master_paramter> M_Milk_paramter = [];
  static List<Master_pd1> M_pd1 = [];
  static List<Master_pd2> M_pd2 = [];
  static List<Master_reproductveProblem> M_reproductveProblem = [];
  static List<Master_sex> M_sex = [];
  static List<Master_sire> M_sire = [];
  static List<Master_smsSetting> M_smsSetting = [];
  static List<Master_species> M_species = [];
  static List<Master_status> M_status = [];
  static List<Master_systemAffected> M_systemAffected = [];
  static List<Master_treatmentComplaint> M_treatmentComplaint = [];
  static List<Master_vaccinationType> M_vaccinationType = [];
  static List<Animal_Deworming> A_Deworming = [];
  static List<Animal_Disposal> A_Disposal = [];
  static List<Animal_Treatment> A_Treatment = [];
  static List<Animal_Treatment_details> A_Treatment_details = [];
  static List<Animal_Vaccination> A_Vaccination = [];
  static List<Milk_production_id> id_Milk_production = [];
  static List<Animal_Details_id> id_Animal_Details = [];
  static List<Animal_Details_id> Temp_Animal = [];
  static List<Breeding_reproduction_id> id_reproduction = [];
  static List<Animal_timeline> A_timeline = [];
  static List<Animal_weight_entry_model> A_weight_entry_model = [];
  static List<Visit_Registration> M_Visitragistration = [];

  static List<Vehicle_purpose> M_Vehicle_purpose = [];
  static List<Vehicle_data> M_Vehicle_data = [];
  static List<Breeding_insemination> Br_insemination = [];
  static List<Breeding_Dry> Dryofsave = [];
  static List<Breeding_Calving> Br_Calving = [];
  static List<Breeding_PD> Br_PD = [];
  static List<Breeding_Abortion> Br_Ab = [];
  static List<Animal_Treatment> treatment_save = [];
  static List<Animal_Deworming> deworming_save = [];
  static List<Animal_Vaccination> vaccination_save = [];
  static List<dynamic> AllActionList = [];
  static List<dynamic> CenterList = [];
  static List<dynamic> DcsList = [];
  static List<Sync_report> mListPanding = [];
  static List<Language_model> GlbLanguageData = [];
  static List<Milk_PDTest> Milk_PDtest = [];
  static List<Animal_Registration> Animal_regisrtration = [];
  static List Getalldata = [
    "Master_sire",
    "Master_staff",
    "Animal_Details_id",
    "Account_medicineLedger",
    "Breeding_pd",
    "Breeding_Abortion",
    "Breeding_insemination",
    "Dryoff_save",
    "Breeding_Calving",
    "Health_treatmentDetails",
    "Health_deworming",
    "Health_vaccination",
    "Account_medicineType",
    "Common_breed",
    "Common_calvingType",
    "language",
    "Common_calvingTypeOption",
    "Common_disposal",
    "Common_disposalSubOptions",
    "Common_dryOffReason",
    "Common_pd1",
    "Common_pd2",
    "Common_reproductiveProblem",
    "Common_service",
    "Common_sex",
    "Common_species",
    "Common_status",
    "Common_treatmentComplaint",
    "Common_vaccinationType",
    "Health_diagnosis",
    "Health_systemAffected",
    "Master_calfSchedule",
    "Master_dewormingType",
    "Master_farmer",
    "Master_herd",
    "Master_lot",
    "Master_medicineRoute",
    "Master_parameter",
    "Master_smsSetting",
    "Milk_parameter",
    "RoleAuthAndLogs_feature",
    "RoleAuthAndLogs_featureuseraccesstxn",
    "Timeline",
    "Health_weightGainDiet",
    "Health_vaccination",
    "Health_treatment",
    "Animal_diedDetails",
    "Milk_production_id",
    "Breeding_reproduction_id",
    "VISITREGISTRATION",
    "Vehicle_purpose",
    "Vehicle_data"
  ];
}
