import 'package:flutter/material.dart';

void main() => runApp(SailApp());

class SailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAIL',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: Scaffold(
        body: Container(
          width: double.infinity, // Container'ı genişlet
          height: double.infinity, // Container'ı genişlet
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.4, 0.6, 0.9],
              colors: [
                Colors.blue.shade800,
                Colors.blue.shade600,
                Colors.blue.shade400,
                Colors.blue.shade200,
              ],
            ),
          ),
          child: LoginPage(),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.4, 0.6, 0.9],
                    colors: [
                      const Color.fromARGB(255, 1, 31, 65),
                      const Color.fromARGB(255, 9, 132, 239),
                      const Color.fromARGB(255, 87, 171, 240),
                      Colors.blue.shade200,
                    ],
                  ),
                ),
                child: Column(children: <Widget>[
                  SizedBox(
                      height:
                          kToolbarHeight), // AppBar'ın yüksekliği kadar boşluk ekleyin
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 1),
                          Text(
                            'Welcome to SAIL',
                            style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 45),
                          Image.network(
                            'https://t4.ftcdn.net/jpg/02/79/25/83/240_F_279258327_PPgJYL3HPPuc1jWkpg0GSPUj9D5S1VAH.jpg',
                            height: 150,
                          ),
                          SizedBox(height: 30),
                          _buildRoundedTextField(
                              Icons.account_circle, 'Username'),
                          SizedBox(height: 10),
                          _buildRoundedPasswordField(
                              Icons.visibility, 'Password'),
                          SizedBox(height: 60),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage()),
                              );
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: 'Sign up here',
                                    style: TextStyle(
                                      color: Color.fromRGBO(4, 6, 132, 0.79),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))));
  }

  Widget _buildRoundedTextField(IconData icon, String hintText) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon),
          hintText: hintText,
        ),
      ),
    );
  }

  Widget _buildRoundedPasswordField(IconData icon, String hintText) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon),
          hintText: hintText,
          suffixIcon: Icon(Icons.visibility),
        ),
        obscureText: true,
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(50, 98, 230, 0.653),
        elevation: 0,
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: double.infinity, // Container'ı genişlet
          height: double.infinity, // Container'ı genişlet
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.4, 0.6, 0.9],
              colors: [
                const Color.fromARGB(255, 1, 31, 65),
                const Color.fromARGB(255, 9, 132, 239),
                const Color.fromARGB(255, 87, 171, 240),
                Colors.blue.shade200,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Image.network(
                'https://t4.ftcdn.net/jpg/02/79/25/83/240_F_279258327_PPgJYL3HPPuc1jWkpg0GSPUj9D5S1VAH.jpg',
                height: 150,
              ),
              SizedBox(height: 60),
              _buildRoundedTextField(Icons.account_circle, 'Username'),
              SizedBox(height: 10),
              _buildRoundedPasswordField(Icons.visibility, 'Password'),
              SizedBox(height: 10),
              _buildRoundedTextField(Icons.email, 'Email'),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Return to ',
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 6, 132, 0.79),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(IconData icon, String hintText) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon),
          hintText: hintText,
        ),
      ),
    );
  }

  Widget _buildRoundedPasswordField(IconData icon, String hintText) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon),
          hintText: hintText,
          suffixIcon: Icon(Icons.visibility),
        ),
        obscureText: true,
      ),
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.4, 0.6, 0.9],
              colors: [
                Color.fromARGB(178, 19, 31, 170),
                Color.fromARGB(178, 19, 31, 170),
                Color.fromARGB(178, 19, 31, 170),
                Color.fromARGB(178, 19, 31, 170),
              ],
            ),
          ),
        ),
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: double.infinity, // Container'ı genişlet
          height: double.infinity, // Container'ı genişlet
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // Adjust the stops for smoother transition
              colors: [
                const Color.fromARGB(255, 1, 31, 65),
                const Color.fromARGB(255, 9, 132, 239),
                const Color.fromARGB(255, 87, 171, 240),
                Colors.blue.shade200,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 1),
              Image.network(
                'https://t4.ftcdn.net/jpg/02/79/25/83/240_F_279258327_PPgJYL3HPPuc1jWkpg0GSPUj9D5S1VAH.jpg',
                height: 150,
              ),
              SizedBox(height: 50),
              _buildRoundedTextField(Icons.email, 'Enter your email'),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Send',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Back to ',
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 6, 132, 0.79),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(IconData icon, String hintText) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon),
          hintText: hintText,
        ),
      ),
    );
  }
}
