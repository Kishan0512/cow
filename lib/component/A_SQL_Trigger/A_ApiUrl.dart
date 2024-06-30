import 'package:flutter/cupertino.dart';

import '../Gobal_Widgets/Con_Usermast.dart';

class AppUrl {
  static ValueNotifier<bool> CheckNewUrl = ValueNotifier(false);
  static ValueNotifier<bool> issuspend  = ValueNotifier(false);
  static String BASE_URL = "";

  AppUrl() {
    BASE_URL = AppUrl.CheckNewUrl.value
        ? "https://hais.hap.in"
        : "https://dudhsagar.herdman.in";
    LOGIN_URL = BASE_URL + "/api/auth/login";
    LOGIN_URL_CHECK = BASE_URL + "/v1/api/web/application/check-user";
    REG_CHECK_FARMER = BASE_URL + "/v1/api/web/application/check-farmer";
    MASTER_DATA = BASE_URL + "/api/v4/user/mobile_init?id=";
    ONETIMEDATA = BASE_URL + "/api/sp/Application/GetOnetimedata";
    farmerData = BASE_URL + "/api/v3/master/farmer?lot=";
    animalData = BASE_URL + "/api/v1/animals?farmer=";
    animalviseData = BASE_URL + "/api/v1/animalswise?farmer=";
    animalDataDcsVise = BASE_URL + "/api/v1/lot/";
    animalDataDcsViseNew = BASE_URL + "/api/v1/cattle/lot/details";
    Get_sirestock = BASE_URL + "/api/sire-stock";
    Animal_Save = BASE_URL + "/v1/api/web/animal/save-animal";
    savelanguage = BASE_URL + "/v1/api/web/common/save-mobilelanguage";
    getlanguage = BASE_URL + "/v1/api/web/common/get-mobilelanguage";
    GetAnimalbyuserid = BASE_URL + "/api/sp/getDownloadData";
    //105299031781
//  //   getlanguage = BASE_URL + "/v1/api/web/common/get-mobilelanguage";
    saveSireStock = BASE_URL + "/v1/api/mobile-app/account/adjustsirestock";
//  //   CATTLE_REGISTER_BREEDING_SELECTION =
    SAMPLE_FORM = BASE_URL + "/poc";
    SCAN_CODE = BASE_URL + "/api/cattle-detail/getbyscan?scan_code=";
    GET_ALL_HERD = BASE_URL + "/api/herd/getall?user_id=";
    GET_ALL_LOTS = BASE_URL + "/api/lot/getall?user_id=";
    GET_ALL_FARMERS = BASE_URL + "/api/farmer/getall?user_id=";
    GET_ALL_PERMISSION = BASE_URL + "/api/features/get_by_user?user_id=";
    MilkPDTest = BASE_URL + "/api/sp/Breeding/PDTestSave";
//  //  CATTLE_REGISTER_INSERT_URL = BASE_URL + "/api/cattle-detail/add";
    CATTLE_REGISTER_INSERT_URL = BASE_URL + "/api/cattle/details-add";
//  //  CATTLE_STATUS_TIMELINE_URL = BASE_URL + "/api/cattle_timeline";
    CATTLE_STATUS_TIMELINE_URL =
        BASE_URL + "/api/v1/cattle/reproduction-add-Update";
    CATTLE_MILKING_ENTRY_URL = BASE_URL + "/api/v1/cattle/production-add";
//  //   CATTLE_MILKING_ENTRY_URL = BASE_URL + "/api/milking_entry";
    CATTLE_WEIGHT_ENTRY_URL = BASE_URL + "/api/weight_entry";
    CATTLE_VACCINATION_ENTRY_URL = BASE_URL + "/api/vaccination_entry";
    CATTLE_DEWORMING_ENTRY_URL = BASE_URL + "/api/deworming_entry";
    CATTLE_SYNC_BACK_URL = BASE_URL + "/api/cattle/getbytagidarray";
    CATTLE_ACTIVITY_TIMELINE_URL =
        BASE_URL + "/api/cattle/add-mobile-timeline-table";
    CATTLE_herd_lot_farmer_feature_sync =
        BASE_URL + "/api/user/herd-lot-farmer-feature-sync";
    CATTLE_all_master_data_sync = BASE_URL + "/api/master/sync?item=";
    CATTLE_cattle_get_unsync_data = BASE_URL + "/api/cattle/get-unsync-data";
    CATTLE_DISPOSAL = BASE_URL + "/api/cattle/died_entry";
    CATTLE_TREATMENT_ENTRY = BASE_URL + "/api/treatment-entry";
    CATTLE_TREATMENT_OTHER_ENTRY = BASE_URL + "/api/treatment-detail-entry";
    APP_SETTINGS = BASE_URL + "/api/settings-detail-entry";
    getVisitRegistration =
        BASE_URL + "/api/health/visit/vo?offset=0&limit=10000";
    getNonSyncedVisits = BASE_URL + "/api/v3/health/visit/vo";
    vehicleLastKM= BASE_URL + "/api/vehicle/LastKm?vehiclenumber=";
    updateDeliveryTime = BASE_URL + "/api/health/visit/delivery";
    upDateVisitRegistration = BASE_URL + "/api/health/visit/status";
    upDateVisitRegistrationCost =
        BASE_URL + "/health-visit/updateVisitUpdateCost";
    upDateVisitRegistrationCostUpdate =
        BASE_URL + "/health-visit/updateVisitUpdate";
    getSires = BASE_URL + "/api/sire-stock";
    checkCattleAvailable = BASE_URL + "/animal/check-id-no/";
    vehicleData = BASE_URL + "/api/vehicle/vehicleno";
    vehicleDriversData = BASE_URL + "/api/vehicle/drivers";
    vehiclePurposes = BASE_URL + "/api/vehicle/purposes";
    vehicleUnitDetails = BASE_URL + "/api/vehicle/unit-details";
    AnimalRefresh = BASE_URL + "/api/sp/Application/GetAnimalJson";
    Save_reproduction = BASE_URL + "/api/sp/Breeding/SaveReproduction";
    RegisterFarmer = BASE_URL + "/farmer/saveFarmerData";
    vehicleUnitDetailsUpdate = BASE_URL + "/api/vehicle/unit-details-update";
    vehicleUnitDetailsDelete = BASE_URL + "/api/vehicle/unit-details-delete";
    visitCase = BASE_URL + "/api/visit/";
    requestItems = BASE_URL + "/api/request-items/getall";
    requestItemsRequest = BASE_URL + "/v1/api/mobile-app/account/item-request";
    medicineLedger = BASE_URL + "/api/medicine-ledger/getall";
    registration = BASE_URL + "/farmer/saveFarmerData";
    animalTransfer = BASE_URL + "/animal/transfer-request";
    getCampData = BASE_URL + "/api/vap/user";
    refreshAnimalDataInServer = BASE_URL + "/v1/api/web/animal/refresh-animal/";
    saveCampData = BASE_URL + "/v1/api/mobile-app/project/update-vip/";
    requestVisits = BASE_URL + "/health/healthVisit/requestFarmerVisit";
    updatefarmermobile =
        BASE_URL + "/v1/api/web/application/update-farmermobile";
    getVistiReqMobile = BASE_URL + "/v1/api/web/application/get-farmerinfo";
    savemilkentry = BASE_URL + "/v1/api/web/milk/swssavemilkentry";
    getDcsAitSorted = BASE_URL + "/v1/api/web/application/get-dcs-ait-sorted";
    getWorkDone = BASE_URL + "/v1/api/mobile-app/report/work-done";
    updatefarmernew =
        BASE_URL + "/getfarmeractive/getdata.asmx?op=GetFarmerActive";
    getSocietyCode = BASE_URL + "/lot/filter_by_dcs_code?search_term";
    getFarmerCode = BASE_URL + "/camp/fill-combo/farmer?lot";
    getaitsemen = BASE_URL + "/v1/api/mobile-app/account/aitsemen-request";
    getRequestDetails =
        BASE_URL + "/v1/api/mobile-app/account/getaitsemen-requestdetails";
    getRequestDetailsSub =
        BASE_URL + "/v1/api/mobile-app/account/getmobilesire-stockdetails";
    getRequestUpdate =
        BASE_URL + "/v1/api/mobile-app/account/update-sirerequest";
    getDailyActionDone = BASE_URL + "/v1/api/mobile-app/report/daily-action";
    getAlarmDone = BASE_URL + "/v1/api/mobile-app/report/get-alarm";
    getReportAi = BASE_URL + "/v1/api/mobile-app/report/get-report";
    getCustomReport = BASE_URL + "/v1/api/mobile-app/report/get-custom-report";
    requestfirstsemen =
        BASE_URL + "/v1/api/mobile-app/account/mobilesemen-request";
    saveanimaltest = BASE_URL + "/v1/api/web/mpp/save-animal-test";
    requestsecondmedicine =
        BASE_URL + "/v1/api/mobile-app/account/mobilemedicine-request";
    requestthirdseed =
        BASE_URL + "/v1/api/mobile-app/account/mobilefeed-request";
    getInsuranceApi = BASE_URL + "/Insurance/getall";
    saveClavigDetails = BASE_URL + "/v1/api/web/animal/save-calf";
    saveClavigDetailsimage = BASE_URL + "/v1/api/web/animal/save-calfphoto";
    getBankApi = BASE_URL + "/bank/getall";
    GET_CENTER = BASE_URL + "/zone/getall?company=";
    GET_DCS = BASE_URL + "/straw-management/getAll";
    GET_UNITREPORT = BASE_URL + "/vehicle-registeration/unit-report?offset=0&limit=100&filter=%7B%22%5BMZ%5D.%5Bid%5D%22:${Constants_Usermast.zone}%7D&column_name=Date&sort_order=desc";
    GET_ADDDCS = BASE_URL + "/vehicle/lot-unitdetails/add";
    GET_UNITCRUD = "$BASE_URL/vehicle-registeration/unit-report";
    Get_OutsideDcs = "$BASE_URL/vehicle-registeration/save-outside-dcs";
    Get_InsideDcs = "$BASE_URL/vehicle-registeration/save-inside-dcs";
    LOGIN_DEVICE = BASE_URL + "/v1/api/web/application/mobileinfoapi";
    createPMCertificate = BASE_URL + "/api/health/pm-certification";
    createSCCertificate = BASE_URL + "/health/visit/sc-certification";
    genomixdetail = BASE_URL + "/v1/api/web/animal/savetraittype";
    AISave = BASE_URL + "/api/sp/breeding/AISave";
    abortion = BASE_URL + "/api/sp/breeding/AbortionSave";
    DrySave = BASE_URL + "/api/sp/breeding/DrySave";
    Animal_dispos = BASE_URL + "/api/sp/animal/DisposalSave";
    Breed_pd = BASE_URL + "/api/sp/breeding/PD2Save";
    Breeding_Calving = BASE_URL + "/api/sp/breeding/CalvingSave";
    Masterdata = BASE_URL + "/api/sp/Application/GetMasterdata";
    DownloadSC = BASE_URL + "/health/visit/certifications";
    DownloadPm = BASE_URL + "/health/visit/certifications";
    UpdateFarmer = BASE_URL + "/api/v3/master/getFarmerActive";
    GetEvm = BASE_URL + "/api/sp/getEvemreRequest";
    UpdateEVM = BASE_URL + "/api/sp/EVMupdate";
    GetFarmerStatus = BASE_URL + "/api/v3/master/getFarmerActiveStatus";
    GetTreatmentdetails =
        BASE_URL + "/api/v4/user/GetTreatmentdetailstransferdata";
    Getlot = BASE_URL + "/api/v4/user/Getlottransferdata";
    GetTreatment = BASE_URL + "/api/v4/user/GetTreatmenttransferdata";
    GetProduction = BASE_URL + "/api/v4/user/GetProductiontransferdata";
    GetReproduction = BASE_URL + "/api/v4/user/GetReproductiontransferdata";
    GetAnimal = BASE_URL + "/api/v4/user/GetAnimaltransferdata";
    GetFarmer = BASE_URL + "/api/v4/user/GetFarmertransferdata";
    saveFarmer= BASE_URL + "/api/sp/Master/SaveFarmer";
  }

