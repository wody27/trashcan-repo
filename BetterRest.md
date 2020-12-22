# BetterRest 

- 오늘 진행할 프로젝트는 바로 커피중독자를 위해서 언제 잠들어야 자신이 원하는 적당한 수면을 취할 수 있을까에 대한 앱입니다. 
- 일어나고 싶은 시간, 원하는 수면 시간, 하루에 커피를 얼마나 마시냐에 따라서 잠자리에 갈 시간을 추천해줍니다. 
- 여기서!!!! 잠자리에 갈 시간은 정말 많은 경우의 수가 나올 수 있는데요,, 일어나고 싶은 시간 수 x 원하는 수면 시간 수 x 하루에 마시는 커피 잔 수 를 하면 나올 수 있는 경우의 수는 수억,, 아니 셀 수 없을 겁니다. 그래서 저희는 오늘 이 프로젝트에서 CoreML이라는 프레임워크를 사용할 것입니다!



## 오늘 학습할 내용

- Stepper
- DatePicker
- CoreML
- 프로젝트 완성



## Stepper

프로젝트를 실제로 만들어 보기 전에 Stepper에 대해서 먼저 알아보겠습니다!! stepper는 모두 무엇인지 아실텐데요! 스유에선 아래와 같이 만드는 것이 기본형태라고 하네요.  sleepAmount는 변하는 값이니 State로 선언해줍니다.

```swift
@State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper(value: $sleepAmount) {
            Text("\(sleepAmount) hours")
        }
    }
```

 이것을 코드에 집어넣으면 아래 그림처럼 UI가 구성될거예요.

<img src="https://user-images.githubusercontent.com/56102421/102891916-67b15e00-44a2-11eb-9509-12160f9ac36f.png" width="50%" />

**옵션**

-  -,+ 가 되는 범위를 다음과 같이 지정해줄 수 있습니다.

```swift
Stepper(value: $sleepAmount, in: 4...12) {
    Text("\(sleepAmount) hours")
}
```

- -,+를 통해 움직이는 양의 정도를 `step` 매개변수를 통해 조절할 수 있습니다. default값은 1입니다.

```swift
Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
    Text("\(sleepAmount) hours")
}
```

- Stepper에 표시되는 숫자는 아래와 같이 소수점 둘째짜리까지 표현이 가능합니다. 

```swift
Text("\(sleepAmount, specifier: "%.2f") hours")
```

이를 모두 적용시켜보면 아래와 같은 UI가 구성이 돼요! 실행시켜보면서 테스트해보아요~

<img width="50%" alt="image" src="https://user-images.githubusercontent.com/56102421/102892333-0fc72700-44a3-11eb-9814-1aa2408e54c1.png">

## DatePicker

DatePicker도 스토리보드를 사용해서 많이 만들어보셨을거라 생각합니다. 스유에선 아래와 같이 기본형태로 만들 수 있습니다.

```swift
@State private var wakeUp = Date()
    
    var body: some View {
        DatePicker("Please enter a date", selection: $wakeUp)
    }
```

이렇게 코드를 입력하면 다음과 같이 화면이 나오는데 여기서 String부분을 주목해주세요.

<img width="399" alt="image" src="https://user-images.githubusercontent.com/56102421/102892602-78160880-44a3-11eb-8a25-ae58324ad88e.png">

String부분을 지우고 `""` 로 입력을 해주어도 DatePicker는 오른쪽으로 치우쳐져 있습니다. 이를 해결해주는 것은 아래 코드를 입력해주면 됩니다.

```swift
DatePicker("Please enter a date", selection: $wakeUp)
        .labelsHidden()
```

**옵션**

displayedComponents: datepicker로 설정할 값들을 지정할 수 있습니다.

```swift
DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
```

in: Datepicker의 범위를 지정할 수 있습니다.

근데 이거 왜 안될까??? 이코드 왜안되는지... 오류를 못찾겠어.. ㅠㅠ range에서 오류나 흑

아무튼 저기에 보이는 86400 은 하루 초를 의미하는 것이라고 합니다!

```swift
let now = Date()
let tomorrow = Date().addingTimeInterval(86400)
let range = now ... tomorrow

var body: some View {
  DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
}
```

## dates 다루기

이번 프로젝트에서는 Time 시간을 주로 다루기 때문에 Date에 관한 APi들에 대한 소개들이 몇가지 있어

