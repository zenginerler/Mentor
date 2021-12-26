import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({Key? key}) : super(key: key);

  _navigateAndPopup(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const AddEventPopupCard();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 250),
        maintainState: true,
        barrierColor: Colors.black54,
        barrierLabel: 'Popup dialog open',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      child: GestureDetector(
        onTap: () => _navigateAndPopup(context),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(36),
            ),
            child: const Icon(
              Icons.add_rounded,
              size: 36,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Popup card for new event creation
class AddEventPopupCard extends StatefulWidget {
  const AddEventPopupCard({Key? key}) : super(key: key);

  @override
  State<AddEventPopupCard> createState() => _AddEventPopupCardState();
}

class _AddEventPopupCardState extends State<AddEventPopupCard> {
  CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  String? event;
  String? note;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'New event',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 5.0,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      event = value;
                    },
                  ),
                  const Divider(
                    thickness: 0.2,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a note (optional)',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 5.0,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    cursorColor: Colors.white,
                    maxLines: 6,
                    onChanged: (value) {
                      note = value;
                    },
                  ),
                  const Divider(thickness: 0.2),
                  GestureDetector(
                    onTap: () {
                      if (event != null) {
                        eventsCollection.add({
                          'event': event,
                          'note': note ?? "",
                        }).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: const Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