  //  String //  CATTLE_REGISTER_INSERT_URL =  + "/api/cattle-detail/add";
//  String //  CATTLE_STATUS_TIMELINE_URL =  + "/api/cattle_timeline";
  //  String //   CATTLE_MILKING_ENTRY_URL =  + "/api/milking_entry";
  String LOGIN_URL = "",
      LOGIN_URL_CHECK = "",
      GetEvm = "",
      UpdateEVM = "",
      REG_CHECK_FARMER = "",
      MASTER_DATA = "",
      UpdateFarmer = "",
      GetFarmerStatus = "",
      farmerData = "",
      animalData = "",
      animalviseData = "",
      animalDataDcsVise = "",
      animalDataDcsViseNew = "",
      Get_sirestock = "",
      Animal_Save = "",
      savelanguage = "",
      getlanguage = "",
      GetAnimalbyuserid = "",
      saveSireStock = "",
      SAMPLE_FORM = "",
      SCAN_CODE = "",
      Masterdata = "",
      GET_ALL_HERD = "",
      GET_ALL_LOTS = "",
      ONETIMEDATA = "",
      MilkPDTest = "",
      abortion = "",
      GET_ALL_FARMERS = "",
      GET_ALL_PERMISSION = "",
      CATTLE_REGISTER_INSERT_URL = "",
      CATTLE_STATUS_TIMELINE_URL = "",
      CATTLE_MILKING_ENTRY_URL = "",
      CATTLE_WEIGHT_ENTRY_URL = "",
      CATTLE_VACCINATION_ENTRY_URL = "",
      CATTLE_DEWORMING_ENTRY_URL = "",
      CATTLE_SYNC_BACK_URL = "",
      CATTLE_ACTIVITY_TIMELINE_URL = "",
      CATTLE_herd_lot_farmer_feature_sync = "",
      CATTLE_all_master_data_sync = "",
      CATTLE_cattle_get_unsync_data = "",
      CATTLE_DISPOSAL = "",
      CATTLE_TREATMENT_ENTRY = "",
      CATTLE_TREATMENT_OTHER_ENTRY = "",
      APP_SETTINGS = "",
      getVisitRegistration = "",
      getNonSyncedVisits = "",
      updateDeliveryTime = "",
      RegisterFarmer = "",
      upDateVisitRegistration = "",
      upDateVisitRegistrationCost = "",
      upDateVisitRegistrationCostUpdate = "",
      getSires = "",
      checkCattleAvailable = "",
      vehicleData = "",
      vehicleLastKM = "",
      vehicleDriversData = "",
      vehiclePurposes = "",
      vehicleUnitDetails = "",
      AnimalRefresh = "",
      Save_reproduction = "",
      vehicleUnitDetailsUpdate = "",
      vehicleUnitDetailsDelete = "",
      visitCase = "",
      requestItems = "",
      requestItemsRequest = "",
      medicineLedger = "",
      registration = "",
      animalTransfer = "",
      getCampData = "",
      refreshAnimalDataInServer = "",
      saveCampData = "",
      requestVisits = "",
      updatefarmermobile = "",
      getVistiReqMobile = "",
      savemilkentry = "",
      getDcsAitSorted = "",
      getWorkDone = "",
      updatefarmernew = "",
      getSocietyCode = "",
      getFarmerCode = "",
      getaitsemen = "",
      getRequestDetails = "",
      getRequestDetailsSub = "",
      getRequestUpdate = "",
      getDailyActionDone = "",
      getAlarmDone = "",
      getReportAi = "",
      getCustomReport = "",
      requestfirstsemen = "",
      saveanimaltest = "",
      saveFarmer = "",
      requestsecondmedicine = "",
      requestthirdseed = "",
      getInsuranceApi = "",
      saveClavigDetails = "",
      saveClavigDetailsimage = "",
      getBankApi = "",
      LOGIN_DEVICE = "",
      createPMCertificate = "",
      createSCCertificate = "",
      genomixdetail = "",
      GET_CENTER = "",
      GET_DCS = "",
      GET_UNITREPORT = "",
      GET_UNITCRUD = "",
      Get_OutsideDcs="",
      Get_InsideDcs="",
      GET_ADDDCS = "",
      AISave = "",
      DrySave = "",
      Animal_dispos = "",
      Breed_pd = "",
      DownloadSC = "",
      DownloadPm = "",
      Breeding_Calving = "",
      GetTreatmentdetails = "",
      Getlot = "",
      GetTreatment = "",
      GetProduction = "",
      GetReproduction = "",
      GetAnimal = "",
      GetFarmer = "";

  final changedpwd = "https://testing.herdman.in/auth/change-password";

  String cancelvisit =
      "https://dudhsagar.herdman.in/health/visit/update-report";

  String getVisitCost(String time, String dcsCode, String visitType) {
    String url = BASE_URL +
        "/account/visit_rate/by_time_visit_type?time=$time&dcsCode=$dcsCode&visit_type=$visitType";
    return url;
  }

  String getVisitVoAndStaff(String time, String herd, String zone) {
    return BASE_URL +
        "/application/route_vo_allocation/vo_by_time?time=$time&herd=$herd&zone=$zone";
  }
}
