{\rtf1\ansi\ansicpg1252\cocoartf2573
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww9000\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
Please follow the steps in this file to setup and work with this project.\
\
1. using Terminal App, cd to the project folder and run: pod install\
2. open the .xcworkspace file\
3. this project is using the MVC design pattern, structured in the following format: (for more info, check: https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html )\
	- Components\
		- Page Name\
			- Models (includes data models, such as structs, cells, custom views, etc)\
			- Views (includes storyboards and xib files)\
			- Controllers (includes UIViewControllers and their extensions)}