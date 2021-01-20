# 딥러닝 스터디 



- 텐서플로우는 data flow graphs를 이용해 numerical 계산을 위한 오픈 소스 라이브러리고, 파이썬으로 사용이 가능하다.
- graphs는 노드와 엣지로 이루어진 형태를 말하는데 Data flow graph도 비슷한 형태를 의미한다. 
-  

## Logistic Classfication

- 이 알고리즘은 다른 것들에 비해 정확도가 높다.
- 딥러닝을 이해하는데 정말 중요하다.

### 복습

- 먼저 이전 시간의 선형 회귀(Linear Regression)에 대해 먼저 복습해보자

<img src="https://user-images.githubusercontent.com/56102421/105161801-21105b80-5b55-11eb-91b8-42c585b6696f.png" />

- 먼저 저 y값, 점수형태의 값들을 예측하는 것을 회귀라고 하고 이를 선형으로 가설을 세우고 실제 학습데이터와 가설로 만든 선을 비교하여 그 차이를 구해 평균을 낸 것을 Cost라고 했습니다. 
- 여기서, 기계가 학습한다는 것은 저 Cost식의 최솟값을 만드는 W를 찾아낸다는것이고 그래서 Cost함수를 그래프로 그려보면 위 그림의 형태를 가진 그래프가 나옵니다. 
- 여기서 최솟값을 구하기 위해 Gradient decent 알고리즘을 도입했었습니다!! (정확도를 위해 learning rate 값 중요)

### Logistic Classification이란?

- 이전 시간에 배운 것은 단순히 숫자를 예측하는 것이라면 이번 시간에 배울 Classification은 둘 중에 하나를 고르는 것이다! 
- 예를 들어, Spam이냐 아니냐. 패북 피드를 보여줄것인가 숨길 것인가 등이 있다.
- 최근 정말 많이 사용되고 있는 방법인데 주식시장이나 의료쪽에서도 많이 쓰이고 있다!!!
- 예제로는 간단하게 시험공부시간에 따른 합격여부를 들어보자

<img src="https://user-images.githubusercontent.com/56102421/105161759-15249980-5b55-11eb-86cc-cebac5d98f02.png" />

- 0이 불합격, 1이 합격으로 나뉘는데 이도 Linear Regression으로 표헌이 가능하다. 하지만 문제점이 있습니다.

  - 0과 1의 y값밖에 없다고 가정하고 H(x) = Wx로 표현하면 y가 0.5일때의 부분이 존재하고 그것을 중심으로 0과 1을 나눈다고 할 때 학습데이터에 따라서 그 기준선이 변화할 수 있다.
  - 또 갑자기 매우 큰 값이 X로 들어올 경우 모양이 좋지가 않았다.

- 그래서 0과 1사이로 rufrhkrk 항상 나오게 할 수 없을까 하는 고민에서 나온 것이 sigmoid 함수입니다. 다른말로 logistic function이라고 합니다.

  - 아무리 X값이 커져도 1에 가까워지고, 작아져도 0에 가까워지는 형태

  <img src="https://user-images.githubusercontent.com/56102421/105161718-0a6a0480-5b55-11eb-842a-2c2d97ee5773.png" />

- 그럼 이제 위 식을 Logistic Classification의 가설 식이라고 하고 Cost 함수를 만들면 아래와 같아요.

<img src="https://user-images.githubusercontent.com/56102421/105161667-f920f800-5b54-11eb-97e5-15d48f1a8253.png" />

- 이제 이를 이전에 했던 방법처럼 최솟값을 만드는 W값을 알아내야 해요.
- 같은 형태이지만 다른 점이 있다면 Logistic의 가설 식은 0~1의 값만 가지기 때문에 그래프가 굉장히 울퉁불퉁해집니다(이건 왜이런지 잘 모르지만 외우자 ㅠㅠ 왜 이런지 아시는 분??!?! 그냥 구부러진게 들어간다..라고만 설명해줌)
- 여기서 Gradient알고리즘을 사용해버리면 중간에 멈춰버릴 수 있어요. 이렇게 학습이 멈춰버리면 우리가 만든 모델은 정확도가 굉장히 떨어져요.
- 그래서 나온 것이 바로!! 새로운 Cost 함수! 아래 식입니다!

<img src="https://user-images.githubusercontent.com/56102421/105161606-e5759180-5b54-11eb-921a-227ac51b09b2.png" />

- 일단 간단히 이해한 바를 얘기하자면 학습데이터에 따라서 나오는 결과값이 1일때와 0일때를 다른 cost함수를 쓰는 것이다. 그래서 그에 따라 0과 무한이 나올 수가 있는 것입니다!!

- 이를 직접 텐서플로우로 프로그래밍을 하기위해서 더 편하게 만든 수식이 아래와 같습니다

