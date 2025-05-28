// // // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // // // // // // // // class WebViewScreen extends StatefulWidget {
// // // // // // // // // //   final String payUrl;
// // // // // // // // // //   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

// // // // // // // // // //   @override
// // // // // // // // // //   State<WebViewScreen> createState() => _WebViewScreenState();
// // // // // // // // // // }

// // // // // // // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // // // // // // //   InAppWebViewController? webViewController;

// // // // // // // // // // //   @override
// // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // //     return Scaffold(
// // // // // // // // // // //       appBar: AppBar(title: Text("hello"),),
// // // // // // // // // // //       body: SizedBox(
// // // // // // // // // // //         height: double.infinity,
// // // // // // // // // // //         width: double.infinity,
// // // // // // // // // // //         child: InAppWebView(
// // // // // // // // // // //           initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // // // // // // // // // //           onWebViewCreated: (controller){
// // // // // // // // // // //             webViewController = controller;
// // // // // // // // // // //           },
// // // // // // // // // // //         ),
// // // // // // // // // // //       ),
// // // // // // // // // // //       // body: ,
// // // // // // // // // // //     );
// // // // // // // // // // //   }
// // // // // // // // // // // }

// // // // // // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // // // // // //   InAppWebViewController? webViewController;

// // // // // // // // // //   @override
// // // // // // // // // //   void initState() {
// // // // // // // // // //     super.initState();
// // // // // // // // // //     // nuke cookies from orbit so each payment is a fresh login
// // // // // // // // // //     CookieManager.instance().deleteAllCookies();
// // // // // // // // // //   }

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     return Scaffold(
// // // // // // // // // //       appBar: AppBar(title: const Text("Payment")),
// // // // // // // // // //       body: InAppWebView(
// // // // // // // // // //         // 2️⃣ Force a brand‐new WebView on each build
// // // // // // // // // //         key: UniqueKey(),

// // // // // // // // // //         // 1️⃣ Also clear the internal cache
// // // // // // // // // //         initialOptions: InAppWebViewGroupOptions(
// // // // // // // // // //           crossPlatform: InAppWebViewOptions(
// // // // // // // // // //             clearCache: true,
// // // // // // // // // //           ),
// // // // // // // // // //         ),

// // // // // // // // // //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // // // // // // // // //         onWebViewCreated: (ctrl) {
// // // // // // // // // //           webViewController = ctrl;
// // // // // // // // // //         },
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }

// // // // // // // // // import 'package:flutter/foundation.dart' show kIsWeb;
// // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // // // // // // // class WebViewScreen extends StatefulWidget {
// // // // // // // // //   final String payUrl;
// // // // // // // // //   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

// // // // // // // // //   @override
// // // // // // // // //   State<WebViewScreen> createState() => _WebViewScreenState();
// // // // // // // // // }

// // // // // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // // // // //   InAppWebViewController? webViewController;

// // // // // // // // //   @override
// // // // // // // // //   void initState() {
// // // // // // // // //     super.initState();
// // // // // // // // //     // Only clear cookies on mobile (Android/iOS), swallow any errors on other platforms
// // // // // // // // //     if (!kIsWeb) {
// // // // // // // // //       CookieManager.instance()
// // // // // // // // //           .deleteAllCookies()
// // // // // // // // //           .catchError((_) {/* no-op */});
// // // // // // // // //     }
// // // // // // // // //   }

// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return Scaffold(
// // // // // // // // //       appBar: AppBar(
// // // // // // // // //         title: const Text("Payment"),
// // // // // // // // //       ),
// // // // // // // // //       body: InAppWebView(
// // // // // // // // //         key: UniqueKey(), // force a new instance each time
// // // // // // // // //         initialOptions: InAppWebViewGroupOptions(
// // // // // // // // //           crossPlatform: InAppWebViewOptions(
// // // // // // // // //             clearCache: true,
// // // // // // // // //           ),
// // // // // // // // //         ),
// // // // // // // // //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // // // // // // // //         onWebViewCreated: (controller) {
// // // // // // // // //           webViewController = controller;
// // // // // // // // //         },
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // // lib/screens/web_view_screen.dart

