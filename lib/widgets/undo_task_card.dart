// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todist/Bloc/task/task_bloc.dart';
// import 'package:todist/Widgets/bottom_sheet.dart';
// import 'package:todist/model/task_model.dart';

// class UndoTaskCard extends StatefulWidget {
//   final Task task;
//   final int? index;

//   const UndoTaskCard({Key? key, required this.task, this.index})
//       : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _UndoTaskCardState createState() => _UndoTaskCardState();
// }

// class _UndoTaskCardState extends State<UndoTaskCard> {
//   bool deleteVisible = false;
//   int swipeCounter = 0;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onHorizontalDragUpdate: (details) {
//         print('swipe value $swipeCounter');

//         if (details.primaryDelta! > 0) {
//           setState(() {
//             swipeCounter++;
//             deleteVisible = swipeCounter >= 20;
//           });
//         }
//       },
//       onTap: () {
//         if (deleteVisible) {
//           BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(widget.task));
//         } else {
//           showModalBottomSheet(
//             isScrollControlled: true,
//             context: context,
//             builder: (BuildContext context) {
//               return CustomBottomSheet(
//                 task: widget.task,
//               );
//             },
//           );
//         }
//       },
//       child: Dismissible(
//         key: UniqueKey(),
//         direction: DismissDirection.horizontal,
//         crossAxisEndOffset: 0.0,
//         onDismissed: (crossAxisEndOffset) {
//           setState(() {});
//         },
//         background: Container(
//           color: Colors.green,
//           alignment: Alignment.centerLeft,
//           padding: const EdgeInsets.only(left: 20.0),
//           child: const Row(
//             children: [
//               Text(
//                 'Undo Task',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Icon(Icons.check, color: Colors.white),
//             ],
//           ),
//         ),
//         secondaryBackground: Container(
//           color: Colors.red,
//           alignment: Alignment.centerRight,
//           padding: const EdgeInsets.only(right: 20.0),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Delete',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Icon(Icons.delete, color: Colors.white),
//             ],
//           ),
//         ),
//         confirmDismiss: (direction) async {
//           print('Direction of swipe: $direction');
//           print("SWIPE VALUE ${direction.index}");

//           return deleteVisible;
//         },
//         child: Card(
//           child: ListTile(
//             title: Text(
//               widget.task.title,
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//             subtitle: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Text(
//                     widget.task.description,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   '${widget.task.date.day} - ${widget.task.date.month} - ${widget.task.date.year}',
//                   style: const TextStyle(fontSize: 10),
//                 ),
//               ],
//             ),
//             trailing: IconButton(
//               icon: widget.task.completed
//                   ? const Icon(
//                       Icons.check_circle,
//                       color: Colors.green,
//                     )
//                   : const Icon(
//                       Icons.radio_button_unchecked,
//                       color: Colors.red,
//                     ),
//               onPressed: () {
//                 if (widget.task.completed) {
//                   BlocProvider.of<TaskBloc>(context)
//                       .add(UndoTaskEvent(widget.task));
//                 } else {
//                   BlocProvider.of<TaskBloc>(context)
//                       .add(CompleteTaskEvent(widget.task));
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:todist/Bloc/task/task_bloc.dart';
import 'package:todist/Widgets/bottom_sheet.dart';
import 'package:todist/model/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UndoTaskCard extends StatefulWidget {
  final Task task;
  final int? index;

  const UndoTaskCard({Key? key, required this.task, this.index})
      : super(key: key);

  @override
  _UndoTaskCardState createState() => _UndoTaskCardState();
}

class _UndoTaskCardState extends State<UndoTaskCard> {
  bool deleteVisible = false;
  double swipeCounter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          swipeCounter +=
              details.primaryDelta! / MediaQuery.of(context).size.width;
        });
      },
      onTap: () {
        if (deleteVisible) {
          BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(widget.task));
        } else {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return CustomBottomSheet(
                task: widget.task,
              );
            },
          );
        }
      },
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            BlocProvider.of<TaskBloc>(context).add(UndoTaskEvent(widget.task));
          }),
          children: [
            SlidableAction(
              onPressed: (context) {
                BlocProvider.of<TaskBloc>(context)
                    .add(UndoTaskEvent(widget.task));
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.undo,
              label: 'Undo',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            BlocProvider.of<TaskBloc>(context)
                .add(DeleteTaskEvent(widget.task));
          }),
          children: [
            SlidableAction(
              onPressed: (Context) {
                BlocProvider.of<TaskBloc>(context)
                    .add(DeleteTaskEvent(widget.task));
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          child: ListTile(
            title: Text(
              widget.task.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.task.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${widget.task.date.day} - ${widget.task.date.month} - ${widget.task.date.year}',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            trailing: IconButton(
              icon: widget.task.completed
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.radio_button_unchecked,
                      color: Colors.red,
                    ),
              onPressed: () {
                if (widget.task.completed) {
                  BlocProvider.of<TaskBloc>(context)
                      .add(UndoTaskEvent(widget.task));
                } else {
                  BlocProvider.of<TaskBloc>(context)
                      .add(CompleteTaskEvent(widget.task));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
