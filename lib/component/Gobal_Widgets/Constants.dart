import 'package:flutter/material.dart';
import 'package:herdmannew/appVersion.dart';
import 'package:herdmannew/component/A_SQL_Trigger/page_permission.dart';

class Constants {
  static ValueNotifier<bool> insemination_res =ValueNotifier(false);
  static String qrid = "";
  static int Last_id_AI = 0;
  static int Last_id_abor = 0;
  static int Last_id_rep = 0;
  static int Last_id_Br_reprod = 0;
  static int Last_id_dryoff = 0;
  static int Last_id_Treatment = 0;
  static int Last_id_Treatment_detail = 0;
  static int Last_id_Deworming = 0;
  static int Last_id_Vaccnation = 0;
  static int Last_id_Calving = 0;
  static int Last_id_Breed_PD = 0;
  static int Last_id_milk = 0;
  static int Last_milk_PD = 0;
  static int Last_id_Animal_diedDetails = 0;
  static const String AppName = 'Herdman New App';
  static const String Tbl_Page_Permission = 'page_permission';
  static List<api_page_permission> Page_PermissionList = [];
  static String Tbl_Account_medicineLedger = "Account_medicineLedger";
  static String Tbl_Account_medicineRate = "Account_medicineRate";
  static String Tbl_Account_medicineType = "Account_medicineType";
  static String Tbl_Animal_TraitType = "Animal_TraitType";
  static String Tbl_Animal_animalrename = "Animal_animalrename";
  static String Tbl_Animal_calftask = "Animal_calftask";
  static String Tbl_Animal_details = "Animal_details";
  static String Tbl_Animal_diedDetails = "Animal_diedDetails";
  static String Tbl_Animal_healthexamination = "Animal_healthexamination";
  static String Tbl_Animal_insurance = "Animal_insurance";
  static String Tbl_Animal_purchasedetails = "Animal_purchasedetails";
  static String Tbl_Application_RouteVOAllocation =
      "Application_RouteVOAllocation";
  static String Tbl_Application_company = "Application_company";
  static String Tbl_Application_company_modules__module_companies =
      "Application_company_modules__module_companies";
  static String Tbl_Application_farmer_users__user_farmers =
      "Application_farmer_users__user_farmers";
  static String Tbl_Application_herd_users__user_herds =
      "Application_herd_users__user_herds";
  static String Tbl_Application_lot_users__user_lots =
      "Application_lot_users__user_lots";
  static String Tbl_Application_user = "Application_user";
  static String Tbl_Application_usergroup = "Application_usergroup";
  static String Tbl_Breeding_reproduction = "Breeding_reproduction";
  static String Tbl_Breeding_reproductiveProblemHistory =
      "Breeding_reproductiveProblemHistory";
  static String Tbl_Common_VisitType = "Common_VisitType";
  static String Tbl_Common_breed = "Common_breed";
  static String Tbl_Common_calvingType = "Common_calvingType";
  static String Tbl_Common_calvingTypeOption = "Common_calvingTypeOption";
  static String Tbl_Common_disposal = "Common_disposal";
  static String Tbl_Common_disposalSubOptions = "Common_disposalSubOptions";
  static String Tbl_Common_dryOffReason = "Common_dryOffReason";
  static String Tbl_Common_pd1 = "Common_pd1";
  static String Tbl_Common_pd2 = "Common_pd2";
  static String Tbl_Common_reproductiveProblem = "Common_reproductiveProblem";
  static String Tbl_Common_service = "Common_service";
  static String Tbl_Common_sex = "Common_sex";
  static String Tbl_Common_smslanguage = "Common_smslanguage";
  static String Tbl_Common_species = "Common_species";
  static String Tbl_Common_status = "Common_status";
  static String Tbl_Common_treatmentComplaint = "Common_treatmentComplaint";
  static String Tbl_Common_vaccinationType = "Common_vaccinationType";
  static String Tbl_Health_CallCenterService = "Health_CallCenterService";
  static String Tbl_Health_FarmerComplaint = "Health_FarmerComplaint";
  static String Tbl_Health_deworming = "Health_deworming";
  static String Tbl_Health_diagnosis = "Health_diagnosis";
  static String Tbl_Health_systemAffected = "Health_systemAffected";
  static String Tbl_Health_treatment = "Health_treatment";
  static String Tbl_Health_treatmentDetails = "Health_treatmentDetails";
  static String Tbl_Health_vaccination = "Health_vaccination";
  static String Tbl_Health_weightGainDiet = "Health_weightGainDiet";
  static String Tbl_Master_calfSchedule = "Master_calfSchedule";
  static String Tbl_Master_cc = "Master_cc";
  static String Tbl_Master_dewormingType = "Master_dewormingType";
  static String Tbl_Master_farmer = "Master_farmer";
  static String Tbl_Master_herd = "Master_herd";
  static String Tbl_Master_lot = "Master_lot";
  static String Tbl_Master_lotlatlong = "Master_lotlatlong";
  static String Tbl_Master_medicineRoute = "Master_medicineRoute";
  static String Tbl_Master_parameter = "Master_parameter";
  static String Tbl_Master_shift = "Master_shift";
  static String Tbl_Master_shiftAllocation = "Master_shiftAllocation";
  static String Tbl_Master_sire = "Master_sire";
  static String Tbl_Master_smsSetting = "Master_smsSetting";
  static String Tbl_Master_source = "Master_source";
  static String Tbl_Master_staff = "Master_staff";
  static String Tbl_Master_voPost = "Master_voPost";
  static String Tbl_Master_zone = "Master_zone";
  static String Tbl_Milk_oldDetails = "Milk_oldDetails";
  static String Tbl_Milk_parameter = "Milk_parameter";
  static String Tbl_Milk_production = "Milk_production";
  static String Tbl_Notification = "Notification";
  static String Tbl_Option = "Option";
  static String Tbl_RoleAuthAndLogs_auth = "RoleAuthAndLogs_auth";
  static String Tbl_RoleAuthAndLogs_feature = "RoleAuthAndLogs_feature";
  static String Tbl_RoleAuthAndLogs_featureroleaccesscontrol =
      "RoleAuthAndLogs_featureroleaccesscontrol";
  static String Tbl_RoleAuthAndLogs_featureuseraccesscontrol =
      "RoleAuthAndLogs_featureuseraccesscontrol";
  static String Tbl_RoleAuthAndLogs_featureuseraccesstxn =
      "RoleAuthAndLogs_featureuseraccesstxn";
  static String Tbl_RoleAuthAndLogs_module = "RoleAuthAndLogs_module";
  static String Tbl_RoleAuthAndLogs_role = "RoleAuthAndLogs_role";
  static String Tbl_Timeline = "Timeline";
  static String Tbl_VISITREGISTRATION = "VISITREGISTRATION";
  static String Tbl_Animal_reproduction = "Breeding_reproduction";
  static String Tbl_Animal_production = "Milk_production";
  static String Tbl_dbo_dashboard = "dbo_dashboard";
  static String Tbl_dbo_language = "dbo_language";
  static String Tbl_dbo_rawquery = "dbo_rawquery";
  static String Tbl_log = "log";
  static String Tbl_settings = "settings";
  static String Tbl_simple_form = "simple_form";
  static String API_MASTER_DATA = "MASTER_DATA";
  static String ONE_TIME_DATA = "OneTimeData";
  static String API_ANIMAL_DATA = "All_Animal_Download";
  static String Breeding_reproduction_id = "Breeding_reproduction_id";
  static String Animal_Details_id = "Animal_Details_id";
  static String Milk_production_id = "Milk_production_id";
  static String Tbl_vehicle_purpose = "Vehicle_purpose";
  static String Tbl_vehicle_data = "Vehicle_data";
  static String Tbl_Alarm_data = "Vehicle_data";
  static String Tbl_Daily_Actoin = "Daily_Action";
  static String Language = "English";
  static String Tbl_Br_insemination = "Breeding_insemination";
  static String Tbl_Dry_off_save = "Dryoff_save";
  static String Tbl_Breeding_Calving = "Breeding_Calving";
  static String Tbl_Br_Pd = "Breeding_pd";
  static String Tbl_Br_Ab = "Breeding_Abortion";
  static String Tbl_Milk_Pd = "Milk_Pd_Test";
  static String Tbl_Animal_Registration ="Animal_Registration";
}

