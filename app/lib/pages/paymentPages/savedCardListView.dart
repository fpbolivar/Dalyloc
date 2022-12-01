import 'package:daly_doc/pages/paymentPages/addCardView.dart';
import 'package:daly_doc/pages/paymentPages/model/SavedCardModel.dart';
import 'package:daly_doc/widgets/swipeAction/flutter_swipe_action_cell.dart';
import '../../../../utils/exportPackages.dart';
import '../../../../utils/exportWidgets.dart';
import 'apiManager/paymentManager.dart';
import 'components/cardSavedItem.dart';
import 'components/noCardWidget.dart';

class SavedCardListView extends StatefulWidget {
  SavedCardListView({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedCardListView> createState() => _SavedCardListViewState();
}

class _SavedCardListViewState extends State<SavedCardListView> {
  List<SavedCardModel> savedCardList = [];
  var manager = PaymentManager();
  late SwipeActionController controller;
  @override
  void initState() {
    super.initState();
    initSwipeController();
    PaymentManager.cardNeedRefresh = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCard();
    });
  }

  initSwipeController() {
    controller = SwipeActionController(selectedIndexPathsChangeCallback:
        (changedIndexPaths, selected, currentCount) {
      print(
          'cell at ${changedIndexPaths.toString()} is/are ${selected ? 'selected' : 'unselected'} ,current selected count is $currentCount');

      setState(() {});
    });
  }

  getCard() async {
    List<SavedCardModel>? cardList = await manager.getCard();
    if (cardList != null) {
      savedCardList = cardList;
    } else {
      savedCardList = [];
    }
    setState(() {});
  }

  setDefaultCard(cardId) async {
    bool? status = await manager.setDefaultCard(cardID: cardId);
    if (status != null) {
      getCard();
    }
  }

  deleteCard(cardId) async {
    bool? status = await manager.deleteCard(cardID: cardId);
    if (status != null) {
      getCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.newBgcolor,
      appBar: CustomAppBarPresentCloseButton(
          title: "Payment",
          subtitle: "Method",
          subtitleColor: AppColor.textGrayBlue),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Routes.pushSimple(
              context: context,
              child: AddCardView(),
              onBackPress: () {
                if (PaymentManager.cardNeedRefresh) {
                  getCard();
                  PaymentManager.cardNeedRefresh = false;
                }
              });
        },
        backgroundColor: AppColor.theme,
        child: const Icon(Icons.add),
      ),
      body: BackgroundCurveView(
          child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  savedCardList.length == 0
                      ? Expanded(child: NoCardWidget(
                          refresh: () {
                            getCard();
                          },
                        ))
                      : Expanded(child: bodyDesign()),
                  const SizedBox(
                    height: 20,
                  ),
                  // CustomButton.regular(
                  //   title: "Submit",
                  //   background: AppColor.theme,
                  //   onTap: () async {},
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                ])),
      )),
    );
  }

//METHID : -   bodyDesign
  Widget bodyDesign() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),

              listView(),

              const SizedBox(
                height: 20,
              ),

              //
            ]),
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: savedCardList.length,
      itemBuilder: (conext, index) {
        return InkWell(
            onTap: () {
              // Routes.presentSimple(
              //     context: context,
              //     child: PlanDetailView(
              //       data: freePlan[index],
              //     ));
              //onTap!(itemList[index].section ?? 0, index);
            },
            child: _item(conext, index));
      },
      separatorBuilder: (BuildContext context, int index) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        );
      },
    );
  }

  Widget _item(BuildContext ctx, int index) {
    return SwipeActionCell(
      controller: controller,
      index: index,

      // Required!
      key: ValueKey(savedCardList[index]),

      /// Animation default value below
      // normalAnimationDuration: 400,
      // deleteAnimationDuration: 400,
      selectedForegroundColor: Colors.black.withAlpha(30),
      trailingActions: [
        SwipeAction(
            title: "Delete",
            backgroundRadius: 5,

            //performsFirstActionWithFullSwipe: true,
            nestedAction: SwipeNestedAction(
              title: "Confirm",
            ),
            onTap: (handler) async {
              deleteCard(savedCardList[index].id);
            }),
      ],
      leadingActions: [
        SwipeAction(
            title: "delete",
            backgroundRadius: 5,
            //performsFirstActionWithFullSwipe: true,
            nestedAction: SwipeNestedAction(title: "confirm"),
            onTap: (handler) async {
              deleteCard(savedCardList[index].id);
            }),
      ],
      child: CardSavedItemView(
        item: savedCardList[index],
        onDefaultSet: () {
          setDefaultCard(savedCardList[index].id);
        },
        onDeleted: () {},
      ),
    );
  }
}
