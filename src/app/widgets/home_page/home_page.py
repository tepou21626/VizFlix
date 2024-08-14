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

