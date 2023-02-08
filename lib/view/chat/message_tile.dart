import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  final String time;

  const MessageTile({Key? key,
    required this.message,
    required this.sender,
    required this.sentByMe,
    required this.time})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: widget.sentByMe ? const EdgeInsets.only(right: 25, top: 5) : const EdgeInsets.only(left: 25, top: 5),
            child: Text(
              widget.sender.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: 4,
              left: widget.sentByMe ? 0 : 24,
              right: widget.sentByMe ? 24 : 0),
          child: Row(
            mainAxisAlignment:
            widget.sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              widget.sentByMe
                  ? Container(
                margin: const EdgeInsets.only(left: 50, top: 45),
                child: Text(
                  widget.time.substring(0, widget.time.length - 3),
                ),
              )
                  : Container(),
              Flexible(
                child: Container(
                  margin: widget.sentByMe
                      ? const EdgeInsets.only(left: 5)
                      : const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: widget.sentByMe
                          ? const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                      )
                          : const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                      color:
                      widget.sentByMe ? Colors.blueAccent : Colors.grey[700]),
                  child: Column(
                    crossAxisAlignment: widget.sentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.message,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),

              widget.sentByMe
                  ? Container()
                  : Container(
                margin: const EdgeInsets.only(right: 25, top: 45),
                child: Text(
                  widget.time.substring(0, widget.time.length - 3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