class Draweritem {
  static Color DrawerIconColor = Colors.white;
  static int pIntLanguage = 9;
  static int pIntGroupId = 9;
  static List<Map> FinalDraweritem = [];
  static Map mDrwAddUpdateCattle = {
    "name": "Add/Update Cattle Data",
    "image": "icons8-add-properties-24.png"
  };
  // static Map mDrwDownloadData = {
  //   "name": "Download Data",
  //   "image": "download.png"
  // };
  static Map mDrwEvmMedicine={
    "name": "EVM Medicine",
    "image": "medicine.png"
  };
  static Map mDrwFarmerRegis={
    "name": "Farmer Registration",
    "image": "Framer_Regi.png"
  };
  static Map mDrwUpdateFarmer = {
    "name": "Update Farmer",
    "image": "icons8-upgrade-24.png"
  };
  static Map mDrwAllCattleList = {
    "name": "All Cattle List",
    "image": "cattlaList.png"
  };
  static Map mDrwSirestocks = {"name": "Sire Stocks", "image": "stocks.png"};

  static Map mDrwMPPtest = {
    "name": "MPP Test",
    "image": "icons8-medical-test-24.png"
  };
  static Map mDrwBulkEntry = {"name": "Bulk Entry", "image": "bulEntry.png"};

  static Map mDrwAction = {"name": "Action", "image": "action.png"};

  static Map mDrwAlarm = {"name": "Alarm", "image": "alarm.png"};

  static Map mDrwCustomReport = {
    "name": "Custom Report",
    "image": "customReport.png"
  };
  static Map mDrwReport = {"name": "Report", "image": "report.png"};

