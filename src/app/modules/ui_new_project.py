# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'new_project.ui'
##
## Created by: Qt User Interface Compiler version 6.7.2
##
## WARNING! All changes made in this file will be lost when recompiling UI file!
################################################################################

from PySide6.QtCore import (QCoreApplication, QDate, QDateTime, QLocale,
    QMetaObject, QObject, QPoint, QRect,
    QSize, QTime, QUrl, Qt)
from PySide6.QtGui import (QBrush, QColor, QConicalGradient, QCursor,
    QFont, QFontDatabase, QGradient, QIcon,
    QImage, QKeySequence, QLinearGradient, QPainter,
    QPalette, QPixmap, QRadialGradient, QTransform)
from PySide6.QtWidgets import (QApplication, QFrame, QGridLayout, QHBoxLayout,
    QLabel, QLineEdit, QPushButton, QSizePolicy,
    QSpacerItem, QStackedWidget, QVBoxLayout, QWidget)
from . resources_rc import *

class Ui_NewProject(object):
    def setupUi(self, NewProject):
        if not NewProject.objectName():
            NewProject.setObjectName(u"NewProject")
        NewProject.resize(790, 462)
        self.gridLayout_2 = QGridLayout(NewProject)
        self.gridLayout_2.setObjectName(u"gridLayout_2")
        self.gridLayout_2.setContentsMargins(0, 0, 0, 0)
        self.gridLayout = QGridLayout()
        self.gridLayout.setSpacing(7)
        self.gridLayout.setObjectName(u"gridLayout")
        self.pages = QStackedWidget(NewProject)
        self.pages.setObjectName(u"pages")
        self.page_type = QWidget()
        self.page_type.setObjectName(u"page_type")
        self.verticalLayout_2 = QVBoxLayout(self.page_type)
        self.verticalLayout_2.setObjectName(u"verticalLayout_2")
        self.verticalLayout = QVBoxLayout()
        self.verticalLayout.setObjectName(u"verticalLayout")
        self.frame = QFrame(self.page_type)
        self.frame.setObjectName(u"frame")
        self.frame.setMinimumSize(QSize(0, 50))
        self.frame.setFrameShape(QFrame.StyledPanel)
        self.frame.setFrameShadow(QFrame.Raised)
        self.horizontalLayout_2 = QHBoxLayout(self.frame)
        self.horizontalLayout_2.setObjectName(u"horizontalLayout_2")
        self.horizontalLayout = QHBoxLayout()
        self.horizontalLayout.setObjectName(u"horizontalLayout")
        self.bar_chart_race_button = QWidget(self.frame)
        self.bar_chart_race_button.setObjectName(u"bar_chart_race_button")
        self.bar_chart_race_button.setMinimumSize(QSize(0, 50))
        font = QFont()
        font.setFamilies([u"Segoe UI"])
        self.bar_chart_race_button.setFont(font)
        self.bar_chart_race_button.setCursor(QCursor(Qt.CursorShape.PointingHandCursor))
        self.bar_chart_race_button.setStyleSheet(u"background-color: rgb(52, 59, 72);\n"
"padding: 10;")
        self.verticalLayout_4 = QVBoxLayout(self.bar_chart_race_button)
        self.verticalLayout_4.setObjectName(u"verticalLayout_4")
        self.verticalLayout_3 = QVBoxLayout()
        self.verticalLayout_3.setObjectName(u"verticalLayout_3")
        self.widget_2 = QWidget(self.bar_chart_race_button)
        self.widget_2.setObjectName(u"widget_2")
        self.widget_2.setMinimumSize(QSize(0, 0))
        self.horizontalLayout_4 = QHBoxLayout(self.widget_2)
        self.horizontalLayout_4.setObjectName(u"horizontalLayout_4")
        self.horizontalLayout_4.setContentsMargins(0, 0, 0, 0)
        self.horizontalSpacer = QSpacerItem(40, 20, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)

        self.horizontalLayout_4.addItem(self.horizontalSpacer)

        self.frame_2 = QFrame(self.widget_2)
        self.frame_2.setObjectName(u"frame_2")
        self.frame_2.setMinimumSize(QSize(40, 40))
        self.frame_2.setMaximumSize(QSize(40, 40))
        self.frame_2.setStyleSheet(u"border-image: url(:/icons/images/icons/cil-chart.png) 0 0 0 0 stretch stretch;\n"
"")
        self.frame_2.setFrameShape(QFrame.StyledPanel)
        self.frame_2.setFrameShadow(QFrame.Raised)

        self.horizontalLayout_4.addWidget(self.frame_2)

        self.horizontalSpacer_2 = QSpacerItem(40, 20, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)

        self.horizontalLayout_4.addItem(self.horizontalSpacer_2)


        self.verticalLayout_3.addWidget(self.widget_2)

        self.bar_chart_race_label = QLabel(self.bar_chart_race_button)
        self.bar_chart_race_label.setObjectName(u"bar_chart_race_label")
        font1 = QFont()
        font1.setPointSize(10)
        self.bar_chart_race_label.setFont(font1)
        self.bar_chart_race_label.setAlignment(Qt.AlignCenter)

        self.verticalLayout_3.addWidget(self.bar_chart_race_label)


        self.verticalLayout_4.addLayout(self.verticalLayout_3)


        self.horizontalLayout.addWidget(self.bar_chart_race_button)

        self.horizontalSpacer_3 = QSpacerItem(40, 20, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)

        self.horizontalLayout.addItem(self.horizontalSpacer_3)


        self.horizontalLayout_2.addLayout(self.horizontalLayout)


        self.verticalLayout.addWidget(self.frame)


        self.verticalLayout_2.addLayout(self.verticalLayout)

        self.verticalSpacer = QSpacerItem(20, 40, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding)

        self.verticalLayout_2.addItem(self.verticalSpacer)

        self.pages.addWidget(self.page_type)
        self.page_params = QWidget()
        self.page_params.setObjectName(u"page_params")
        self.verticalLayout_6 = QVBoxLayout(self.page_params)
        self.verticalLayout_6.setObjectName(u"verticalLayout_6")
        self.verticalLayout_5 = QVBoxLayout()
        self.verticalLayout_5.setObjectName(u"verticalLayout_5")
        self.widget_5 = QWidget(self.page_params)
        self.widget_5.setObjectName(u"widget_5")
        self.widget_5.setMinimumSize(QSize(0, 30))
        self.horizontalLayout_11 = QHBoxLayout(self.widget_5)
        self.horizontalLayout_11.setObjectName(u"horizontalLayout_11")
        self.horizontalLayout_10 = QHBoxLayout()
        self.horizontalLayout_10.setObjectName(u"horizontalLayout_10")
        self.turn_back_button = QLabel(self.widget_5)
        self.turn_back_button.setObjectName(u"turn_back_button")
        font2 = QFont()
        font2.setFamilies([u"Segoe UI"])
        font2.setPointSize(14)
        self.turn_back_button.setFont(font2)
        self.turn_back_button.setCursor(QCursor(Qt.CursorShape.PointingHandCursor))

        self.horizontalLayout_10.addWidget(self.turn_back_button)


        self.horizontalLayout_11.addLayout(self.horizontalLayout_10)


        self.verticalLayout_5.addWidget(self.widget_5)

        self.widget = QWidget(self.page_params)
        self.widget.setObjectName(u"widget")
        sizePolicy = QSizePolicy(QSizePolicy.Policy.Preferred, QSizePolicy.Policy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.widget.sizePolicy().hasHeightForWidth())
        self.widget.setSizePolicy(sizePolicy)
        self.widget.setMinimumSize(QSize(0, 30))
        self.horizontalLayout_7 = QHBoxLayout(self.widget)
        self.horizontalLayout_7.setObjectName(u"horizontalLayout_7")
        self.horizontalLayout_6 = QHBoxLayout()
        self.horizontalLayout_6.setObjectName(u"horizontalLayout_6")
        self.widget_3 = QWidget(self.widget)
        self.widget_3.setObjectName(u"widget_3")
        self.widget_3.setMinimumSize(QSize(0, 60))
        self.verticalLayout_8 = QVBoxLayout(self.widget_3)
        self.verticalLayout_8.setObjectName(u"verticalLayout_8")
        self.verticalLayout_8.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_7 = QVBoxLayout()
        self.verticalLayout_7.setObjectName(u"verticalLayout_7")
        self.widget_4 = QWidget(self.widget_3)
        self.widget_4.setObjectName(u"widget_4")
        self.horizontalLayout_9 = QHBoxLayout(self.widget_4)
        self.horizontalLayout_9.setObjectName(u"horizontalLayout_9")
        self.horizontalLayout_9.setContentsMargins(0, 0, 0, 0)
        self.horizontalLayout_8 = QHBoxLayout()
        self.horizontalLayout_8.setObjectName(u"horizontalLayout_8")
        self.project_name_label = QLabel(self.widget_4)
        self.project_name_label.setObjectName(u"project_name_label")

        self.horizontalLayout_8.addWidget(self.project_name_label)

        self.project_name_line_edit = QLineEdit(self.widget_4)
        self.project_name_line_edit.setObjectName(u"project_name_line_edit")

        self.horizontalLayout_8.addWidget(self.project_name_line_edit)


        self.horizontalLayout_9.addLayout(self.horizontalLayout_8)


        self.verticalLayout_7.addWidget(self.widget_4)

        self.verticalSpacer_3 = QSpacerItem(20, 40, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding)

        self.verticalLayout_7.addItem(self.verticalSpacer_3)


        self.verticalLayout_8.addLayout(self.verticalLayout_7)


        self.horizontalLayout_6.addWidget(self.widget_3)


        self.horizontalLayout_7.addLayout(self.horizontalLayout_6)

        self.frame_3 = QFrame(self.widget)
        self.frame_3.setObjectName(u"frame_3")
        sizePolicy1 = QSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Preferred)
        sizePolicy1.setHorizontalStretch(0)
        sizePolicy1.setVerticalStretch(0)
        sizePolicy1.setHeightForWidth(self.frame_3.sizePolicy().hasHeightForWidth())
        self.frame_3.setSizePolicy(sizePolicy1)
        self.frame_3.setFrameShape(QFrame.StyledPanel)
        self.frame_3.setFrameShadow(QFrame.Raised)
        self.verticalLayout_10 = QVBoxLayout(self.frame_3)
        self.verticalLayout_10.setObjectName(u"verticalLayout_10")
        self.verticalLayout_10.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_9 = QVBoxLayout()
        self.verticalLayout_9.setObjectName(u"verticalLayout_9")

        self.verticalLayout_10.addLayout(self.verticalLayout_9)


        self.horizontalLayout_7.addWidget(self.frame_3)


        self.verticalLayout_5.addWidget(self.widget)


        self.verticalLayout_6.addLayout(self.verticalLayout_5)

        self.confirm_button = QPushButton(self.page_params)
        self.confirm_button.setObjectName(u"confirm_button")

        self.verticalLayout_6.addWidget(self.confirm_button)

        self.verticalSpacer_2 = QSpacerItem(20, 40, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding)

        self.verticalLayout_6.addItem(self.verticalSpacer_2)

        self.pages.addWidget(self.page_params)

        self.gridLayout.addWidget(self.pages, 0, 0, 1, 1)


        self.gridLayout_2.addLayout(self.gridLayout, 0, 0, 1, 1)


        self.retranslateUi(NewProject)

        QMetaObject.connectSlotsByName(NewProject)
    # setupUi

    def retranslateUi(self, NewProject):
        NewProject.setWindowTitle(QCoreApplication.translate("NewProject", u"Form", None))
        self.bar_chart_race_label.setText(QCoreApplication.translate("NewProject", u"Bar Chart Race", None))
        self.turn_back_button.setText(QCoreApplication.translate("NewProject", u"< Back", None))
        self.project_name_label.setText(QCoreApplication.translate("NewProject", u"Project Name", None))
        self.project_name_line_edit.setText(QCoreApplication.translate("NewProject", u"My Project", None))
        self.confirm_button.setText(QCoreApplication.translate("NewProject", u"Confirm", None))
    # retranslateUi

