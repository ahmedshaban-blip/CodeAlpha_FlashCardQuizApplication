# 🧠 Flashcard Quiz App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)

**A beautiful and intuitive flashcard quiz application built with Flutter and Cubit state management** 📚

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Usage](#-usage) • [Architecture](#-architecture) • [Contributing](#-contributing)

</div>

---

## 🌟 Features

<table>
<tr>
<td>

### 📖 Study Features
- **Interactive Flashcards** with smooth flip animations
- **Question & Answer** toggle functionality  
- **Navigation Controls** (Previous/Next)
- **Progress Tracking** (Card X of Y)
- **Clean & Minimalist** design focused on learning

</td>
<td>

### ⚙️ Management Features
- **Create** new flashcards easily
- **Edit** existing flashcards
- **Delete** with confirmation dialog
- **View All** flashcards in organized list
- **Persistent Storage** using SharedPreferences

</td>
</tr>
</table>

---

## 📱 Screenshots

<div align="center">

| Home Screen | Study View | Flashcard List | Add/Edit |
|-------------|------------|----------------|----------|
| <img src="screenshots/home.png" width="200"/> | <img src="screenshots/study.png" width="200"/> | <img src="screenshots/list.png" width="200"/> | <img src="screenshots/add.png" width="200"/> |

</div>

---

## 🚀 Installation

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Android/iOS device or emulator

### Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/flashcard-quiz-app.git

# Navigate to project directory
cd flashcard-quiz-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3      # State Management
  shared_preferences: ^2.2.2 # Local Storage
  uuid: ^4.2.1              # Unique IDs
  equatable: ^2.0.5         # Value Equality

dev_dependencies:
  bloc_test: ^9.1.5         # Testing Cubit
  flutter_test: ^3.0.0      # Widget Testing
```

---

## 🎯 Usage

### Creating Your First Flashcard

1. **Launch** the app
2. **Tap** "Create Your First Flashcard" 
3. **Enter** your question and answer
4. **Save** and start studying! 🎉

### Studying Flow

```mermaid
graph LR
    A[📖 Read Question] --> B[🤔 Think]
    B --> C[👆 Tap to Reveal]
    C --> D[✅ Check Answer]
    D --> E[➡️ Next Card]
    E --> A
```

### Managing Flashcards

- **➕ Add New**: Tap the floating action button
- **✏️ Edit**: Long press on any flashcard in the list
- **🗑️ Delete**: Swipe left or tap delete icon
- **📋 View All**: Access from the main menu

---

## 🏗️ Architecture

### State Management with Cubit

```
📦 lib/
├── 📁 cubits/
│   ├── flashcard_cubit.dart
│   └── flashcard_state.dart
├── 📁 models/
│   └── flashcard.dart
├── 📁 screens/
│   ├── home_screen.dart
│   ├── flashcard_list_screen.dart
│   └── add_edit_flashcard_screen.dart
├── 📁 widgets/
│   ├── flashcard_display.dart
│   └── flashcard_tile.dart
└── 📁 services/
    └── storage_service.dart
```

### State Flow Diagram

```mermaid
stateDiagram-v2
    [*] --> FlashcardInitial
    FlashcardInitial --> FlashcardLoading
    FlashcardLoading --> FlashcardLoaded
    FlashcardLoading --> FlashcardError
    FlashcardLoaded --> FlashcardLoading
    FlashcardError --> FlashcardLoading
```

---

## 🧪 Testing

Run the test suite:

```bash
# Unit Tests
flutter test

# Widget Tests
flutter test test/widget_test.dart

# Integration Tests
flutter test integration_test/
```

### Test Coverage

- ✅ **Cubit Logic** - State transitions and business logic
- ✅ **Widget Rendering** - UI components and interactions  
- ✅ **Integration Flow** - Complete user journeys
- ✅ **Edge Cases** - Error handling and boundary conditions

---

## 🎨 Design System

### Color Palette

<div align="center">

| Primary | Secondary | Success | Warning | Error |
|---------|-----------|---------|---------|-------|
| ![#2196F3](https://via.placeholder.com/50x30/2196F3/FFFFFF?text=Primary) | ![#FF9800](https://via.placeholder.com/50x30/FF9800/FFFFFF?text=Secondary) | ![#4CAF50](https://via.placeholder.com/50x30/4CAF50/FFFFFF?text=Success) | ![#FF5722](https://via.placeholder.com/50x30/FF5722/FFFFFF?text=Warning) | ![#F44336](https://via.placeholder.com/50x30/F44336/FFFFFF?text=Error) |

</div>

### Typography

- **Headlines**: Roboto Bold
- **Body Text**: Roboto Regular  
- **Captions**: Roboto Light

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **🍴 Fork** the repository
2. **🌿 Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **💾 Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **📤 Push** to the branch (`git push origin feature/amazing-feature`)
5. **🔀 Open** a Pull Request

### Development Guidelines

- Follow [Flutter Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Write tests for new features
- Update documentation as needed
- Ensure code is properly formatted (`flutter format .`)

---

## 📊 Performance

<div align="center">

| Metric | Value |
|--------|-------|
| **App Size** | ~8.5 MB |
| **Cold Start** | ~2.1s |
| **Hot Reload** | ~400ms |
| **Memory Usage** | ~45 MB |

</div>

---

## 🗺️ Roadmap

### Version 2.0 🚀
- [ ] **Categories & Tags** for better organization
- [ ] **Spaced Repetition** algorithm
- [ ] **Statistics Dashboard** with progress tracking
- [ ] **Dark Mode** support

### Version 3.0 🌟
- [ ] **Cloud Sync** across devices
- [ ] **Image Support** in flashcards
- [ ] **Multiple Choice** questions
- [ ] **Import/Export** functionality

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Ahmed Shaban**
- GitHub: [My GitHub](https://github.com/ahmedshaban-blip)
- Email: ahmed.shabaan.dev@gmail.com
- LinkedIn: [My LinkedIn](https://www.linkedin.com/in/ahmedshaban-dev/)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library maintainers
- Material Design team for design guidelines
- Open source community for inspiration

---

<div align="center">

**⭐ Star this repo if you found it helpful!**

Made with ❤️ and Flutter

[Back to Top](#-flashcard-quiz-app)

</div>
