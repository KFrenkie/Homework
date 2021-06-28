Robot Framework

Preconditions

#Python:
Download the latest verison of python 3 from http://python.org under the downloads section

#Configuring PATH:
On Windows you can configure PATH by following the steps below. Notice that the exact setting names 
may be different on different Windows versions, but the basic approach should still be the same.
1.	Open Control Panel > System > Advanced > Environment Variables. 
      There are User variables and System variables, and the difference between them is that user variables
      affect only the current users, whereas system variables affect all users.
2.	To edit an existing PATH value, select Edit and add 
      ;<InstallationDir>;<ScriptsDir> at the end of the value (e.g. ;C:\Python27;C:\Python27\Scripts). 
      Note that the semicolons (;) are important as they separate the different entries. 
      To add a new PATH value, select New and set both the name and the value, this time without 
      the leading semicolon.
3.	Exit the dialog with Ok to save the changes.
4.	Start a new command prompt for the changes to take effect.

#Installing PIP
Starting from Python 2.7.9, the standard Windows installer by default installs and activates pip. 
Assuming you also have configured PATH and possibly set https_proxy, 
you can run pip install robotframework right after Python installation. 
With Python 3.4 and newer pip is officially part of the interpreter and should be automatically available.

In windows command prompt***:
*check python if it is properly installed:
python --version

*check pip if it is properly installed:
pip --version


#Install Robot Framework
* Install the latest version (does not upgrade)
pip install robotframework

* info about the installed robot framework
pip show robotframework

* Upgrade to the latest version 
pip install --upgrade robotframework

#Install Selenium
pip install selenium

#Install Selenium Library
pip install robotframework-seleniumlibrary

* check  installed Python packages
pip list


#Install and setup Pycharm IDE *
https://www.jetbrains.com/pycharm/

PyCharm is an integrated development environment used in computer programming, specifically for the 
Python language.

After PyCharm installation, install the following packages:
-Robot Framework
-Selenium
-Selenium Library

Go to Pycharm ->File/Setting/Python Intepreter ->Click on (+) icon -> Search for Robot Framework/Selenium/ Selenium Library
 > Select and Install Package -> Apply -> Ok

Also install the plugin Intellibot@Master.dev within PyCharm IDE:
File/Setting/Plugins -> Search for Intellibot@Master.dev > select Install  

The IntelliBot plugin for Pycharm adds smart editing features to support the Robot Framework. 


#Driver installation
To run test Webdrivers are also needed:

*For Chrome Browser download Chomerdriver:
https://chromedriver.chromium.org/downloads

**For Firefox Browser download Geckodriver:
https://github.com/mozilla/geckodriver/releases


The downloaded webdrivers must be saved under the installed python library in Scripts folder!


*** To open the command prompt in Windows, open the Start menu and search for "cmd." Press Enter or click on 
  the result to open a command window—or right-click the option to run it as an administrator, when 
  necessary.

#TO run robot test:
-go directly to the project folder and execute the following command:

To run the complete test suit with Chrome browser:
robot -d Results -v BROWSER:Chrome Testdata/automate.robot

To run the complete test suit with Chrome browser:
robot -d Results -v BROWSER:FireFox Testdata/automate.robot
