import 'package:flutter/material.dart';
import 'package:pos/screens/drawer_screen.dart';
import 'package:pos/screens/add_customer_screen.dart';
import 'package:pos/screens/items_screen.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Ticket'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
  icon: const Icon(Icons.notifications_none),
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new version of the App is available on the App Store'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );
  },
),

          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddCustomerScreen()),
              );
            },
          ),
          PopupMenuButton<String>(
  icon: const Icon(Icons.more_vert),
  onSelected: (String value) {
    if (value == 'clear') {
      // Handle Clear Ticket
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket cleared')),
      );
    } else if (value == 'sync') {
      // Handle Sync
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data synced')),
      );
    }
  },
  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
    const PopupMenuItem<String>(
      value: 'clear',
      child: Text('Clear Ticket'),
    ),
    const PopupMenuItem<String>(
      value: 'sync',
      child: Text('Sync'),
    ),
  ],
),

        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Text('CHARGE', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                Text('₹0.00',
                    style: TextStyle(
                        color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      hintText: 'All items',
                      border: InputBorder.none,
                    ),
                    value: 'All items',
                    items: <String>['All items', 'Item 1', 'Item 2'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                    dropdownColor: Colors.grey[800],
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ),
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have no items yet',
                      style: TextStyle(color: Colors.grey[500], fontSize: 18.0)),
                  const SizedBox(height: 8.0),
                  Text('Go to items menu to add an item',
                      style: TextStyle(color: Colors.grey[500])),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ItemsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    ),
                    child: const Text('GO TO ITEMS', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
