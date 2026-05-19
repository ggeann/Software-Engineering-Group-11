import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

enum PrimaryGoal { loseWeight, stayFit, buildMuscle }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PrimaryGoal? _option = PrimaryGoal.buildMuscle;
  int liter = 0;
  int steps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text('LifeTrack'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_pin),
            iconSize: 40,
          ),
        ],
      ),
      body: ListView(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              "https://plus.unsplash.com/premium_vector-1682269287900-d96e9a6c188b?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "John Doe",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          RadioGroup<PrimaryGoal>(
            groupValue: _option,
            onChanged: (PrimaryGoal? value) {
              setState(() {
                _option = value;
              });
            },
            child: Column(
              children: const [
                RadioListTile<PrimaryGoal>(
                  title: Text("Lose Weight"),
                  subtitle: Text("Sustainable fat loss focus"),
                  value: PrimaryGoal.loseWeight,
                ),
                RadioListTile<PrimaryGoal>(
                  title: Text("Stay Fit"),
                  subtitle: Text("Maintain current health levels"),
                  value: PrimaryGoal.stayFit,
                ),
                RadioListTile<PrimaryGoal>(
                  title: Text("Lose Build Muscle"),
                  subtitle: Text("Strength & hyperthrophy"),
                  value: PrimaryGoal.buildMuscle,
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: const [
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Age",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Height (cm)",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Weight (kg)",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Slider(
                label: liter.toDouble().toString(),
                value: liter.toDouble(),
                onChanged: (value) {
                  setState(() {
                    liter = value.toInt();
                  });
                },
                min: 0,
                max: 6,
              ),
              SizedBox(height: 30),
              Slider(
                label: steps.toDouble().toString(),
                value: steps.toDouble(),
                onChanged: (value) {
                  setState(() {
                    steps = value.toInt();
                  });
                },
                min: 0,
                max: 6,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(CupertinoIcons.square_split_2x2_fill),
          ),
          BottomNavigationBarItem(
            label: "Food",
            icon: Icon(CupertinoIcons.largecircle_fill_circle),
          ),
          BottomNavigationBarItem(
            label: "Activity",
            icon: Icon(CupertinoIcons.brightness),
          ),
          BottomNavigationBarItem(
            label: "Progress",
            icon: Icon(CupertinoIcons.chart_bar_alt_fill),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(CupertinoIcons.person_fill),
          ),
        ],
      ),
    );
  }
}
