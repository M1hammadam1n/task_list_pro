// import 'package:flutter/material.dart';
// import 'package:maps_test/pages/task/task_page.dart';

// class TaskDetailPage extends StatefulWidget {
//   final TaskItemData task;

//   const TaskDetailPage({super.key, required this.task});

//   @override
//   State<TaskDetailPage> createState() => _TaskDetailPageState();
// }

// class _TaskDetailPageState extends State<TaskDetailPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool _expanded = true;

//   @override
//   void initState() {
//     super.initState();

//     _controller =
//         AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

//     _controller.forward(); // карточка сразу открыта
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _toggle() {
//     setState(() => _expanded = !_expanded);
//     _expanded ? _controller.forward() : _controller.reverse();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final task = widget.task;

//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A2F),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1A1A2F),
//         title: Text(task.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFF242443),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text(
//                   task.title,
//                   style: const TextStyle(
//                       color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   "Date: ${task.date}",
//                   style: const TextStyle(color: Colors.white70),
//                 ),
//                 trailing: Icon(
//                   _expanded ? Icons.expand_less : Icons.expand_more,
//                   color: Colors.white,
//                 ),
//                 onTap: _toggle,
//               ),

//               ClipRect(
//                 child: SizeTransition(
//                   sizeFactor: _animation,
//                   child: FadeTransition(
//                     opacity: _animation,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Description",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 10),
//                           const Text(
//                             "Это детальное описание задачи. "
//                             "Здесь вы можете указать детали, заметки, цели и дополнительную информацию.",
//                             style: TextStyle(color: Colors.white70, fontSize: 15),
//                           ),

//                           const SizedBox(height: 20),
//                           const Text(
//                             "Notes",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 10),
//                           const Text(
//                             "Заметка к задаче: всё проверить до дедлайна.",
//                             style: TextStyle(color: Colors.white70),
//                           ),

//                           const SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFF5F33E1),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                   child: const Text("Edit"),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.redAccent,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                   child: const Text("Delete"),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
