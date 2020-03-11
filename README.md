# NYTDemo
This demo is developed for showing most popular feed of New York Times.

## Generating Code Coverage
###### Steps:-

* Enable the code coverage for the scheme by editing the scheme and tick the box ‘Code Coverage’ from ‘Test’ action. We can select all targets or filter targets as well if we don’t want to include coverage for any other target.

* Build and test this scheme using CMD+U button in Xcode this will generate Code coverage reports into the default derived data directory located at ~/Library/Developer/Xcode/DerivedData and you will see the code coverage reports generated at Logs/Test directory.

* We will see code coverage with .xcresult file inside the Test directory.

* Open .xcresult file directly in Xcode. This will open a new window with all the details in Report Navigator of Navigator pane. It incluedes build, code coverage, logs and other information. Click on code coverage option and you will find the total covered codes in the build. Clicking on the application name will show all the files with code covered percentage.

Thanks
