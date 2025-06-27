import sys
import psutil
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QPushButton, QLabel, QListWidget, QStackedWidget, QLineEdit, QSizePolicy
)
from PyQt5.QtGui import QFont, QColor, QPalette
from PyQt5.QtCore import Qt, QTimer

class RobloxWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Roblox veikia!")
        self.setMinimumSize(400, 300)
        label = QLabel("Roblox aptiktas ir veikia.", self)
        label.setFont(QFont("Segoe UI", 14))
        label.setAlignment(Qt.AlignCenter)
        self.setCentralWidget(label)

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Gražiausia Python GUI")
        self.setMinimumSize(900, 650)
        self.roblox_window = None
        self.init_ui()

    def init_ui(self):
        central = QWidget()
        self.setCentralWidget(central)

        main_layout = QHBoxLayout(central)

        # Sidebar
        self.sidebar = QListWidget()
        self.sidebar.setFixedWidth(220)
        self.sidebar.addItems(["Pagrindinis", "Nustatymai", "Apie"])
        self.sidebar.currentRowChanged.connect(self.display_page)
        self.sidebar.setStyleSheet(
            "QListWidget { background: #34495e; color: #ecf0f1; border: none; font-size: 16px; }"
            "QListWidget::item:selected { background: #2c3e50; }"
        )
        main_layout.addWidget(self.sidebar)

        # Pages
        self.pages = QStackedWidget()
        main_layout.addWidget(self.pages)

        # Pagrindinis
        page1 = QWidget()
        layout1 = QVBoxLayout(page1)
        layout1.setAlignment(Qt.AlignTop | Qt.AlignHCenter)
        page1.setStyleSheet("background-color: #ecf0f1;")

        welcome = QLabel("Sveiki atvykę į gražiausią GUI!")
        welcome.setFont(QFont("Segoe UI", 20, QFont.Bold))
        welcome.setStyleSheet("color: #2c3e50;")
        layout1.addWidget(welcome)

        self.status_label = QLabel("Roblox statusas: nežinomas")
        self.status_label.setFont(QFont("Segoe UI", 14))
        self.status_label.setStyleSheet("color: #2c3e50; margin-top: 10px;")
        layout1.addWidget(self.status_label)

        btn1 = QPushButton("Patikrink Roblox")
        btn1.setFont(QFont("Segoe UI", 12))
        btn1.setFixedSize(200, 50)
        btn1.setStyleSheet(
            "QPushButton { background-color: #2980b9; color: white; border-radius: 10px; }"
            "QPushButton:hover { background-color: #3498db; }"
            "QPushButton:pressed { background-color: #2471a3; }"
        )
        btn1.clicked.connect(self.check_roblox)
        layout1.addWidget(btn1)

        self.pages.addWidget(page1)

        # Nustatymai
        page2 = QWidget()
        layout2 = QVBoxLayout(page2)
        page2.setStyleSheet("background-color: #ecf0f1;")
        label2 = QLabel("Įveskite savo vardą:")
        label2.setFont(QFont("Segoe UI", 14))
        label2.setStyleSheet("color: #2c3e50;")
        input2 = QLineEdit()
        input2.setPlaceholderText("Vardas")
        input2.setFont(QFont("Segoe UI", 12))
        layout2.addWidget(label2)
        layout2.addWidget(input2)
        self.pages.addWidget(page2)

        # Apie
        page3 = QWidget()
        layout3 = QVBoxLayout(page3)
        page3.setStyleSheet("background-color: #ecf0f1;")
        about = QLabel(
            "Ši programa sukurta naudojant PyQt5 ir psutil. GUI turi šviesią temą, stilizuotus mygtukus ir patikrina, ar Roblox veikia."
        )
        about.setWordWrap(True)
        about.setFont(QFont("Segoe UI", 13))
        about.setStyleSheet("color: #2c3e50;")
        layout3.addWidget(about)
        self.pages.addWidget(page3)

        self.sidebar.setCurrentRow(0)

        # Auto-update Roblox status
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.check_roblox)
        self.timer.start(5000)

    def display_page(self, index):
        self.pages.setCurrentIndex(index)

    def check_roblox(self):
        running = any(proc.name().lower().startswith("roblox") for proc in psutil.process_iter())
        if running:
            self.status_label.setText("Roblox statusas: veikia")
            if not self.roblox_window:
                self.roblox_window = RobloxWindow()
                self.roblox_window.show()
        else:
            self.status_label.setText("Roblox statusas: neveikia")
            if self.roblox_window:
                self.roblox_window.close()
                self.roblox_window = None

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
