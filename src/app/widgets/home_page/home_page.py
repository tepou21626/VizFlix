from PySide6.QtCore import *
from PySide6.QtGui import *
from PySide6.QtWidgets import *

from app.modules import *

class HomePage(QWidget):
    def __init__(self, parent):
        # SETUP UI
        QWidget.__init__(self)
        self.parent = parent
        self.setParent(parent)

        self.home_ui = Ui_Home()
        self.home_ui.setupUi(self)

        # ADD WIDGET TO OBJECT
        self.layout_ = QVBoxLayout()
        self.layout_.addChildWidget(self.home_ui.frame)
        self.setLayout(self.layout_)

        