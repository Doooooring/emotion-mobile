# A-EYE mobile

## Development Environment
- Flutter 3.3.10 
- Dart 2.18.6 

## Application Version

### Android
- minSdkVersion : 31

### IOS
- Make sure you have the Xcode version 14.0 or above installed on your computer.
- IOS version with 16.2 (recommend to use simulator with iPhone 14 Pro Max with iOS 16.2

## Required permission
- Notification (Needed) : It is used for push message about falling alert.

## License
The following libraries are used in this project.
- Youtube player flutter
- syncfusion flutter charts
- flutter local notifications
- firebase messaging

## Usage
- Login
  - After signing up and signing in, the user should choose the role between main caregiver and sub caregiver.
  - Main caregiver gets identification code that should be shared to sub caregiver. The code identifies that they are parent.
  - Sub caregiver should input the identification code that would be shared by the main caregiver. 
  - Sub caregiver is restricted to write the diary. Other functions are all available to both.
  - Can test with the test account
    - (main : (id : main@gdsc.com, password : 12345678), sub : (id : sub@gdsc.com, password : 12345678)

- Baby Monitoring
  - Video
    - View baby's monitoring video. (With technical issue, the recorded video is viewed now. It would be updated soon)  
  - SOS
    - Clicking sos button on alert page, move to the google map to view the nearby hospital.

- Emotion diary
  - Diary
    - After writing the diary, the user can choose the emoticon based on the emotion by Google Natural Language API.
  - Comment
    - The caregivers can comment for today's diary. 
    - This is restricted until writing the diary.


  
