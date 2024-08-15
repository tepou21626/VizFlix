from PySide6.QtCore import *
from PySide6.QtGui import *
from PySide6.QtWidgets import *

from app.modules import *
from app.widgets import *

class HomePage(QWidget):
    def __init__(self, ctx):
        QWidget.__init__(self)
        self.ctx = ctx
        ctx.ui.home.layout().addWidget(self)

        # SETUP UI
        self.ui = Ui_Home()
        self.setup()
        

    def setup(self):
        self.ui.setupUi(self)
        self.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Expanding)
        self.ui.create_project_push_button.clicked.connect(self.ctx.ui.btn_new.click)

        # INSERT LOGO
        self.logo_label = QLabel(self)
        self.pixmap = QPixmap(":/images/images/images/VizFlix.png")
        self.logo_label.setPixmap(self.pixmap)
        self.ui.logo_container.layout().addWidget(self.logo_label)
        self.logo_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self.update_image()

    def resizeEvent(self, event):
        super().resizeEvent(event)
        self.update_image()

    def update_image(self):
        # Scale the pixmap while keeping the aspect ratio.
        scaled_pixmap = self.pixmap.scaled(self.ui.logo_container.size(), Qt.KeepAspectRatio, Qt.SmoothTransformation)
        self.logo_label.setPixmap(scaled_pixmap)
