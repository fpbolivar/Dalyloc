import 'dart:io';
import 'package:daly_doc/core/constant/constants.dart';
import 'package:daly_doc/pages/authScreens/authManager/api/businessApis.dart';
import 'package:daly_doc/pages/authScreens/authManager/models/serviceItemModel.dart';

import '../../../utils/exportPackages.dart';
import '../../../utils/exportWidgets.dart';
import '../authManager/models/businessCatModel.dart';
import '../authManager/models/userBusinesModel.dart';

class CreateNewBusinessServiceScreen extends StatefulWidget {
  bool update;

  String? id;
  CreateNewBusinessServiceScreen({
    Key? key,
    this.id,
    this.update = false,
  }) : super(key: key);

  @override
  State<CreateNewBusinessServiceScreen> createState() =>
      _CreateNewBusinessServiceScreenState();
}

class _CreateNewBusinessServiceScreenState
    extends State<CreateNewBusinessServiceScreen> {
  TextEditingController durationTFC = TextEditingController();
  TextEditingController priceTCF = TextEditingController();
  TextEditingController nameTFC = TextEditingController();
  TextEditingController depositTF = TextEditingController();
  ServiceItemDataModel? data;
  UserBusinessModel? UserBusinessData;

  WeekDaysModel? singleSelection;
  int businessCategoryId = 0;
  File? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.update == true) {
        data = await BusinessApis().getBusinessServicesByID(id: widget.id);
        if (data != null) {
          setState(() {
            nameTFC.text = data!.service_name.toString();
            priceTCF.text = data!.service_price.toString();
            durationTFC.text = data!.service_time.toString();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBar(title: LocalString.lblServiceDetail),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(),
        ),
      )),
    );
  }

  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTF(
                    controllr: nameTFC,
                    placeholder: LocalString.plcServiceName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTF(
                    controllr: priceTCF,
                    placeholder: LocalString.plcServicePrice,
                    keyBoardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTF(
                    controllr: durationTFC,
                    placeholder: LocalString.plcDuration,
                    keyBoardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTF(
                    controllr: depositTF,
                    placeholder: LocalString.plcDeposit,
                    keyBoardType: TextInputType.number,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 100,
              ),
              CustomButton.regular(
                title: LocalString.lblSave,
                onTap: () async {
                  data == null
                      ? BusinessApis().createNewService(
                          context: context,
                          serviceName: nameTFC.text,
                          price: priceTCF.text,
                          Duration: durationTFC.text,
                          deposit_percentage: depositTF.text,
                          onSuccess: () {
                            Navigator.pop(context);

                            // Navigator.of(context).popUntil((route) =>
                            //     route.settings.name ==
                            //     SettingScreen().runtimeType.toString());
                            // Constant.settingProvider.getUserBusinessDetail();
                          },
                        )
                      : BusinessApis().createUpdateService(
                          context: context,
                          serviceName: nameTFC.text,
                          price: priceTCF.text,
                          serviceID: data!.id.toString(),
                          Duration: durationTFC.text,
                          deposit_percentage: depositTF.text,
                          onSuccess: () {
                            Navigator.pop(context);
                            // Navigator.of(context).popUntil((route) =>
                            //     route.settings.name ==
                            //     SettingScreen().runtimeType.toString());
                            // Constant.settingProvider.getUserBusinessDetail();
                          },
                        );
                },
              ),
            ]),
      ),
    );
  }
}