- Date(): 위에서도 쓰였듯이 날짜와 관련된 모든 변수나 함수들이 이 스트럭안에 다 있습니다!

- DateComponents(): 날짜에 관련된 컴포넌트들만 가져와서 접근가능하게 해줍니다. 이는 옵셔널이기 때문에 옵셔널처리를 해주어야 합니다.

  ```swift
  var components = DateComponents()
  components.hour = 8
  components.minute = 0
  let date = Calendar.current.date(from: components) ?? Date()
  ```

- DateFormatter: 이건 Date의 형식을 format을 바꿀때 사용합니다.

  ```swift
  let formatter = DateFormatter()
  formatter.timeStyle = .short
  let dateString = formatter.string(from: Date())
  ```

## CoreML

CoreML에 대해서는 SwiftUI를 다루는 스터디이기 때문에 생략하도록 하겠습니다!!! 실제 프로젝트에선 여기서 만들어준 모델을 사용할 것이니 카톡에 올라온 모델을 프로젝트에 집어넣어주세요!!

## 프로젝트 만들기

### UI 틀 구성하기

- 먼저, 전부 아는 내용이라 코드를 복붙해보겠습니다. 복붙하고 Command + I 를 통해 코드 정리해주세요~!

```swift
@State private var wakeUp = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)
                
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                
                Text("Daily coffee intake")
                    .font(.headline)
                
                Stepper(value: $coffeeAmount, in: 1...20) {
                    if coffeeAmount == 1 {
                        Text("1 cup")
                    } else {
                        Text("\(coffeeAmount) cups")
                    }
                }
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedtime ){
                                        Text("Calculate")
                                    }
            )
            
        }
    }
    
    func calculateBedtime() {
      
    }
```

- 여기서 특이했던 점은 Button을 만드는 방식에서 두가지 방법이 가능했다는 점입니다. 아래와 같이요!

  ```swift
  Button(action: calculateBedtime) {
      Text("Calculate")
  }
  
  Button("Calculate") {
      self.calculateBedtime()
  }
  ```

### CoreML을 프로젝트에 적용시키기

- CoreML 모델을 프로젝트에 추가시키셨나요?! 
- 일어나고 싶은 시간, 원하는 수면 시간, 하루에 마시는 커피잔수를 입력받고 이를 모델에 집어넣은 후 추천 값이 나오게 할 거예요.
- 먼저 Model이 어떻게 이루어졌는지 알아보러갑시다.

<img width="924" alt="image" src="https://user-images.githubusercontent.com/56102421/102894430-6eda6b00-44a6-11eb-8be6-830abba84a77.png">

- 이런식으로 개발자님께서 학습을 시켜주셨네요!

- 그럼 이제 아래 코드를 통해 이 모델을 가져와볼게요.

  ```swift
  let model = SleepCalculator()
  ```

- 그리고 이 모델에 집어넣을 세가지 값들을 가져와 보겠습니다. 아,, 세가지 값이 아니라 깨어나고 싶은 시간만 가지고 올게요! 이것만 커스텀이 필요해서요!

  ```swift
  let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
  let hour = (components.hour ?? 0) * 60 * 60
  let minute = (components.minute ?? 0) * 60
  ```

- 이제 이를 모델에 집어넣어 보겠습니다. 여기서는 do, catch문이 필요한데 model에 들어가서 오류가 발생할 수 있기 때문이에요. 근데 오류가 지금까지 단한번도 발생하지 않았답니다.

  ```swift
  do {
      let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
  
      // more code here
  } catch {
      // something went wrong!
  }
  ```

- 네. 이제 거의 다왔어요.

- 자는 시간을 계산해야죠. 모델에서 나오는 값은 실제 자는 시간을 wakeup에서 뺴면 수면에 들어가야하는 시간이 나옵니다! 아래 코드도 추가해주세요.

  ```swift
  let sleepTime = wakeUp - prediction.actualSleep
  ```

- 이제 button을 눌러 이 모델이 실행되도록 해보겠습니다. 아까만들어준 버튼을 통해 alert를 띄울 거예요.

- alert안에 들어갈 내용을 선언해줍니다.

  ```swift
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  ```

