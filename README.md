# A-EYE mobile

## Development Environment
- Flutter 3.3.10 
- Dart 2.18.6 

## Application Version

- Android
  - minSdkVersion : 31

- IOS
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
![aeye-splash mp4](https://user-images.githubusercontent.com/106396244/229190824-e5b1b7cd-558d-4609-8e0a-324780282804.gif)



https://user-images.githubusercontent.com/106396244/229192377-3f747d02-c2a0-4395-87e6-bded4facd28f.mp4

https://user-images.githubusercontent.com/106396244/229192414-b75576f6-1d6a-4466-8eb8-d174166c65fe.mp4

https://user-images.githubusercontent.com/106396244/229192675-0fa86adb-4674-4c9c-bb5a-93f2d57a02dc.mp4

https://user-images.githubusercontent.com/106396244/229192453-9198d257-84c0-4e18-8828-2e3ba392fa07.mp4




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


  
