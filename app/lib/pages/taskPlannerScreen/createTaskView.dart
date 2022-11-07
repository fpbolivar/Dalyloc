import 'package:daly_doc/pages/taskPlannerScreen/components/howOftenView.dart';
import 'package:daly_doc/pages/taskPlannerScreen/components/timePickerView.dart';

import '../../../utils/exportPackages.dart';
import '../../utils/exportWidgets.dart';
import 'components/addSubtasksVIew.dart';
import 'components/emailTFView.dart';
import 'components/howlongDurationView.dart';
import 'components/notesTFView.dart';

class CreateTaskView extends StatefulWidget {
  String? red;
  CreateTaskView({Key? key, this.red}) : super(key: key);

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: LocalString.lblCreate,
          subtitle: "Task",
          subtitleColor: AppColor.textGrayBlue),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: bodyDesign(),
        ),
      )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              EmaiViewTask(),
              const SizedBox(
                height: 20,
              ),
              TimePickerViewTask(),
              const SizedBox(
                height: 20,
              ),
              HowLongViewTask(),
              const SizedBox(
                height: 20,
              ),
              HowOftenViewTask(),
              const SizedBox(
                height: 20,
              ),
              AddSubTaskViewTask(),
              const SizedBox(
                height: 20,
              ),
              NoteTFViewTask(),
              const SizedBox(
                height: 50,
              ),
              CustomButton.regular(
                title: "Create Task",
              ),
              const SizedBox(
                height: 50,
              ),
            ]),
      ),
    );
  }
}