- 그리고 실패했을 때 catch문에는 아래의 코드를 집어넣고

  ```swift
  alertTitle = "Error"
  alertMessage = "Sorry, there was a problem calculating your bedtime." 
  ```

- do catch 문이 끝나면 alert가 생성되도록 만들어줍니다.

  ```swift
  showingAlert = true
  ```

- 마지막으로 성공했을 때는 아래와 같은 메세지를 띄우게 해줘요.

  ```swift
  let formatter = DateFormatter()
  formatter.timeStyle = .short
  
  alertMessage = formatter.string(from: sleepTime)
  alertTitle = "Your ideal bedtime is…"
  ```

- 잘 따라오셨다면 완성된 함수는 아래와 같아요.

  ```swift
  func calculateBedtime() {
          
          // 모델 instance 생성
          let model = SleepCalculator()
          
          let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
          let hour = (components.hour ?? 0) * 60 * 60
          let minute = (components.minute ?? 0) * 60
          
          do {
              let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
  
              
              let sleepTime = wakeUp - prediction.actualSleep
              
              let formatter = DateFormatter()
              formatter.timeStyle = .short
  
              alertMessage = formatter.string(from: sleepTime)
              alertTitle = "Your ideal bedtime is…"
          } catch {
              
              alertTitle = "Error"
              alertMessage = "Sorry, there was a problem calculating your bedtime."
          }
          
          showingAlert = true
          
          
          
      }
  ```

- 이제 버튼을 눌렀을때 alert가 구현되게 코드를 짜주면 됩니다. 아래 코드를 navigationBarItem에 붙여주세요~!

  ```swift
  .alert(isPresented: $showingAlert) {
      Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
  }
  ```

  <img width="50%" alt="image" src="https://user-images.githubusercontent.com/56102421/102895329-d644ea80-44a7-11eb-97fd-95abcf537ce4.png">

짠!!⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️

## 이상한 점들 고치기!

- 이제 다 만들었다고 생각했는데 더 있었어 하하

- 먼저 wakeup 시간!! 저건 현재 시간이 보여지도록 만들어놓았는데 이 개발자는 이게 이상하다고 만약에 밤이면 일어나는 시간이 밤시간을 찍힐거라고 이상하다고 말합니당..(난 별 상관없는데 ㅎㅎ) 그래서 이를 항상 7시가 되도록 표현해주겠습니다!

- 먼저 아래 코드를 넣어주세요!

  ```swift
  var defaultWakeTime: Date {
      var components = DateComponents()
      components.hour = 7
      components.minute = 0
      return Calendar.current.date(from: components) ?? Date()
  }
  ```

- 그 후 defaultWakeTime은 바뀌는 값이 될것이니 state선언을 해줍니다.

  ```swift
  @State private var wakeUp = defaultWakeTime
  ```

- 이 때 오류가 ㅂ라생하는데 이 이유는 이클래스가 생성될때 서로 의존하는 변수가 같이 만들어지기 떄문입니다. 그래서 defaultWakeTime을 static처리를 해준다면 이는 어디에서나 접근가능하게 만들어주었으니 오류가 사라집니다!!

  ```swift
  static var defaultWakeTime: Date {
  ```

- 이제 UI가 더 이뻐지게 고쳐보면 VStack을 Form으로 고쳐봅니다.

  ```swift
  NavigationView {
      VStack {
  
  NavigationView {
      Form {
  ```

- 아래와 같이 정리되서 나와요!

<img src="https://user-images.githubusercontent.com/56102421/102896349-954dd580-44a9-11eb-8f8f-9672f21e5d41.png" width="50%" />

- 여기서 datePicker를 이제 옛날꺼로 바꿔볼게요!! 이 코드를 추가해줘요 ㅎㅎ

  ```swift
  .datePickerStyle(WheelDatePickerStyle())
  ```

- 이제 같은 항목은 같은 라인에 있게 VStack을 통해 Unwrap해줍니다.

- ```swift
  VStack(alignment: .leading, spacing: 0) {
      Text("Desired amount of sleep")
          .font(.headline)
  
      Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
          Text("\(sleepAmount, specifier: "%g") hours")
      }
  }
  ```

- 이렇게 된다면!! 드디어 이뻐졌어요.

  <img width="50%" alt="image" src="https://user-images.githubusercontent.com/56102421/102896792-4c4a5100-44aa-11eb-81d4-1e753153b41c.png">

