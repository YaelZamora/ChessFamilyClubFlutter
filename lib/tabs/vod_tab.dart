import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VODTab extends StatelessWidget {
  const VODTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
              'https://player.twitch.tv/?channel=chessfamilyclub',
            )) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transmisión en vivo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Container(
            width: size.width,
            height: 200,
            color: Colors.black,
            margin: const EdgeInsets.only(bottom: 30),
            child: WebViewWidget(controller: controller),
          ),
          const Text(
            'Transmisiones pasadas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.5,
            margin: const EdgeInsets.only(bottom: 30),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                mainAxisExtent: 100,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) => Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/id/$index/200',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {},
                  iconSize: 60,
                  icon: const Icon(Icons.play_circle_fill_rounded),
                ),
              ),
            ),
          ),
          const Text(
            'Clases gratuitas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            width: size.width,
            height: size.height * 0.4,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                mainAxisExtent: 100,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) => Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/id/$index/200',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {},
                  iconSize: 60,
                  icon: const Icon(Icons.play_circle_fill_rounded),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
