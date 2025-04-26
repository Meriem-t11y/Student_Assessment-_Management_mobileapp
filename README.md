# 📚 Student Assessment Manager

**Student Assessment Manager** is a mobile application developed with **Flutter** and **Dart**. It allows professors to manage student assessments during practical sessions.

## 🌟 Features

- 🔍 **Student Management**: Add, edit, and delete students.
- 📝 **Assessment Management**: Record assessments during practical sessions and tasks.
- 📊 **Results Visualization**: Display results as tables or charts.
- 🗂️ **Data Export**: Generate reports in PDF or Excel format.

## 🚀 Technologies Used

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **Database**: [SQfLite](https://pub.dev/packages/sqflite)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Charts**: [charts_flutter](https://pub.dev/packages/charts_flutter)

### Prerequisites:
- **Flutter**: Install [Flutter](https://flutter.dev/docs/get-started/install) on your system.
- **Dart**: Install [Dart](https://dart.dev/get-dart).

### Setup:

1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/your-username/student-assessment-manager.git
    ```

2. Navigate to the project directory:
    ```bash
    cd student-assessment-manager
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

4. Run the app:
    ```bash
    flutter run
    ```

## 🎯 User Stories

### **Student Management**
- As a professor, I can add, edit, and delete students, so I can manage my class roster.

### **Assessment Management**
- As a professor, I can record assessments for students, so I can evaluate their performance during practical sessions and tasks.

### **Task Management**
- As a professor, I can track student tasks such as presentations and projects, so I can monitor their progress.

### **Results Visualization**
- As a professor, I can visualize student results in tables or charts for easy analysis and reporting.

### **Data Export**
- As a professor, I can export student data and results in PDF or Excel format for reporting and record-keeping.

## 🗂️ Data Structure

The application uses SQfLite as the database to store student data, assessment records, tasks, and results. The data model includes:

- **Student**: Name, ID, Email
- **Assessment**: Task, Score, Date
- **Task**: Task Name, Due Date, Status
- **Result**: Student, Task, Score

## 📈 Future Enhancements

- Add user authentication and authorization for professors.
- Implement cloud synchronization for cross-device usage.
- Integrate notifications for upcoming tasks and deadlines.

## 🤝 Contributing

Contributions are welcome! Please feel free to fork this repository, submit issues, or send pull requests.

### How to Contribute:
1. Fork the repo.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add new feature'`).
5. Push to your forked repo (`git push origin feature/your-feature`).
6. Open a pull request.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

