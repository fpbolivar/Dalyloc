class SliderModel {
  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath!;
  }

  String getTitle() {
    return title!;
  }

  String getDesc() {
    return desc!;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "Select 1 word, then add the people/places/things you're grateful for. Ex: LIFE L=Leisure I=Investment F=Family E=Earth.");
  sliderModel.setTitle("Gratitude Journaling");
  sliderModel.setImageAssetPath("assets/icons/doc.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Enjoy guided retreats anytime, anywhere. BYOC - Bring Your Own Chocolate.");
  sliderModel.setTitle("Bite-Sized Retreat ");
  sliderModel.setImageAssetPath("assets/icons/doc.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel
      .setDesc("Meditate at your desk with our live MYRetreat community.");
  sliderModel.setTitle("Experience The Live Retreat");
  sliderModel.setImageAssetPath("assets/icons/doc.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //4
  sliderModel.setDesc(
      "MYRetreat sends chocolates to businesses/organizations every 100th time a bite-sized retreat is completed.");
  sliderModel.setTitle("Chocolate Mindfulness");
  sliderModel.setImageAssetPath("assets/icons/doc.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