<img src="https://user-images.githubusercontent.com/56102421/105161563-dabafc80-5b54-11eb-8875-cc602ac56151.png" />

- 이렇게 Cost 함수가 주어지면 이제 울퉁불퉁한 그래프가 다시 매끈해지게 돼요. 그럼??? 이제 우리가 원래 알던 Gradient decent algorithm을 써주면 돼요.
- 미분하고 이것저것 하게되면~~ (사실 이건 컴퓨터가 다해주기때문에 사실만 알면됩니당)
- 실제 프로그래밍을 할땐 Gradient알고리즘은 그냥 라이브러리를 사용하고 알파값을 조절하면서 현재 가지고 있는 weight를 업데이트 시키면 됩니당













## Softmax classification

- 여러개의 클래스가 있을 때 그것을 예측하는 것이 Multinomial classification이고 그 중에서도 가장 많이 사용되는 것이 Softmax Regression이다!
- 오늘은 이것에 대해 알아볼 것입니다.
- 지난 시간엔 Logistic Regression Classification을 알아보았습니다 

### 복습

- 출발은 Linear 가설을 세웠지만, binary에 적합하지 않았기 때문에 sigmoid함수를 도입하여 0~1사이의 값으로 압축시켜주어 Cost 함수를 구했었습니다!!
- 이를 간단하게 그림으로 표현하면 아래와 같아요.

<img src="https://user-images.githubusercontent.com/56102421/105161511-ce36a400-5b54-11eb-9eb9-52f493f530c4.png" />

- 우리가 만든 가설식에 X를 넣고 Z값이 나오면 이를 다시 S(시그모이드)에 집어넣어 0~1사이의 값이 나온다는 것을 나타낸다. 



### Multinomial Classification

- 이건 어떤 상황인가?
- 이 분류는 여러가지의 변수들에 의하여 2개뿐만이 아니라 3개이상의 정수 결과값이 나오는 것이다. 
- 예를 들어, 공부시간, 학생수에 따른 학점이 있다.
- 이것도 마찬가지로 Logistic Regression으로 구현이 가능하다. A이거나 아니거나, B이거나 아니거나, C이거나 아니거나 로 나타낼 수 있다.
- 즉, 이렇게 계산을 하게된다면 아래와같이 한번에 행렬식으로 계산을 할 수 있고, 이렇게 되면 A, B, C의 각각의 H(x)를 구할 수 있게 된다. 

<img src="https://user-images.githubusercontent.com/56102421/105161418-b52df300-5b54-11eb-9c94-577fe766c3a8.png" />

- 그럼 여기서 나온 Ya, Yb, Yc 는 0~1 사이의 값이 되어야 한다. 
- 여기서 쓰이는 것이 SoftMax 함수이다.

<img src="https://user-images.githubusercontent.com/56102421/105161370-a8110400-5b54-11eb-8e80-a056598d5976.png" />

- 위 그림이 SoftMax 함수여서 나오는 점수를 확률로 바꿔주고 이를 또 ONE-HOT-ENCODING이라는 기법을 이용해서 A가 나오겠다!라고 판단해줍니다.

<img src="https://user-images.githubusercontent.com/56102421/105161329-9a5b7e80-5b54-11eb-8cfa-5379cc9ecf4b.png" />

- 여기까지 이해가 되었다면 이제는 Cost Function을 만들어주어해요.
- 그 Cost Function은 또 아래와 같다고 하네요.. 이를 Cross Entropy라고 하고요.

<img src="https://user-images.githubusercontent.com/56102421/105161281-8a439f00-5b54-11eb-9a7b-a38d00493881.png" />

- 이건 쪼금 특이한데 실제 Y값을 빼주는 것이 아니라 곱해주네요?!!?!?
- 자세한 설명은 강의를 보고 이해했을 거라 생각하고 넘어가겠습니다!
- 여기서 Logistic cost와 Cross entropy Cost 함수는 같은 것이라고 설명합니다! 이 이유에 대해서는 음 제가 생각하기엔 logistic에선 A인지 아닌지를 판단하여 1과 0으로 나누고 cross entropy에선 A인지 B인지를 확률로 1과 0으로 표현하기 때문에 결과적으로 식을 세웠을 때 지워지는 부분이 같기 때문인 것 같네요.
- 그래서 이제 진정한 이 Entroy 의 평균을 구해서 Cost Function을 세워보면 아래와 같아요.

<img src="https://user-images.githubusercontent.com/56102421/105161207-739d4800-5b54-11eb-8ada-35253661f9c5.png" />

- 이제 마지막 단계.. 지겨운 단계... Gradient decent알고리즘을 이용해서 최소일때의 W값을 구해주면 됩니다.
- 미분은 컴퓨터가 해주는 거니까 넘어갈게요~



## Application & Tips: Learning rate, data preprocessing, overfitting

- 이번 시간엔 이 분류 방식들을 실제로 사용할 때 팁들에 대해서 다루었습니다.

