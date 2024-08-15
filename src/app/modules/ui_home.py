# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'home.ui'
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
    QLabel, QLayout, QPushButton, QSizePolicy,
    QSpacerItem, QVBoxLayout, QWidget)
from . resources_rc import *

class Ui_Home(object):
    def setupUi(self, Home):
        if not Home.objectName():
            Home.setObjectName(u"Home")
        Home.resize(760, 526)
        sizePolicy = QSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(Home.sizePolicy().hasHeightForWidth())
        Home.setSizePolicy(sizePolicy)
        self.verticalLayout_3 = QVBoxLayout(Home)
        self.verticalLayout_3.setObjectName(u"verticalLayout_3")
        self.verticalLayout_3.setSizeConstraint(QLayout.SetNoConstraint)
        self.verticalLayout_3.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_2 = QVBoxLayout()
        self.verticalLayout_2.setObjectName(u"verticalLayout_2")
        self.verticalLayout_2.setSizeConstraint(QLayout.SetNoConstraint)
        self.horizontalLayout = QHBoxLayout()
        self.horizontalLayout.setObjectName(u"horizontalLayout")
        self.horizontalLayout.setContentsMargins(-1, -1, -1, 0)
        self.logo_container = QWidget(Home)
        self.logo_container.setObjectName(u"logo_container")
        sizePolicy1 = QSizePolicy(QSizePolicy.Policy.MinimumExpanding, QSizePolicy.Policy.MinimumExpanding)
        sizePolicy1.setHorizontalStretch(0)
        sizePolicy1.setVerticalStretch(0)
        sizePolicy1.setHeightForWidth(self.logo_container.sizePolicy().hasHeightForWidth())
        self.logo_container.setSizePolicy(sizePolicy1)
        self.gridLayout_2 = QGridLayout(self.logo_container)
        self.gridLayout_2.setObjectName(u"gridLayout_2")
        self.gridLayout_2.setContentsMargins(0, 0, 0, 0)
        self.gridLayout = QGridLayout()
        self.gridLayout.setObjectName(u"gridLayout")

        self.gridLayout_2.addLayout(self.gridLayout, 0, 0, 1, 1)


        self.horizontalLayout.addWidget(self.logo_container)


        self.verticalLayout_2.addLayout(self.horizontalLayout)

        self.line = QFrame(Home)
        self.line.setObjectName(u"line")
        self.line.setFrameShape(QFrame.Shape.HLine)
        self.line.setFrameShadow(QFrame.Shadow.Sunken)

        self.verticalLayout_2.addWidget(self.line)

        self.horizontalLayout_2 = QHBoxLayout()
        self.horizontalLayout_2.setObjectName(u"horizontalLayout_2")
        self.horizontalLayout_2.setSizeConstraint(QLayout.SetNoConstraint)
        self.horizontalSpacer_2 = QSpacerItem(40, 20, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)

        self.horizontalLayout_2.addItem(self.horizontalSpacer_2)

        self.widget = QWidget(Home)
        self.widget.setObjectName(u"widget")
        sizePolicy.setHeightForWidth(self.widget.sizePolicy().hasHeightForWidth())
        self.widget.setSizePolicy(sizePolicy)
        self.verticalLayout_5 = QVBoxLayout(self.widget)
        self.verticalLayout_5.setObjectName(u"verticalLayout_5")
        self.verticalLayout_4 = QVBoxLayout()
        self.verticalLayout_4.setObjectName(u"verticalLayout_4")
        self.verticalLayout_4.setSizeConstraint(QLayout.SetNoConstraint)
        self.verticalSpacer_2 = QSpacerItem(20, 40, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding)

        self.verticalLayout_4.addItem(self.verticalSpacer_2)

        self.create_project_push_button = QPushButton(self.widget)
        self.create_project_push_button.setObjectName(u"create_project_push_button")
        sizePolicy2 = QSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Fixed)
        sizePolicy2.setHorizontalStretch(0)
        sizePolicy2.setVerticalStretch(0)
        sizePolicy2.setHeightForWidth(self.create_project_push_button.sizePolicy().hasHeightForWidth())
        self.create_project_push_button.setSizePolicy(sizePolicy2)
        font = QFont()
        font.setFamilies([u"Segoe UI"])
        font.setPointSize(10)
        self.create_project_push_button.setFont(font)
        self.create_project_push_button.setCursor(QCursor(Qt.CursorShape.PointingHandCursor))
        self.create_project_push_button.setStyleSheet(u"background-color: rgb(52, 59, 72);\n"
"padding: 10;")
        icon = QIcon()
        icon.addFile(u":/icons/images/icons/cil-plus.png", QSize(), QIcon.Mode.Normal, QIcon.State.Off)
        self.create_project_push_button.setIcon(icon)

        self.verticalLayout_4.addWidget(self.create_project_push_button)

        self.verticalSpacer = QSpacerItem(20, 40, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding)

        self.verticalLayout_4.addItem(self.verticalSpacer)


        self.verticalLayout_5.addLayout(self.verticalLayout_4)


        self.horizontalLayout_2.addWidget(self.widget)

        self.horizontalSpacer_3 = QSpacerItem(40, 20, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)

        self.horizontalLayout_2.addItem(self.horizontalSpacer_3)


        self.verticalLayout_2.addLayout(self.horizontalLayout_2)

        self.projects_section = QWidget(Home)
        self.projects_section.setObjectName(u"projects_section")
        self.projects_section.setMinimumSize(QSize(0, 40))
        self.gridLayout_3 = QGridLayout(self.projects_section)
        self.gridLayout_3.setObjectName(u"gridLayout_3")
        self.gridLayout_3.setContentsMargins(11, 11, 11, 11)
        self.verticalLayout_6 = QVBoxLayout()
        self.verticalLayout_6.setObjectName(u"verticalLayout_6")
        self.projects_label = QLabel(self.projects_section)
        self.projects_label.setObjectName(u"projects_label")
        font1 = QFont()
        font1.setFamilies([u"Segoe UI"])
        font1.setPointSize(10)
        font1.setUnderline(True)
        self.projects_label.setFont(font1)

        self.verticalLayout_6.addWidget(self.projects_label)

        self.projects_container = QWidget(self.projects_section)
        self.projects_container.setObjectName(u"projects_container")
        self.projects_container.setMinimumSize(QSize(0, 50))
        self.horizontalLayout_4 = QHBoxLayout(self.projects_container)
        self.horizontalLayout_4.setObjectName(u"horizontalLayout_4")
        self.horizontalLayout_4.setContentsMargins(0, 0, 0, 0)
        self.horizontalLayout_3 = QHBoxLayout()
        self.horizontalLayout_3.setObjectName(u"horizontalLayout_3")
        self.no_project_notice = QWidget(self.projects_container)
        self.no_project_notice.setObjectName(u"no_project_notice")
        self.horizontalLayout_5 = QHBoxLayout(self.no_project_notice)
        self.horizontalLayout_5.setObjectName(u"horizontalLayout_5")
        self.label = QLabel(self.no_project_notice)
        self.label.setObjectName(u"label")

        self.horizontalLayout_5.addWidget(self.label)


        self.horizontalLayout_3.addWidget(self.no_project_notice)


        self.horizontalLayout_4.addLayout(self.horizontalLayout_3)


        self.verticalLayout_6.addWidget(self.projects_container)


        self.gridLayout_3.addLayout(self.verticalLayout_6, 0, 0, 1, 1)


        self.verticalLayout_2.addWidget(self.projects_section)

        self.verticalSpacer_3 = QSpacerItem(20, 40, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding)

        self.verticalLayout_2.addItem(self.verticalSpacer_3)


        self.verticalLayout_3.addLayout(self.verticalLayout_2)


        self.retranslateUi(Home)

        QMetaObject.connectSlotsByName(Home)
    # setupUi

    def retranslateUi(self, Home):
        Home.setWindowTitle(QCoreApplication.translate("Home", u"Form", None))
        self.create_project_push_button.setText(QCoreApplication.translate("Home", u"Create project", None))
        self.projects_label.setText(QCoreApplication.translate("Home", u"Projects", None))
        self.label.setText(QCoreApplication.translate("Home", u"No project found. Create a new one now!", None))
    # retranslateUi

