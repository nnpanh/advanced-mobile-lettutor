import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/view/courses/widgets/course_tab.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'All courses', icon: Icon(Icons.history_edu)),
    Tab(text: 'Ebook', icon: Icon(FontAwesomeIcons.bookOpen)),
  ];

  late TabController _tabController;
  late bool isSearching;
  final TextEditingController _txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSearching = false;
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching ? buildSearchField() : const Text('Online Courses'),
        // automaticallyImplyLeading: isSearching ? false : true,
        leading: isSearching
            ? IconButton(
                icon: const Icon(Icons.search_off),
                onPressed: () {
                  onSearch(context);
                },
              )
            : const BackButton(),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.blue, Colors.lightBlueAccent]),
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          indicatorColor: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isSearching ? Icons.cancel : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              if (isSearching) {
                _txtController.clear();
              } else {
                onSearch(context);
              }
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return Center(child: CourseTab(tabType: label));
        }).toList(),
      ),
    );
  }

  void onSearch(BuildContext context) {
    setState(() {
      isSearching = !isSearching;
    });
  }

  TextField buildSearchField() {
    return TextField(
      controller: _txtController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Input course name...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) {},
    );
  }
}