// // // // // // // // import 'package:flutter/foundation.dart' show kIsWeb;
// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // // // // // // class WebViewScreen extends StatefulWidget {
// // // // // // // //   final String payUrl;

// // // // // // // //   const WebViewScreen({
// // // // // // // //     Key? key,
// // // // // // // //     required this.payUrl,
// // // // // // // //   }) : super(key: key);

// // // // // // // //   @override
// // // // // // // //   State<WebViewScreen> createState() => _WebViewScreenState();
// // // // // // // // }

// // // // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // // // //   InAppWebViewController? _webViewController;

// // // // // // // //   @override
// // // // // // // //   void initState() {
// // // // // // // //     super.initState();
// // // // // // // //     // Clear cookies on mobile so each payment session is fresh
// // // // // // // //     if (!kIsWeb) {
// // // // // // // //       CookieManager.instance()
// // // // // // // //         .deleteAllCookies()
// // // // // // // //         .catchError((_) {
// // // // // // // //           // ignore errors
// // // // // // // //         });
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       appBar: AppBar(
// // // // // // // //         title: const Text("Payment"),
// // // // // // // //         leading: BackButton(onPressed: () {
// // // // // // // //           Navigator.of(context).pop();
// // // // // // // //         }),
// // // // // // // //       ),
// // // // // // // //       body: InAppWebView(
// // // // // // // //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // // // // // // //         initialOptions: InAppWebViewGroupOptions(
// // // // // // // //           crossPlatform: InAppWebViewOptions(
// // // // // // // //             clearCache: true,
// // // // // // // //             javaScriptEnabled: true,
// // // // // // // //           ),
// // // // // // // //         ),
// // // // // // // //         onWebViewCreated: (controller) {
// // // // // // // //           _webViewController = controller;
// // // // // // // //         },
// // // // // // // //         // Fired when a navigation starts
// // // // // // // //         onLoadStart: (controller, uri) => _maybeRedirect(uri),
// // // // // // // //         // Fired when a navigation finishes
// // // // // // // //         onLoadStop: (controller, uri) => _maybeRedirect(uri),
// // // // // // // //         // Catches form submissions, JS redirects, etc.
// // // // // // // //         shouldOverrideUrlLoading:
// // // // // // // //             (controller, navigationAction) async {
// // // // // // // //           _maybeRedirect(navigationAction.request.url);
// // // // // // // //           return NavigationActionPolicy.ALLOW;
// // // // // // // //         },
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   void _maybeRedirect(Uri? uri) {
// // // // // // // //     if (uri == null) return;
// // // // // // // //     final url = uri.toString();

// // // // // // // //     // Handle successful payment redirect:
// // // // // // // //     if (url.contains('#/success')) {
// // // // // // // //       // Extract query params from the fragment (or fallback to query)
// // // // // // // //       final payload = uri.fragment.isNotEmpty
// // // // // // // //           ? uri.fragment
// // // // // // // //           : uri.query;
// // // // // // // //       final params = Uri.splitQueryString(payload);
// // // // // // // //       final ref = params['payment_ref'] ?? params['paymentRef'];

// // // // // // // //       // Navigate to SuccessPaymentPage, clearing all previous routes
// // // // // // // //       Navigator.of(context)
// // // // // // // //           .pushNamedAndRemoveUntil(
// // // // // // // //             '/success',
// // // // // // // //             (route) => false,
// // // // // // // //             arguments: ref,
// // // // // // // //           );
// // // // // // // //       return;
// // // // // // // //     }

// // // // // // // //     // (Optional) Handle failure redirect if you implement a FailPaymentPage:
// // // // // // // //     if (url.contains('#/fail')) {
// // // // // // // //       Navigator.of(context)
// // // // // // // //           .pushNamedAndRemoveUntil(
// // // // // // // //             '/fail',
// // // // // // // //             (route) => false,
// // // // // // // //           );
// // // // // // // //       return;
// // // // // // // //     }
// // // // // // // //   }
// // // // // // // // }

// // // // // // // import 'package:flutter/foundation.dart' show kIsWeb;
// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // // // // // // import 'package:webview_flutter/webview_flutter.dart';
// // // // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // // // // // class WebViewScreen extends StatefulWidget {
// // // // // // //   final String payUrl;
// // // // // // //   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

// // // // // // //   @override
// // // // // // //   State<WebViewScreen> createState() => _WebViewScreenState();
// // // // // // // }

// // // // // // // class _WebViewScreenState extends State<WebViewScreen> {

// // // // // // //   late final WebViewController _controller;
// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     if (!kIsWeb) {
// // // // // // //       CookieManager.instance().deleteAllCookies().catchError((_) {});
// // // // // // //     }
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     // Dispose the WebView controller when leaving the screen
// // // // // // //     _controller.clearCache();
// // // // // // //     super.dispose();
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(title: const Text('Payment')),
// // // // // // //       body: InAppWebView(
// // // // // // //         key: UniqueKey(),                       // brand-new WebView each build
// // // // // // //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // // // // // //         initialOptions: InAppWebViewGroupOptions(
// // // // // // //           crossPlatform: InAppWebViewOptions(
// // // // // // //             clearCache: true,
// // // // // // //             javaScriptEnabled: true,
// // // // // // //           ),
// // // // // // //         ),

// // // // // // //         // ─────────────── callbacks ───────────────
// // // // // // //         onLoadStart: (ctrl, uri) => _maybeRedirect(uri),
// // // // // // //         onLoadStop:  (ctrl, uri) => _maybeRedirect(uri),
// // // // // // //         shouldOverrideUrlLoading: (ctrl, nav) async {
// // // // // // //           _maybeRedirect(nav.request.url);
// // // // // // //           return NavigationActionPolicy.ALLOW;
// // // // // // //         },

// // // // // // //         // 🔹 1.  ADD THIS: catches resources loaded in iframes
// // // // // // //         onLoadResource: (controller, resource) {
// // // // // // //           _maybeRedirect(Uri.parse(resource.url as String));
// // // // // // //         },
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   // ─────────────────────────────────────────────

// // // // // // //   void _maybeRedirect(Uri? uri) {
// // // // // // //     if (uri == null) return;
// // // // // // //     debugPrint('[LOAD] $uri');

// // // // // // //     final url = uri.toString();

// // // // // // //     // -------- SUCCESS ----------
// // // // // // //     if (url.contains('#/success')) {
// // // // // // //       debugPrint('[REDIRECT → success]');

// // // // // // //       final payload = uri.fragment.isNotEmpty ? uri.fragment : uri.query;
// // // // // // //       final params  = Uri.splitQueryString(payload);
// // // // // // //       final ref     = params['payment_ref'] ?? params['paymentRef'];

// // // // // // //       // 🔹 2.  WRAP THE PUSH in a post-frame callback
// // // // // // //       WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // // // //         Navigator.of(context).pushNamedAndRemoveUntil(
// // // // // // //           '/success',
// // // // // // //           (route) => false,
// // // // // // //           arguments: ref,
// // // // // // //         );
// // // // // // //       });
// // // // // // //       return;
// // // // // // //     }

// // // // // // //     // -------- FAILURE ----------
// // // // // // //     if (url.contains('#/fail')) {
// // // // // // //       debugPrint('[REDIRECT → fail]');
// // // // // // //       WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // // // //         Navigator.of(context).pushNamedAndRemoveUntil(
// // // // // // //           '/fail',
// // // // // // //           (route) => false,
// // // // // // //         );
// // // // // // //       });
// // // // // // //     }
// // // // // // //   }
// // // // // // // }

// // // // // // import 'package:flutter/foundation.dart' show kIsWeb;
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // // // // class WebViewScreen extends StatefulWidget {
// // // // // //   final String payUrl;
// // // // // //   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

// // // // // //   @override
// // // // // //   State<WebViewScreen> createState() => _WebViewScreenState();
// // // // // // }

// // // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // // //   InAppWebViewController? _webViewController;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     if (!kIsWeb) {
// // // // // //       CookieManager.instance().deleteAllCookies().catchError((_) {});
// // // // // //     }
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     // Optionally clear cache before disposing
// // // // // //     _webViewController?.clearCache();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(title: const Text('Payment')),
// // // // // //       body: InAppWebView(
// // // // // //         key: const ValueKey("payment_webview"),  // ensures a fresh instance on rebuild
// // // // // //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // // // // //         initialOptions: InAppWebViewGroupOptions(
// // // // // //           crossPlatform: InAppWebViewOptions(
// // // // // //             clearCache: true,
// // // // // //             javaScriptEnabled: true,
// // // // // //           ),
// // // // // //         ),
// // // // // //         onWebViewCreated: (controller) {
// // // // // //           _webViewController = controller;
// // // // // //         },
// // // // // //         onLoadStart: (controller, uri) => _maybeRedirect(uri),
// // // // // //         onLoadStop: (controller, uri) => _maybeRedirect(uri),
// // // // // //         shouldOverrideUrlLoading: (controller, navigationAction) async {
// // // // // //           _maybeRedirect(navigationAction.request.url);
// // // // // //           return NavigationActionPolicy.ALLOW;
// // // // // //         },
// // // // // //         onLoadResource: (controller, resource) {
// // // // // //           // catches resources in iframes as well
// // // // // //           _maybeRedirect(Uri.parse(resource.url as String));
// // // // // //         },
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   void _maybeRedirect(Uri? uri) {
// // // // // //     if (uri == null) return;
// // // // // //     debugPrint('[LOAD] $uri');

// // // // // //     final url = uri.toString();

// // // // // //     // Success
// // // // // //     if (url.contains('#/success')) {
// // // // // //       debugPrint('[REDIRECT → success]');
// // // // // //       final payload = uri.fragment.isNotEmpty ? uri.fragment : uri.query;
// // // // // //       final params = Uri.splitQueryString(payload);
// // // // // //       final ref = params['payment_ref'] ?? params['paymentRef'];

// // // // // //       WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // // //         Navigator.of(context).pushNamedAndRemoveUntil(
// // // // // //           '/success',
// // // // // //           (route) => false,
// // // // // //           arguments: ref,
// // // // // //         );
// // // // // //       });
// // // // // //       return;
// // // // // //     }

// // // // // //     // Failure
// // // // // //     if (url.contains('#/fail')) {
// // // // // //       debugPrint('[REDIRECT → fail]');
// // // // // //       WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // // //         Navigator.of(context).pushNamedAndRemoveUntil(
// // // // // //           '/fail',
// // // // // //           (route) => false,
// // // // // //         );
// // // // // //       });
// // // // // //     }
// // // // // //   }
// // // // // // }

// // // // // // WebViewScreen.dart
// // // // // import 'package:flutter/foundation.dart' show kIsWeb;
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // // // // import the global key we created in main.dart
// // // // // import 'package:flutter_application_1/main.dart' show navigatorKey;

// // // // // class WebViewScreen extends StatefulWidget {
// // // // //   final String payUrl;
// // // // //   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

// // // // //   @override
// // // // //   State<WebViewScreen> createState() => _WebViewScreenState();
// // // // // }

// // // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // // //   InAppWebViewController? _webViewController;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     // clear cookies on mobile so the gateway starts clean
// // // // //     if (!kIsWeb) {
// // // // //       CookieManager.instance().deleteAllCookies().catchError((_) {});
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _webViewController?.clearCache();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(title: const Text('Payment')),
// // // // //       body: InAppWebView(
// // // // //         key: UniqueKey(), // brand-new instance every build
// // // // //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // // // //         initialOptions: InAppWebViewGroupOptions(
// // // // //           crossPlatform: InAppWebViewOptions(clearCache: true),
// // // // //         ),

// // // // //         // keep the controller
// // // // //         onWebViewCreated: (controller) => _webViewController = controller,

// // // // //         // ── NAVIGATION HOOKS ─────────────────────────────────────────────
// // // // //         onLoadStart:        (c, uri) => _maybeRedirect(uri),
// // // // //         onLoadStop:         (c, uri) => _maybeRedirect(uri),
// // // // //         onLoadResource:     (c, res) =>
// // // // //             _maybeRedirect(Uri.parse(res.url as String)),
// // // // //         onUpdateVisitedHistory: (c, uri, androidIsReload) =>
// // // // //             _maybeRedirect(uri), // ← catches #/success hash changes
// // // // //         shouldOverrideUrlLoading: (c, nav) async {
// // // // //           _maybeRedirect(nav.request.url);
// // // // //           return NavigationActionPolicy.ALLOW;
// // // // //         },
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // ─────────────────────────────────────────────────────────────────────
// // // // //   void _maybeRedirect(Uri? uri) {
// // // // //     if (uri == null) return;
// // // // //     final url = uri.toString();
// // // // //     debugPrint('[WebView] check → $url');

// // // // //     // ---------- SUCCESS ----------
// // // // //     if (url.contains('#/success')) {
// // // // //       // payment_ref comes after the '#' (hash) in Konnect
// // // // //       final params = Uri.splitQueryString(uri.fragment);
// // // // //       final ref    = params['payment_ref'];

// // // // //       navigatorKey.currentState!.pushNamedAndRemoveUntil(
// // // // //         '/success',
// // // // //         (route) => false,   // remove everything (also the WebView)
// // // // //         arguments: ref,
// // // // //       );
// // // // //       return;
// // // // //     }

// // // // //     // ---------- FAILURE ----------
// // // // //     if (url.contains('#/fail')) {
// // // // //       navigatorKey.currentState!.pushNamedAndRemoveUntil(
// // // // //         '/fail',
// // // // //         (route) => false,
// // // // //       );
// // // // //     }
// // // // //   }
// // // // // }
// // // // //  WebViewScreen.dart  (or whatever you named the file)
// // // // import 'package:flutter/foundation.dart' show kIsWeb;
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // // // 👇 bring in the root navigatorKey from main.dart
// // // // import 'package:flutter_application_1/main.dart' show navigatorKey;

// // // // class WebViewScreen extends StatefulWidget {
// // // //   final String payUrl;
// // // //   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

// // // //   @override
// // // //   State<WebViewScreen> createState() => _WebViewScreenState();
// // // // }

// // // // class _WebViewScreenState extends State<WebViewScreen> {
// // // //   InAppWebViewController? _ctrl;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     // clear cookies on mobile so the gateway starts clean
// // // //     if (!kIsWeb) {
// // // //       CookieManager.instance().deleteAllCookies().catchError((_) {});
// // // //     }
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _ctrl?.clearCache();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: const Text('Payment')),
// // // //       body: InAppWebView(
// // // //         key: UniqueKey(),
// // // //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // // //         initialOptions: InAppWebViewGroupOptions(
// // // //           crossPlatform: InAppWebViewOptions(clearCache: true),
// // // //         ),
// // // //         onWebViewCreated: (c) => _ctrl = c,

// // // //         // ── hook EVERY navigation pathway ────────────────────────────
// // // //         onLoadStart:            (c, uri) => _maybeRedirect(uri),
// // // //         onLoadStop:             (c, uri) => _maybeRedirect(uri),
// // // //         onLoadResource:         (c, res) =>
// // // //             _maybeRedirect(Uri.parse(res.url as String)),
// // // //         onUpdateVisitedHistory: (c, uri, _) => _maybeRedirect(uri),
// // // //         shouldOverrideUrlLoading: (c, nav) async {
// // // //           _maybeRedirect(nav.request.url);
// // // //           return NavigationActionPolicy.ALLOW;
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   // ────────────────────────────────────────────────────────────────
// // // //   // 🔻  PLACE _maybeRedirect *inside* the _WebViewScreenState class  🔻
// // // //   void _maybeRedirect(Uri? uri) {
// // // //     if (uri == null) return;
// // // //     final url = uri.toString();
// // // //     debugPrint('[CHECK] $url');

// // // //     // -------- SUCCESS ----------
// // // //     if (url.contains('#/success')) {
// // // //       // Konnect puts params after the hash
// // // //       final ref = Uri.splitQueryString(uri.fragment)['payment_ref'];
// // // //       navigatorKey.currentState!.pushNamedAndRemoveUntil(
// // // //         '/success',
// // // //         (route) => false,
// // // //         arguments: ref,
// // // //       );
// // // //       return;                                   // stop further checks
// // // //     }

// // // //     // -------- FAILURE ----------
// // // //     if (url.contains('#/fail')) {
// // // //       navigatorKey.currentState!.pushNamedAndRemoveUntil(
// // // //         '/fail',
// // // //         (route) => false,
// // // //       );
// // // //     }
// // // //   }
// // // // }

// // // //  WebViewScreen.dart  (or whatever you named the file)
// // // import 'package:flutter/foundation.dart' show kIsWeb;
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // // 👇 bring in the root navigatorKey from main.dart
// // // import 'package:flutter_application_1/main.dart' show navigatorKey;

// // // class WebViewScreen extends StatefulWidget {
// // //   final String payUrl;
// // //   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

// // //   @override
// // //   State<WebViewScreen> createState() => _WebViewScreenState();
// // // }

// // // class _WebViewScreenState extends State<WebViewScreen> {
// // //   InAppWebViewController? _ctrl;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // clear cookies on mobile so the gateway starts clean
// // //     if (!kIsWeb) {
// // //       CookieManager.instance().deleteAllCookies().catchError((_) {});
// // //     }
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _ctrl?.clearCache();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text('Payment')),
// // //       body: InAppWebView(
// // //         key: UniqueKey(),
// // //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// // //         initialOptions: InAppWebViewGroupOptions(
// // //           crossPlatform: InAppWebViewOptions(clearCache: true),
// // //         ),
// // //         onWebViewCreated: (c) => _ctrl = c,

// // //         // ── hook EVERY navigation pathway ────────────────────────────
// // //         onLoadStart:            (c, uri) => _maybeRedirect(uri),
// // //         onLoadStop:             (c, uri) => _maybeRedirect(uri),
// // //         onLoadResource:         (c, res) =>
// // //             _maybeRedirect(Uri.parse(res.url as String)),
// // //         onUpdateVisitedHistory: (c, uri, _) => _maybeRedirect(uri),
// // //         shouldOverrideUrlLoading: (c, nav) async {
// // //           _maybeRedirect(nav.request.url);
// // //           return NavigationActionPolicy.ALLOW;
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   // ────────────────────────────────────────────────────────────────
// // //   // 🔻  PLACE _maybeRedirect *inside* the _WebViewScreenState class  🔻
// // //   void _maybeRedirect(Uri? uri) {
// // //     if (uri == null) return;
// // //     final url = uri.toString();
// // //     debugPrint('[CHECK] $url');

// // //     // -------- SUCCESS ----------
// // //     if (url.contains('#/success')) {
// // //       // Konnect puts params after the hash
// // //       final ref = Uri.splitQueryString(uri.fragment)['payment_ref'];
// // //       navigatorKey.currentState!.pushNamedAndRemoveUntil(
// // //         '/success',
// // //         (route) => false,
// // //         arguments: ref,
// // //       );
// // //       return;                                   // stop further checks
// // //     }

// // //     // -------- FAILURE ----------
// // //     if (url.contains('#/fail')) {
// // //       navigatorKey.currentState!.pushNamedAndRemoveUntil(
// // //         '/fail',
// // //         (route) => false,
// // //       );
// // //     }
// // //   }
// // // }

// // // webview_screen.dart
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // // Global root navigator key exported from main.dart
// // import 'package:flutter_application_1/main.dart' show navigatorKey;

// // class WebViewScreen extends StatefulWidget {
// //   final String payUrl;
// //   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

// //   @override
// //   State<WebViewScreen> createState() => _WebViewScreenState();
// // }

// // class _WebViewScreenState extends State<WebViewScreen> {
// //   InAppWebViewController? _ctrl;

// //   // ─────────────────────────────────────────── lifecycle
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Start with a clean cookie jar on mobile
// //     if (!kIsWeb) {
// //       CookieManager.instance().deleteAllCookies().catchError((_) {});
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     // Extra safety: blank the surface before disposing
// //     _ctrl?.loadUrl(urlRequest: URLRequest(url: WebUri('about:blank')));
// //     _ctrl?.clearCache();
// //     super.dispose();
// //   }

// //   // ─────────────────────────────────────────── UI
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // appBar: AppBar(title: const Text('Payment')),
// //       appBar: AppBar(
// //         title: const Text('Payment'),
// //         leading: IconButton(
// //           icon: const Icon(Icons.close),
// //           onPressed: () {
// //             // Optional: cancel and go home
// //             navigatorKey.currentState!
// //                 .pushNamedAndRemoveUntil('/home', (_) => false);
// //           },
// //         ),
// //       ),

// //       body: InAppWebView(
// //         key: UniqueKey(), // fresh instance
// //         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
// //         initialOptions: InAppWebViewGroupOptions(
// //           crossPlatform: InAppWebViewOptions(
// //             clearCache: true,
// //             javaScriptEnabled: true,
// //           ),
// //           android: AndroidInAppWebViewOptions(
// //             useHybridComposition: true, // <- crucial fix
// //           ),
// //         ),
// //         onWebViewCreated: (controller) => _ctrl = controller,

// //         // ── hook every navigation pathway ───────────────────────────
// //         onLoadStart: (c, uri) => _maybeRedirect(uri),
// //         onLoadStop: (c, uri) => _maybeRedirect(uri),
// //         onLoadResource: (c, res) =>
// //             _maybeRedirect(Uri.parse(res.url as String)),
// //         onUpdateVisitedHistory: (c, uri, _) => _maybeRedirect(uri), // hash nav
// //         shouldOverrideUrlLoading: (c, nav) async {
// //           _maybeRedirect(nav.request.url);
// //           return NavigationActionPolicy.ALLOW;
// //         },
// //       ),
// //     );
// //   }

// //   // ─────────────────────────────────────────── redirect logic
// //   void _maybeRedirect(Uri? uri) async {
// //     if (uri == null) return;

// //     final url = uri.toString();
// //     debugPrint('[WebView] check → $url');

// //     // ---------- SUCCESS ----------
// //     if (url.contains('#/success')) {
// //       final ref = Uri.splitQueryString(uri.fragment)['payment_ref'];

// //       // 1) blank the surface so it vanishes immediately
// //       await _ctrl?.loadUrl(
// //         urlRequest: URLRequest(url: WebUri('about:blank')),
// //       );

// //       // 2) push SuccessPaymentPage and clear the stack
// //       navigatorKey.currentState!.pushNamedAndRemoveUntil(
// //         '/success',
// //         (_) => false,
// //         arguments: ref,
// //       );
// //       return;
// //     }

// //     // ---------- FAILURE ----------
// //     if (url.contains('#/fail')) {
// //       await _ctrl?.loadUrl(
// //         urlRequest: URLRequest(url: WebUri('about:blank')),
// //       );
// //       navigatorKey.currentState!.pushNamedAndRemoveUntil('/fail', (_) => false);
// //     }
// //   }
// // }

// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // ↙ this must live in your main.dart
// import 'package:flutter_application_1/main.dart' show navigatorKey;

// class WebViewScreen extends StatefulWidget {
//   final String payUrl;
//   const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   InAppWebViewController? _ctrl;

//   @override
//   void initState() {
//     super.initState();
//     if (!kIsWeb) {
//       CookieManager.instance().deleteAllCookies().catchError((_) {});
//     }
//   }

//   @override
//   void dispose() {
//     _ctrl?.loadUrl(urlRequest: URLRequest(url: WebUri('about:blank')));
//     _ctrl?.clearCache();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment'),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             navigatorKey.currentState!
//                 .pushNamedAndRemoveUntil('/home', (_) => false);
//           },
//         ),
//       ),
//       body: InAppWebView(
//         key: UniqueKey(),
//         initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
//         initialOptions: InAppWebViewGroupOptions(
//           crossPlatform: InAppWebViewOptions(
//             clearCache: true,
//             javaScriptEnabled: true,
//           ),
//           android: AndroidInAppWebViewOptions(
//             useHybridComposition: true,
//           ),
//         ),
//         onWebViewCreated: (c) => _ctrl = c,
//         onLoadStart:           (c, uri) => _maybeRedirect(uri),
//         onLoadStop:            (c, uri) => _maybeRedirect(uri),
//         onLoadResource:        (c, res) => _maybeRedirect(Uri.parse(res.url as String)),
//         onUpdateVisitedHistory: (c, uri, _) => _maybeRedirect(uri),
//         shouldOverrideUrlLoading: (c, nav) async {
//           _maybeRedirect(nav.request.url);
//           return NavigationActionPolicy.ALLOW;
//         },
//       ),
//     );
//   }

//   Future<void> _maybeRedirect(Uri? uri) async {
//     if (uri == null) return;
//     final url = uri.toString();
//     debugPrint('[WebView] check → $url');

//     if (url.contains('#/success')) {
//       // extract your ref (or any other queryParams in uri.fragment)
//       final ref = Uri.splitQueryString(uri.fragment)['payment_ref'];

//       // blank out the WebView immediately
//       await _ctrl?.loadUrl(urlRequest: URLRequest(url: WebUri('about:blank')));

//       // then navigate
//       navigatorKey.currentState!
//           .pushNamedAndRemoveUntil('/success', (_) => false, arguments: ref);
//       return;
//     }

//     if (url.contains('#/fail')) {
//       await _ctrl?.loadUrl(urlRequest: URLRequest(url: WebUri('about:blank')));
//       navigatorKey.currentState!.pushNamedAndRemoveUntil('/fail', (_) => false);
//     }
//   }
// }

// web_view_screen.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_application_1/main.dart' show navigatorKey;

class WebViewScreen extends StatefulWidget {
  final String payUrl;
  const WebViewScreen({Key? key, required this.payUrl}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? _ctrl;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      CookieManager.instance().deleteAllCookies().catchError((_) {});
    }
  }

  @override
  void dispose() {
    // Don’t call any controller methods here; it is already disposed.
    _ctrl = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => navigatorKey.currentState!
              .pushNamedAndRemoveUntil('/home', (_) => false),
        ),
      ),
      body: InAppWebView(
        key: UniqueKey(),
        initialUrlRequest: URLRequest(url: WebUri(widget.payUrl)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            clearCache: true,
            javaScriptEnabled: true,
          ),
          android:  AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
        ),
        onWebViewCreated: (c) => _ctrl = c,

        // hook every navigation pathway
        onLoadStart:            (c, uri) => _maybeRedirect(uri),
        onLoadStop:             (c, uri) => _maybeRedirect(uri),
        onLoadResource:         (c, res) => _maybeRedirect(Uri.parse(res.url as String)),
        onUpdateVisitedHistory: (c, uri, _) => _maybeRedirect(uri),
        shouldOverrideUrlLoading: (c, nav) async {
          _maybeRedirect(nav.request.url);
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }

  /* ───────────── success / fail redirect ───────────── */
  Future<void> _maybeRedirect(Uri? uri) async {
    if (uri == null) return;
    final url = uri.toString();
    debugPrint('[WebView] check → $url');

    if (url.contains('#/success')) {
      final ref = Uri.splitQueryString(uri.fragment)['payment_ref'];
      await _ctrl?.loadUrl(
        urlRequest: URLRequest(url: WebUri('about:blank')),
      );
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil('/success', (_) => false, arguments: ref);
    }

    if (url.contains('#/fail')) {
      await _ctrl?.loadUrl(
        urlRequest: URLRequest(url: WebUri('about:blank')),
      );
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil('/fail', (_) => false);
    }
  }
}
