// // // import 'dart:async';
// // // import 'dart:convert';
// // // import 'package:gradient_icon/gradient_icon.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:flutter/material.dart';

// // // class ChatScreen extends StatefulWidget {
// // //   const ChatScreen({super.key});

// // //   @override
// // //   State<ChatScreen> createState() => _ChatScreenState();
// // // }

// // // class _ChatScreenState extends State<ChatScreen> {
// // //   final TextEditingController _controller = TextEditingController();
// // //   List<Map<String, String>> chatMessages = [];
// // //   bool _isLoading = false;

// // //   Future<void> query(String prompt) async {
// // //     if (prompt.trim().isEmpty) return;

// // //     setState(() {
// // //       chatMessages.add({"role": "user", "content": prompt});
// // //       _isLoading = true;
// // //     });

// // //     final url = 'http://10.0.2.2:11434/api/generate';

// // //     try {
// // //       final data = {
// // //         "model": "llama3.2:latest",
// // //         "prompt": prompt,
// // //         "stream": false,
// // //       };

// // //       final response = await http.post(
// // //         Uri.parse(url),
// // //         headers: {"Content-Type": "application/json"},
// // //         body: json.encode(data),
// // //       ).timeout(
// // //         const Duration(seconds: 60),
// // //         onTimeout: () => throw TimeoutException('Connection timeout'),
// // //       );

// // //       if (response.statusCode == 200) {
// // //         final responseData = json.decode(response.body);
        
// // //         if (responseData != null && responseData["response"] != null) {
// // //           setState(() {
// // //             chatMessages.add({"role": "assistant", "content": responseData["response"]});
// // //           });
// // //         }
// // //       } else {
// // //         throw Exception('Failed to get response');
// // //       }
// // //     } catch (e) {
// // //       debugPrint('Error connecting to Ollama: $e');

