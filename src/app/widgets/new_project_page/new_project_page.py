from PySide6.QtCore import *
from PySide6.QtGui import *
from PySide6.QtWidgets import *

from app.modules import *
from app.widgets import *

class NewProjectPage(QWidget):
    def __init__(self, ctx):
        QWidget.__init__(self)
        self.ctx = ctx
        ctx.ui.new_project.layout().addWidget(self)

        # SETUP UI
        self.ui = Ui_NewProject()
        self.setup()

    def setup(self):
        self.ui.setupUi(self)

        # CONNECT EVENTS.
        self.ui.bar_chart_race_button.mouseReleaseEvent = lambda _: self.on_button_click(self.ui.page_params)
        self.ui.turn_back_button.mouseReleaseEvent = lambda _: self.on_button_click(self.ui.page_type)

        
    def on_button_click(self, target_widget):
        self.ui.pages.setCurrentWidget(target_widget)