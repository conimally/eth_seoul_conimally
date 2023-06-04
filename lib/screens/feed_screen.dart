import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:tiktok_flutter/data/video.dart';
import 'package:tiktok_flutter/screens/feed_viewmodel.dart';
import 'package:tiktok_flutter/screens/gridCat.dart';
import 'package:tiktok_flutter/screens/messages_screen.dart';
import 'package:tiktok_flutter/screens/profile_screen.dart';
import 'package:tiktok_flutter/screens/search_screen.dart';
import 'package:tiktok_flutter/widgets/actions_toolbar.dart';
import 'package:tiktok_flutter/widgets/bottom_bar.dart';
import 'package:tiktok_flutter/widgets/video_description.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final locator = GetIt.instance;
  final feedViewModel = GetIt.instance<FeedViewModel>();

  Map response = {};
  String contractId = 'friendbook.nearflutter.testnet';
  String mutateMethod = 'submitMessage';
  String viewMethod = 'getAllMessages';
  late Account connectedAccount;
  String userAccount = 'neararabic.testnet';
  final _textUserIdController = TextEditingController();

  @override
  void initState() {
    _textUserIdController.text = "nearflutter.testnet";
    feedViewModel.loadVideo(0);
    feedViewModel.loadVideo(1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        disposeViewModel: false,
        builder: (context, model, child) => videoScreen(),
        viewModelBuilder: () => feedViewModel);
  }

  Widget videoScreen() {
    return Scaffold(
      backgroundColor: GetIt.instance<FeedViewModel>().actualScreen == 0
          ? Colors.black
          : Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 2,
            onPageChanged: (value) {
              print(value);
              if (value == 1)
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              else
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
            },
            itemBuilder: (context, index) {
              if (index == 0)
                return scrollFeed();
              else
                return profileView();
            },
          )
        ],
      ),
    );
  }

  Widget profileView() {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Container(
              color: Colors.white,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Text(
                        "Charlotte Stone",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.more_horiz)
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg",
                            height: 100.0,
                            width: 100.0,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "@Charlotte21",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "232",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1,
                          height: 15,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        Column(
                          children: [
                            Text(
                              "1.3k",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1,
                          height: 15,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        Column(
                          children: [
                            Text(
                              "12k",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Likes",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 47,
                          decoration: BoxDecoration(
                            color: Colors.pink[500],
                          ),
                          child: Center(
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 45,
                          height: 47,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Center(child: Icon(Icons.camera_alt)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 35,
                          height: 47,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Center(child: Icon(Icons.arrow_drop_down)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.menu),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                color: Colors.black,
                                height: 2,
                                width: 55,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.black26,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                color: Colors.transparent,
                                height: 2,
                                width: 55,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/tOueglJrk5rS8/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/665IPY24jyWFa/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/chjX2ypYJKkr6/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/sC60eX0OVIH7O/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/NsXhybxnMKsh2/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/HE6hyf47yAX1S/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]))),
    );
  }

  Widget scrollFeed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: currentScreen()),
        BottomBar(),
      ],
    );
  }

  Widget feedVideos() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: feedViewModel.videoSource?.listVideos.length,
          onPageChanged: (index) {
            index = index % (feedViewModel.videoSource!.listVideos.length);
            feedViewModel.changeVideo(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % (feedViewModel.videoSource!.listVideos.length);
            return videoCard(feedViewModel.videoSource!.listVideos[index]);
          },
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Following',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70)),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    color: Colors.white70,
                    height: 10,
                    width: 1.0,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text('For You',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ]),
          ),
        ),
      ],
    );
  }

  Widget currentScreen() {
    switch (feedViewModel.actualScreen) {
      case 0:
        return feedVideos();
      case 1:
        return SearchScreen();
      case 2:
        return MessagesScreen();
      case 3:
        return ProfileScreen();
      default:
        return feedVideos();
    }
  }

  Widget videoCard(Video video) {
    final myController = TextEditingController();
    return Stack(
      children: [
        video.controller != null
            ? GestureDetector(
                onTap: () {
                  if (video.controller!.value.isPlaying) {
                    video.controller?.pause();
                  } else {
                    video.controller?.play();
                  }
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: video.controller?.value.size.width ?? 0,
                    height: video.controller?.value.size.height ?? 0,
                    child: VideoPlayer(video.controller!),
                  ),
                )),
              )
            : Container(
                color: Colors.black,
                child: Center(
                  child: Text("Loading"),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                VideoDescription(video.user, video.videoTitle, video.songName),
                ActionsToolbar(video.likes, video.comments,
                    "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
        Column(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 900,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  '  Thanks to Creator',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  '  with DANGs!',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            Image.asset('assets/images/dangdang.png',
                                width: 169),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  '  Amount',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                  controller: myController,
                                  decoration: const InputDecoration(
                                    suffixText: 'DANG',
                                  )),
                            ),
                            myController.text == ""
                                ? Text("")
                                : Text(
                                    '${(int.parse(myController.text) / 10).toString()} Near'),
                            SizedBox(
                              width: 360,
                              height: 55,
                              child: ElevatedButton(
                                child: const Text(
                                  'Support!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.purple, // Background color
                                ),
                                onPressed: () {
                                  setState(() {});
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 900,
                                        color: Colors.white,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            //mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    '  DANGs to ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Text(
                                                    'ETH',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Text(
                                                    '!',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 40),
                                              Image.asset(
                                                'assets/images/catcat.png',
                                                width: 169,
                                              ),
                                              SizedBox(height: 30),
                                              Image.asset(
                                                  'assets/images/donation_bar.png',
                                                  width: 360),
                                              SizedBox(height: 50),
                                              SizedBox(
                                                width: 360,
                                                height: 55,
                                                child: ElevatedButton(
                                                  child: const Text(
                                                    'Mint NFT!',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .red, // Background color
                                                  ),
                                                  onPressed: () =>
                                                      Get.to(() => gridCat()),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/dangdang.png',
                          width: 40,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "10,000 DANG",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          // margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            "Support",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            String walletURL =
                                'https://wallet.testnet.near.org/login/?';
                            String contractId =
                                'friendbook.nearflutter.testnet';
                            String appTitle = 'Friendbook';
                            String accountId = userAccount;
                            String nearSignInSuccessUrl =
                                'https://near-transaction-serializer.herokuapp.com/success';
                            String nearSignInFailUrl =
                                'https://near-transaction-serializer.herokuapp.com/failure';

                            connectedAccount =
                                NEARTester.loginWithLimitedAccess(
                                    walletURL,
                                    contractId,
                                    accountId,
                                    appTitle,
                                    nearSignInSuccessUrl,
                                    nearSignInFailUrl);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            // margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              "Connect a Wallet",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    feedViewModel.controller?.dispose();
    super.dispose();
  }
}

class NEARTester {
  static loginWithLimitedAccess(walletURL, contractId, accountId, appTitle,
      signInSuccessUrl, signInFailureUrl) {
    // Generate Keys
    var keyPair = KeyStore.newKeyPair();

    // Open near wallet in default browser
    Account account = Account(
        accountId: accountId,
        keyPair: keyPair,
        provider: NEARTestNetRPCProvider());

    var wallet = Wallet(walletURL);
    wallet.connect(contractId, appTitle, signInSuccessUrl, signInFailureUrl,
        account.publicKey);

    return account; //connected account
  }

  static loginWithFullAccess(walletURL, contractId, accountId, appTitle,
      signInSuccessUrl, signInFailureUrl) {
    // Generate Keys
    var keyPair = KeyStore.newKeyPair();
    var publicKey = KeyStore.publicKeyToString(keyPair.publicKey);

    // Open near wallet in default browser
    var wallet = Wallet(walletURL);

    wallet.connectWithFullAccess(
        contractId, appTitle, signInSuccessUrl, signInFailureUrl, publicKey);

    Account account = Account(
        accountId: accountId,
        keyPair: keyPair,
        provider: NEARTestNetRPCProvider());

    return account; //connected account
  }

  //contract holds the account to use for calling
  static callMethodLimitedAccess(Contract contract, String method, args) async {
    var result = await contract.callFunction(method, args);
    return result;
  }

  static callViewMethod(Contract contract, String method, args) async {
    var result = await contract.callViewFuntion(method, args);
    return result;
  }

  //contract holds the account to use for calling - account must have a full access key
  static callMethodFullAccess(Contract contract, String method, args) async {
    var result = await contract.callFunction(method, args);
    return result;
  }

  static callMethodFullAccessWithDeposit(
      Contract contract, String method, args, nearAmount) async {
    var result = await contract.callFunction(method, args, nearAmount);
    return result;
  }

  static callMethodLimitedAccessWithDeposit(
      Contract contract,
      String method,
      String walletURL,
      args,
      nearAmount,
      successUrl,
      failureUrl,
      approvalURL) async {
    // Open near wallet in default browser
    var wallet = Wallet(walletURL);

    var result = await contract.callFunctionWithDeposit(
        method, args, wallet, nearAmount, successUrl, failureUrl, approvalURL);
    return result;
  }

  static transferNear(Account account, nearAmount, receiver) async {
    var result = await account.sendTokens(nearAmount, receiver);
    return result;
  }
}
