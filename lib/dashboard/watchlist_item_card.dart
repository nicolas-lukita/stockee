import 'package:flutter/material.dart';
import 'package:stockee/details_page/details_screen.dart';

class WatchlistItemCard extends StatefulWidget {
  const WatchlistItemCard({Key? key, required this.isFollowed})
      : super(key: key);
  final bool isFollowed;

  @override
  State<WatchlistItemCard> createState() => _WatchlistItemCardState();
}

class _WatchlistItemCardState extends State<WatchlistItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => const DetailsScreen(
                      isFollowed: true,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 5,
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(
                        (widget.isFollowed ? Icons.star : Icons.star_border),
                        size: 35,
                      ),
                      color: Colors.amber,
                    )
                  : const SizedBox(
                      width: 10,
                    ),
              const SizedBox(
                width: 5,
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? const CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 25,
                    )
                  : const SizedBox(),
              const SizedBox(
                width: 10,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Titleasdfasdfasdfasdf',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    FittedBox(fit: BoxFit.scaleDown, child: Text('+\$6969'))
                  ],
                ),
              ),
              const Spacer(),
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '\$999.00',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
        ),
      ),
    );
  }
}
