# SwiftUI-Combine-CleanMVVM

![Swift](https://github.com/tirtavium/SwiftUI-Combine-CleanMVVM/workflows/Swift/badge.svg)

This repo is trying to approach MVVM with clean architecture design by uncle bob.

All of the component is protocol oriented meaning that all related operation class variables is written as protocol, so with this code base able to accomplish composition over inheritance practice.


| Component | Purpose |
| ------ | ------ |
| Entity | Note Model, the main product of this Note Book App |
| Interactor | Logic of the business case |
| Presenter | To present the processed data by interactor to View Model  |
| View Model | To keep the UI state and data by Combine |
| View | User Interface use swift UI |

the table is trying to follow this diagram

![alt text](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg "clean architecture")

and the if we see the code, all the interaction between components is like this :

![alt text](https://github.com/tirtavium/SwiftUI-Combine-CleanMVVM/blob/master/Resources/CleanMVVM.png?raw=true "flow")

# Explanations
Composition over inheritance :
  - Needed component registered as Protocol in the class.
  - Protocol as contract between components.
 
Clean, easy to maintain and readable business process :
  - Interactor and Entity importing only Foundation framework.
  - Interactor only contain entity to process, no network component or database.
  - covering all the function with unit test, since this would be easy to mock and testing it.
 
Clear UI or App flow :
  - Presenter for translate raw data given by interactor into more user friendly to viewmodel.
  - Combine framework is only use on ViewModel.
  - View component (UIKit/SwiftUI) only use on ViewController as the humble object principle we not test the viewcontroller.

External Component :
  - NoteService Protocol can have many implementation class, and can be used by many of NoteBookInteractor since all they know is protocol so the open closed principle is possible since we can have many implementation as we wanted.
  - Network, Core Data, file storing, or any external component is the responsible of service implementation, unit test in this part more about integration test, make sure that fragility of integration test not make development harder.

# Benefit

  - Low coupling will make you easy to unit test.
  - Composition over inheritance this will make you way of code into higher level, you can implement (TBD) Trunk Based Development and put a development toggle for new feature, with TBD your chance to modify production code will be lesser and reduce the regression test by QA.
  - if you can do well unit test, have a feature toggle and complete it with CI/CD, you able to do frequent release.


# Challenges
  - Team knowledge gap, junior programmer who still in the pace of programming will be hard to get the full vision of this, they would likely to find the way to violate this design. 
  Too much experienced programmer if that person not able to getting teach by other, because no one able to change the person expect the person itself.
  - Strict rule of merge code, this need to make sure every day since the good quality of code base is long term commitment.
  - Business stakeholder who likes fast and done, if you can't finish it in certain time, you're not a good programmer. don't let your ability to crafting a good quality software getting hijacked by business stakeholder who think about his own personal benefit.

# Thanks
  - Please, put your feedback on issues section.