  static Map mDrwDisposalEntry = {
    "name": "Disposal Entry",
    "image": "disposlEntry.png"
  };
  static Map mDrwSyncReport = {
    "name": "Sync Report",
    "image": "syncReport.png"
  };
  static Map mDrwVisitRegistration = {
    "name": "Visit Registration",
    "image": "visitRegi.png"
  };
  static Map mDrwProjectCamp = {
    "name": "Project Camp",
    "image": "projctCamp.png"
  };
  static Map mDrwUnitDetails = {
    "name": "Unit Details",
    "image": "unitDetail.png"
  };
  static Map mDrwRequest = {"name": "Request", "image": "request.png"};
  static Map mDrwUnitEntryReport = {"name": "Unit Entry Report", "image": "medical.webp"};
  static Map mDrwNotification = {
    "name": "Notification",
    "image": "icons8-notification-24.png"
  };
  static Map mDrwSetting = {
    "name": "Setting",
    "image": "icons8-setting-24.png"
  };
  static Map mDrwLanguage = {"name": "Language", "image": "language.png"};

  static Map mDrwChengpassword = {
    "name": "Change Password",
    "image": "lock.webp"
  };
  static Map mDrwLogout = {"name": "Logout ", "image": "logOut.png"};
  static Map mDrwVersion = {
    "name": "Version : ${appversion.version}",
    "image": "version.png"
  };

  static List<Map> first = [
    mDrwAddUpdateCattle,
    // mDrwDownloadData,
    mDrwUpdateFarmer,
    mDrwAllCattleList,
    mDrwSirestocks,
    mDrwMPPtest,
    mDrwBulkEntry,
    mDrwAction,
    mDrwAlarm,
    mDrwCustomReport,
    mDrwReport,
    mDrwDisposalEntry,
    mDrwSyncReport,
    mDrwVisitRegistration,
    mDrwProjectCamp,
    mDrwUnitDetails,
    mDrwUnitEntryReport,
    mDrwEvmMedicine,
    mDrwRequest,
    mDrwFarmerRegis,
    mDrwNotification,
    mDrwSetting,
    mDrwLanguage,
    mDrwChengpassword,
    mDrwLogout,
    mDrwVersion
  ];
  static List<Map> second = [
    mDrwAddUpdateCattle,
    //mDrwDownloadData,
    mDrwUpdateFarmer,
    mDrwAllCattleList,
    mDrwSirestocks,
    mDrwMPPtest,
    mDrwBulkEntry,
    mDrwAction,
    mDrwAlarm,
    mDrwCustomReport,
    mDrwReport,
    mDrwDisposalEntry,
    mDrwSyncReport,
    mDrwVisitRegistration,
    mDrwUnitDetails,
    mDrwUnitEntryReport,
    mDrwEvmMedicine,
    mDrwRequest,
    mDrwFarmerRegis,
    mDrwNotification,
    mDrwSetting,
    mDrwLanguage,
    mDrwChengpassword,
    mDrwLogout,
    mDrwVersion
  ];

  static List<Map> third = [
    // mDrwDownloadData,
    mDrwUpdateFarmer,
    mDrwSyncReport,
    mDrwVisitRegistration,
    mDrwEvmMedicine,
    mDrwRequest,
    mDrwFarmerRegis,
    mDrwNotification,
    mDrwSetting,
    mDrwLanguage,
    mDrwChengpassword,
    mDrwLogout,
    mDrwVersion
  ];

  static List<Map> fourth = [
    //mDrwDownloadData,
    mDrwUpdateFarmer,
    mDrwAllCattleList,
    mDrwBulkEntry,
    mDrwAction,
    mDrwAlarm,
    mDrwCustomReport,
    mDrwReport,
    mDrwDisposalEntry,
    mDrwSyncReport,
    mDrwVisitRegistration,
    mDrwEvmMedicine,
    mDrwRequest,
    mDrwFarmerRegis,
    mDrwNotification,
    mDrwSetting,
    mDrwLanguage,
    mDrwChengpassword,
    mDrwLogout,
    mDrwVersion
  ];

  static List<Map> fifth32 = [
    //mDrwRequest,
    mDrwUnitDetails,
    mDrwUnitEntryReport,
    mDrwLanguage,
    mDrwChengpassword,
    mDrwEvmMedicine,
    mDrwFarmerRegis,
    mDrwSetting,
    mDrwLogout,
    mDrwVersion
  ];

  static List<Map> six = [
    mDrwUnitDetails,
    mDrwUnitEntryReport,
    mDrwRequest,
    mDrwSetting,
    mDrwLanguage,
    mDrwEvmMedicine,
    mDrwFarmerRegis,
    mDrwChengpassword,
    mDrwLogout,
    mDrwVersion
  ];
  static List<Map> seven = [
    mDrwAllCattleList,
    mDrwAction,
    mDrwAlarm,
    mDrwCustomReport,
    mDrwReport,
    mDrwEvmMedicine,
    mDrwLogout,
    mDrwVersion
  ];
}