### Learning rate

- 앞에서 보셧듯이 Gradient descent알고리즘을 사용해서 최솟값을 구할 때 미분값 앞에 곱해주는 것이에요.
- 이 learning rate를 이제 간단히 lr라고 적을게요. 이 lr은 경사면을 내려가는 step이라고 생각해볼게요.
- lr이 크다면 step이 커지고 발산하게 되고 이를 overshooting 이라고 합니다!

<img src="https://user-images.githubusercontent.com/56102421/105161103-57011000-5b54-11eb-8aeb-ea8a2ae68d4a.png" />

- lr이 작다면 step이 작아져서 결국 학습에 시간이 오래 걸리고, 어쩔 경우엔 중간에 멈춰버릴수도 있습니다.
  - 이를 방지하기 위해선 cost함수를 출력해보아서 너무 조금씩 움직이면 크게, 발산해버리면 작게 움직이면 된다.
  - 지금 텐서플로우가 안깔려서 lab을 못해보는상황...하하 해보신분 알려주세요.

### data processing

- 데이터를 선처리해줘야하는 이슈!

<img src="https://user-images.githubusercontent.com/56102421/105161063-4bade480-5b54-11eb-85b7-3a4330a4ebc6.png" />

- 데이터가 차이가 너무 크다면, 위의 그림처럼 나오지 않고 왜곡된 형태의 그래프가 나타나게 된다.
- 이럴 경우, gradient알고리즘이 적용되지 않을 수 있다. 
- **해결방법**은 zero-centered data 와 normalized data로 데이터를 전처리해주면 된다!

<img src="https://user-images.githubusercontent.com/56102421/105161009-3d5fc880-5b54-11eb-8662-af184e589fa8.png" />

- 데이터의 평균과 표준편차를 구해서 위와 같이 일반화시켜주면 된다.

### overfitting

- 머신러닝은 학습을 통해 모델을 만드는 것이다. 그래서 이 문제는 학습이 너무 잘되어서 나타나는 문제점이다.

<img src="https://user-images.githubusercontent.com/56102421/105160929-2620db00-5b54-11eb-806d-836c2de40a9e.png" />

- 위 그림의 경우와 같이 현재 학습데이터에만 너무 잘 fit되어진 경우의 모델이 overfitting되었다라고 표현해요.

- 이를 방지하려면

  - 많은 학습 데이터

  - 중복된 feature를 줄인다.

  - **Regularization(일반화)**

    - weight를 너무 크게 잡지 말아야한다.
    - 이렇게 하기 위해선 아래 식에서 뒤의 식을 더해주면 된다. 
    - <img src="https://user-images.githubusercontent.com/56102421/105160881-16a19200-5b54-11eb-92ce-81f67c62fde0.png" />
    - regularization strength -> 0 이면 일반화가 굳이 필요없다. 1이면 무조건 필요하다! 라는 의미

    - 텐서플로우에선 아래와 같이 간단하게 표현 가능하다고 나와요.

    <img src="https://user-images.githubusercontent.com/56102421/105160834-0a1d3980-5b54-11eb-8d75-bf8735fcf882.png" />

    

### Machine Learning Model

- Training and test sets
  - 학습시킨 데이터로 다시 테스트를 보면 100% 정확도가 나옵니다.
  - 그래서 데이터가 있다면 70%는 Training data, 30%는 test set을 주어 accuracy를 구해서 모델의 정확도를 구합니다.
  - 마치 Training data는 교과서, test set은 실전 문제라고 생각하면 됩니다.
- 아까 배운 learning rate와 정규화 람다값을 조절할 때 필요한 데이터가 있어야 하므로 아래와 같이 Validation data를 또 나눠서 튜닝값들을 조절합니다.

<img src="https://user-images.githubusercontent.com/56102421/105160756-f540a600-5b53-11eb-9f31-baf652bb8887.png" />

- - 학습데이터가 100만개가 있다면 이를 한번에 다 학습시키지 않고 10만개씩 쪼개서 학습시키는 것이다. 
  - 이 모델의 가정은 이전에 학습시킨 데이터들이 남아있다는 점이다. 
  - 이 모델의 장점은 수년이 지나서 또 데이터가 생겼을 때 그냥 추가하면 된다는 점이다.
- MINIST Dataset
  - 이거 지난번에 직접 해봤는데 이번엔 안깔려서 직접 못해보네요 ㅠㅠ 해보신 분 알려주세요.. 자랑좀 해주세요
- Accuracy
  - 측정하는 것 중요합니다~~!!!



- 그래서 이번 시간까지 머신러닝의 기본 개념에 대해서 알아보았다고 하네요.. 다음 시간부터 딥러닝에 대해서 배울건가봐요... 
- 파이썬 텐서플로우가 안돌려지는데 큰일났네요^^..