// // //       setState(() {
// // //         chatMessages.add({
// // //           "role": "system",
// // //           "content": "Failed to connect to Ollama server. Error: $e",
// // //         });
// // //       });

      
// // //     } finally {
// // //       setState(() {
// // //         _isLoading = false;
// // //       });
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title:Row(
// // //           crossAxisAlignment: CrossAxisAlignment.center,
// // //           children: [
// // //              Text(
// // //           "Ask Chat",
// // //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
// // //         ),
// // //         SizedBox(width: 10),
// // //         Container(
// // //               padding: EdgeInsets.only(bottom:8), // Ajuste l'alignement vertical
// // //               child: GradientIcon(
// // //                 icon: Icons.chat,
// // //                 gradient: LinearGradient(
// // //                   colors: [
// // //                     const Color.fromARGB(255, 255, 255, 255),
// // //                     Colors.blue,
// // //                   ],
// // //                 ),
// // //                 size: 27,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //       body: SafeArea(
// // //         child: Container(
// // //           color: const Color.fromARGB(209, 216, 246, 255), // Fond blanc
// // //           child: Column(
// // //             children: [
// // //               Expanded(
// // //                 child: ListView.builder(
// // //                   itemCount: chatMessages.length,
// // //                   itemBuilder: (context, index) {
// // //                     final message = chatMessages[index];
// // //                     return Align(
// // //                       alignment: message["role"] == 'assistant'
// // //                           ? Alignment.centerLeft // L'assistant à gauche
// // //                           : Alignment.centerRight, // L'utilisateur à droite
// // //                       child: Container(
// // //                         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // //                         padding: EdgeInsets.all(12),
// // //                         decoration: BoxDecoration(
// // //                           color: message["role"] == 'assistant'
// // //                               ? const Color.fromARGB(255, 175, 219, 255) // Bleu clair pour l'assistant
// // //                               : Colors.blue[600], // Bleu plus foncé pour l'utilisateur
// // //                           borderRadius: BorderRadius.circular(12),
// // //                         ),
// // //                         child: Text(
// // //                           message["content"] ?? '',
// // //                           style: TextStyle(
// // //                             color: message["role"] == 'assistant' ? Colors.black : Colors.white, // Texte noir pour l'assistant, blanc pour l'utilisateur
// // //                             fontSize: 16,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //               if (_isLoading)
// // //                 Padding(
// // //                   padding: const EdgeInsets.all(8.0),
// // //                   child: CircularProgressIndicator(),
// // //                 ),
// // //               Padding(
// // //                 padding: const EdgeInsets.all(16.0),
// // //                 child: TextField(
// // //                   controller: _controller,
// // //                   style: TextStyle(color: Colors.black), // Texte en noir pour la saisie
// // //                   decoration: InputDecoration(
// // //                     labelText: "Enter your prompt",
// // //                     labelStyle: TextStyle(color: Colors.blueAccent), // Bleu pour le label
// // //                     border: OutlineInputBorder(
// // //                       borderRadius: BorderRadius.circular(12),
// // //                       borderSide: BorderSide(color: Colors.blueAccent),
// // //                     ),
// // //                     suffixIcon: IconButton(
// // //                       onPressed: _isLoading
// // //                           ? null
// // //                           : () {
// // //                               query(_controller.text);
// // //                               _controller.clear(); // Vide le champ de texte après l'envoi
// // //                             },
// // //                       icon: Icon(
// // //                         Icons.send,
// // //                         color: _isLoading ? Colors.grey : Colors.blueAccent, // Bleu pour l'icône d'envoi
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter_markdown/flutter_markdown.dart';

// // class ChatScreen extends StatefulWidget {
// //   const ChatScreen({super.key});

// //   @override
// //   State<ChatScreen> createState() => _ChatScreenState();
// // }

// // class _ChatScreenState extends State<ChatScreen> {
// //   final TextEditingController _controller = TextEditingController();
// //   final ScrollController _scrollController = ScrollController();
// //   List<Map<String, dynamic>> chatMessages = [];
// //   bool _isLoading = false;
// //   bool _isTyping = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _addWelcomeMessage();
// //   }

// //   void _addWelcomeMessage() {
// //     // Add a welcome message when the chat starts
// //     setState(() {
// //       chatMessages.add({
// //         "role": "assistant",
// //         "content": "👋 Welcome to FreelanceAI Assistant! How can I help with your freelance business today? Ask me about client management, proposals, contracts, or anything else!",
// //         "timestamp": DateTime.now()
// //       });
// //     });
// //   }

// //   void _scrollToBottom() {
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       if (_scrollController.hasClients) {
// //         _scrollController.animateTo(
// //           _scrollController.position.maxScrollExtent,
// //           duration: const Duration(milliseconds: 300),
// //           curve: Curves.easeOut,
// //         );
// //       }
// //     });
// //   }

// //   Future<void> query(String prompt) async {
// //     if (prompt.trim().isEmpty) return;

// //     setState(() {
// //       chatMessages.add({
// //         "role": "user", 
// //         "content": prompt,
// //         "timestamp": DateTime.now()
// //       });
// //       _isLoading = true;
// //       _isTyping = true;
// //     });
    
// //     _scrollToBottom();

// //     final url = 'http://10.0.2.2:11434/api/generate';

// //     try {
// //       final data = {
// //         "model": "llama3.2:latest",
// //         "prompt": prompt,
// //         "stream": false,
// //       };

// //       final response = await http.post(
// //         Uri.parse(url),
// //         headers: {"Content-Type": "application/json"},
// //         body: json.encode(data),
// //       ).timeout(
// //         const Duration(seconds: 60),
// //         onTimeout: () => throw TimeoutException('Connection timeout'),
// //       );

// //       if (response.statusCode == 200) {
// //         final responseData = json.decode(response.body);
        
// //         if (responseData != null && responseData["response"] != null) {
// //           // Simulate typing effect
// //           await Future.delayed(const Duration(milliseconds: 300));
          
// //           setState(() {
// //             chatMessages.add({
// //               "role": "assistant", 
// //               "content": responseData["response"],
// //               "timestamp": DateTime.now()
// //             });
// //             _isTyping = false;
// //           });
          
// //           _scrollToBottom();
// //         }
// //       } else {
// //         throw Exception('Failed to get response');
// //       }
// //     } catch (e) {
// //       debugPrint('Error connecting to Ollama: $e');

// //       setState(() {
// //         chatMessages.add({
// //           "role": "system",
// //           "content": "Unable to connect to the AI server. Please check your connection and try again.",
// //           "timestamp": DateTime.now(),
// //           "isError": true,
// //         });
// //         _isTyping = false;
// //       });
      
// //       _scrollToBottom();
// //     } finally {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }

// //   String _getTimeString(DateTime timestamp) {
// //     return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         elevation: 0,
// //         backgroundColor: Colors.white,
// //         centerTitle: false,
// //         title: Row(
// //           children: [
// //             Container(
// //               height: 40,
// //               width: 40,
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [Colors.blue.shade500, Colors.blue.shade700],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Center(
// //                 child: Icon(
// //                   Icons.assistant_rounded,
// //                   color: Colors.white,
// //                   size: 24,
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(width: 12),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "FreelanceAI Assistant",
// //                   style: GoogleFonts.poppins(
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 16,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 Text(
// //                   "Your freelance business companion",
// //                   style: GoogleFonts.poppins(
// //                     fontWeight: FontWeight.w400,
// //                     fontSize: 12,
// //                     color: Colors.black54,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.more_vert, color: Colors.black54),
// //             onPressed: () {
// //               // Show options menu
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Container(
// //         decoration: BoxDecoration(
// //           color: Colors.grey[50],
// //         ),
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: ListView.builder(
// //                 controller: _scrollController,
// //                 padding: const EdgeInsets.all(16),
// //                 itemCount: chatMessages.length + (_isTyping ? 1 : 0),
// //                 itemBuilder: (context, index) {
// //                   // Show typing indicator
// //                   if (_isTyping && index == chatMessages.length) {
// //                     return _buildTypingIndicator();
// //                   }
                  
// //                   final message = chatMessages[index];
// //                   final bool isUser = message["role"] == 'user';
// //                   final bool isError = message["isError"] == true;
                  
// //                   return _buildMessageBubble(message, isUser, isError);
// //                 },
// //               ),
// //             ),
// //             _buildInputArea(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildTypingIndicator() {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: Container(
// //         margin: const EdgeInsets.only(top: 8, bottom: 8, right: 80),
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(20),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.blue.withOpacity(0.1),
// //               blurRadius: 5,
// //               offset: const Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Container(
// //               height: 10,
// //               width: 10,
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade300,
// //                 borderRadius: BorderRadius.circular(5),
// //               ),
// //             ),
// //             const SizedBox(width: 5),
// //             Container(
// //               height: 10,
// //               width: 10,
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade500,
// //                 borderRadius: BorderRadius.circular(5),
// //               ),
// //             ),
// //             const SizedBox(width: 5),
// //             Container(
// //               height: 10,
// //               width: 10,
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade700,
// //                 borderRadius: BorderRadius.circular(5),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildMessageBubble(Map<String, dynamic> message, bool isUser, bool isError) {
// //     final DateTime timestamp = message["timestamp"] ?? DateTime.now();
// //     final String timeString = _getTimeString(timestamp);
    
// //     return Align(
// //       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
// //       child: Container(
// //         constraints: BoxConstraints(
// //           maxWidth: MediaQuery.of(context).size.width * 0.75,
// //         ),
// //         margin: EdgeInsets.only(
// //           top: 8,
// //           bottom: 8,
// //           left: isUser ? 80 : 0,
// //           right: isUser ? 0 : 80,
// //         ),
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //         decoration: BoxDecoration(
// //           color: isError 
// //               ? Colors.red.shade50 
// //               : isUser 
// //                   ? Colors.blue.shade600 
// //                   : Colors.white,
// //           borderRadius: BorderRadius.circular(20),
// //           boxShadow: [
// //             BoxShadow(
// //               color: isError 
// //                   ? Colors.red.withOpacity(0.1) 
// //                   : isUser 
// //                       ? Colors.blue.withOpacity(0.2) 
// //                       : Colors.blue.withOpacity(0.1),
// //               blurRadius: 5,
// //               offset: const Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             SelectableText(
// //               message["content"] ?? '',
// //               style: GoogleFonts.inter(
// //                 color: isError 
// //                     ? Colors.red.shade800 
// //                     : isUser 
// //                         ? Colors.white 
// //                         : Colors.black87,
// //                 fontSize: 15,
// //                 height: 1.4,
// //               ),
// //             ),
// //             const SizedBox(height: 4),
// //             Text(
// //               timeString,
// //               style: TextStyle(
// //                 color: isUser ? Colors.white70 : Colors.black38,
// //                 fontSize: 10,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInputArea() {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.1),
// //             blurRadius: 10,
// //             offset: const Offset(0, -2),
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.grey[100],
// //                 borderRadius: BorderRadius.circular(24),
// //               ),
// //               child: TextField(
// //                 controller: _controller,
// //                 maxLines: null,
// //                 textCapitalization: TextCapitalization.sentences,
// //                 style: GoogleFonts.inter(
// //                   color: Colors.black87,
// //                   fontSize: 16,
// //                 ),
// //                 decoration: InputDecoration(
// //                   hintText: "Ask me anything about freelancing...",
// //                   hintStyle: GoogleFonts.inter(
// //                     color: Colors.black38,
// //                     fontSize: 16,
// //                   ),
// //                   border: InputBorder.none,
// //                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //                   suffixIcon: _isLoading 
// //                       ? Container(
// //                           width: 24,
// //                           height: 24,
// //                           margin: const EdgeInsets.all(12),
// //                           child: CircularProgressIndicator(
// //                             strokeWidth: 2,
// //                             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade500),
// //                           ),
// //                         )
// //                       : null,
// //                 ),
// //                 onSubmitted: _isLoading ? null : (text) => query(text),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(width: 8),
// //           Container(
// //             width: 48,
// //             height: 48,
// //             decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [Colors.blue.shade500, Colors.blue.shade700],
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //               ),
// //               borderRadius: BorderRadius.circular(24),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.blue.withOpacity(0.3),
// //                   blurRadius: 8,
// //                   offset: const Offset(0, 4),
// //                 ),
// //               ],
// //             ),
// //             child: IconButton(
// //               icon: const Icon(Icons.send_rounded, color: Colors.white),
// //               onPressed: _isLoading
// //                   ? null
// //                   : () {
// //                       query(_controller.text);
// //                       _controller.clear();
// //                     },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   List<Map<String, dynamic>> chatMessages = [];
//   bool _isLoading = false;
//   bool _isTyping = false;

//   @override
//   void initState() {
//     super.initState();
//     _addWelcomeMessage();
//   }

//   void _addWelcomeMessage() {
//     setState(() {
//       chatMessages.add({
//         "role": "assistant",
//         "content":
//             "👋 Welcome to FreelanceAI Assistant! How can I help with your freelance business today?",
//         "timestamp": DateTime.now()
//       });
//     });
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   Future<void> query(String prompt) async {
//     if (prompt.trim().isEmpty) return;

//     setState(() {
//       chatMessages.add({
//         "role": "user",
//         "content": prompt,
//         "timestamp": DateTime.now()
//       });
//       _isLoading = true;
//       _isTyping = true;
//     });

//     _scrollToBottom();

//     final url = 'http://10.0.2.2:11434/api/generate';

//     try {
//       final data = {
//         "model": "llama3.2:latest",
//         "prompt": prompt,
//         "stream": false,
//       };

//       final response = await http
//           .post(
//             Uri.parse(url),
//             headers: {"Content-Type": "application/json"},
//             body: json.encode(data),
//           )
//           .timeout(const Duration(seconds: 60));

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         if (responseData["response"] != null) {
//           await Future.delayed(const Duration(milliseconds: 300));
//           setState(() {
//             chatMessages.add({
//               "role": "assistant",
//               "content": responseData["response"],
//               "timestamp": DateTime.now()
//             });
//             _isTyping = false;
//           });
//           _scrollToBottom();
//         }
//       } else {
//         throw Exception('Failed to get response');
//       }
//     } catch (e) {
//       setState(() {
//         chatMessages.add({
//           "role": "system",
//           "content":
//               "❌ Unable to connect to the AI server. Please try again later.",
//           "timestamp": DateTime.now(),
//           "isError": true,
//         });
//         _isTyping = false;
//       });
//       _scrollToBottom();
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   String _getTimeString(DateTime timestamp) {
//     return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.blue.shade600,
//                 child: const Icon(Icons.assistant, color: Colors.white),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "FreelanceAI Assistant",
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                           color: Colors.black87),
//                     ),
//                     Text(
//                       "Your freelance business companion",
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12,
//                           color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 controller: _scrollController,
//                 padding: const EdgeInsets.all(16),
//                 itemCount: chatMessages.length + (_isTyping ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (_isTyping && index == chatMessages.length) {
//                     return _buildTypingIndicator();
//                   }
//                   final message = chatMessages[index];
//                   final isUser = message["role"] == 'user';
//                   final isError = message["isError"] == true;
//                   return _buildMessageBubble(message, isUser, isError);
//                 },
//               ),
//             ),
//             _buildInputArea(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTypingIndicator() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blue.withOpacity(0.1),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: const Text("Typing..."),
//       ),
//     );
//   }

//   Widget _buildMessageBubble(
//       Map<String, dynamic> message, bool isUser, bool isError) {
//     final DateTime timestamp = message["timestamp"] ?? DateTime.now();
//     final String timeString = _getTimeString(timestamp);

//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.only(
//           top: 8,
//           bottom: 8,
//           left: isUser ? 60 : 16,
//           right: isUser ? 16 : 60,
//         ),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isError
//               ? Colors.red.shade100
//               : isUser
//                   ? Colors.blue.shade600
//                   : Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SelectableText(
//               message["content"] ?? '',
//               style: TextStyle(
//                 color: isError
//                     ? Colors.red.shade800
//                     : isUser
//                         ? Colors.white
//                         : Colors.black87,
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Text(
//                 timeString,
//                 style: TextStyle(
//                   color: isUser ? Colors.white70 : Colors.black38,
//                   fontSize: 10,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputArea() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: TextField(
//                 controller: _controller,
//                 maxLines: null,
//                 textCapitalization: TextCapitalization.sentences,
//                 decoration: const InputDecoration.collapsed(
//                   hintText: "Type your message...",
//                 ),
//                 onSubmitted: _isLoading ? null : (text) => query(text),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           GestureDetector(
//             onTap: _isLoading
//                 ? null
//                 : () {
//                     query(_controller.text);
//                     _controller.clear();
//                   },
//             child: Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [Colors.blue.shade400, Colors.blue.shade700],
//                 ),
//               ),
//               child: _isLoading
//                   ? Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor:
//                             AlwaysStoppedAnimation<Color>(Colors.white),
//                       ),
//                     )
//                   : const Icon(Icons.send_rounded, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> chatMessages = [];
  bool _isLoading = false;
  bool _isTyping = false;
  late AnimationController _sendButtonController;
  bool _isInputEmpty = true;

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
    _sendButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.addListener(_onTextChanged);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void dispose() {
    _sendButtonController.dispose();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final isEmpty = _controller.text.trim().isEmpty;
    if (isEmpty != _isInputEmpty) {
      setState(() {
        _isInputEmpty = isEmpty;
      });
    }
  }

  void _addWelcomeMessage() {
    setState(() {
      chatMessages.add({
        "role": "assistant",
        "content":
            "👋 Welcome to FreelanceAI Assistant! How can I help with your freelance business today?",
        "timestamp": DateTime.now()
      });
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> query(String prompt) async {
    if (prompt.trim().isEmpty) return;

    setState(() {
      chatMessages.add({
        "role": "user",
        "content": prompt,
        "timestamp": DateTime.now()
      });
      _isLoading = true;
      _isTyping = true;
    });

    _scrollToBottom();

    final url = 'http://10.0.2.2:11434/api/generate';

    try {
      final data = {
        "model": "llama3.2:latest",
        "prompt": prompt,
        "stream": false,
      };

      final response = await http
          .post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: json.encode(data),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData["response"] != null) {
          await Future.delayed(const Duration(milliseconds: 300));
          setState(() {
            chatMessages.add({
              "role": "assistant",
              "content": responseData["response"],
              "timestamp": DateTime.now()
            });
            _isTyping = false;
          });
          _scrollToBottom();
        }
      } else {
        throw Exception('Failed to get response');
      }
    } catch (e) {
      setState(() {
        chatMessages.add({
          "role": "system",
          "content":
              "❌ Unable to connect to the AI server. Please try again later.",
          "timestamp": DateTime.now(),
          "isError": true,
        });
        _isTyping = false;
      });
      _scrollToBottom();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getTimeString(DateTime timestamp) {
    return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        appBar: _buildAppBar(),
        body: Column(
          children: [
            Expanded(
              child: _buildChatList(),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      leadingWidth: 0,
      centerTitle: false,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade500, Colors.blue.shade700],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.assistant_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FreelanceAI Assistant",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                Text(
                  "Your freelance business companion",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey.shade700),
            onPressed: () {
              // Menu options here
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: chatMessages.length + (_isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (_isTyping && index == chatMessages.length) {
          return _buildTypingIndicator();
        }
        final message = chatMessages[index];
        final isUser = message["role"] == 'user';
        final isError = message["isError"] == true;
        return _buildMessageBubble(message, isUser, isError);
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, right: 80),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPulsingDot(0),
              _buildPulsingDot(1),
              _buildPulsingDot(2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPulsingDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.5, end: 1.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: value,
              child: child,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageBubble(
      Map<String, dynamic> message, bool isUser, bool isError) {
    final DateTime timestamp = message["timestamp"] ?? DateTime.now();
    final String timeString = _getTimeString(timestamp);
    final content = message["content"] ?? '';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isUser ? 80 : 0,
          right: isUser ? 0 : 80,
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isError
                    ? Colors.red.shade50
                    : isUser
                        ? Colors.blue.shade600
                        : Colors.white,
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomRight: isUser ? const Radius.circular(0) : null,
                  bottomLeft: !isUser ? const Radius.circular(0) : null,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: SelectableText(
                content,
                style: GoogleFonts.inter(
                  color: isError
                      ? Colors.red.shade800
                      : isUser
                          ? Colors.white
                          : Colors.black87,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
              child: Text(
                timeString,
                style: GoogleFonts.inter(
                  color: Colors.black38,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 120,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.3,
                ),
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  hintStyle: GoogleFonts.inter(
                    color: Colors.black38,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                ),
                onSubmitted: _isLoading ? null : (text) {
                  if (!_isInputEmpty) {
                    query(text);
                    _controller.clear();
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: (_isLoading || _isInputEmpty)
                ? null
                : () {
                    query(_controller.text);
                    _controller.clear();
                    _focusNode.requestFocus();
                  },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isLoading || _isInputEmpty
                      ? [Colors.grey.shade300, Colors.grey.shade400]
                      : [Colors.blue.shade400, Colors.blue.shade700],
                ),
                boxShadow: _isLoading || _isInputEmpty
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: _isLoading
                  ? Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    )
                  : Icon(
                      Icons.send_rounded,
                      color: _isInputEmpty ? Colors.grey.shade500 : Colors.white,
                      size: 22,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}