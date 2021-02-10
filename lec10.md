# lec10 

- Sigmoid 보다 ReLu가 더 좋아 
- Weight 초기화 잘해보자
- Dropout 과 앙상블
- 레고처럼 넷트윅 모듈을 마음껏 쌓아 보자



## Sigmoid 보다 ReLu가 더 좋아 

- 문제점 : 2, 3단 네트워크는 잘 학습이 되지만, 9단계 이상의 네트워크처럼 층들이 많을수록학습이 되지 않음 
  - 실제로 accuracy가 0.5보다 작게 나옴
- 원인 : x를 집어넣어서 이 x가 최종 f에 미치는 영향을 알기 위해서 계속 미분을 해준다. 단계마다 계속 미분을 해주어 나오는 결과값이 x보다 계속 작아지게되어 0에 가까운 값이 계속 곱해질 것이다. 결국 최종적인 입력에서 굉장히 작은 값이 되고, 또한 경사의 기울기가 사라지는 문제점도 발생하게 되었다.
- 해결 : Sigmoid함수를 잘못 쓴 거 같다!!! Sigmoid는 입력값을 주면 결과는 항상 1보다 작게 나온다. 그래서 위와 같은 문제점을 야기하기 떄문에 0보다 작을경우는 버리고, 0보다 클 경우 값이 비례한 결과를 내는 ReLu함수를 도입하자.

<img src="https://blog.kakaocdn.net/dn/bcxkor/btqu6ND0UFt/UNFUAyvK6n4yORIGTxMD7k/img.png" />

- NN에서는 더이상 Sigmoid를 사용하면 좋지 않지만 마지막 단에서는 sigmoid함수를 사용하여야한다. (출력값은 항상 0~1사이여야 하기 때문)



## Weight 초기화 잘해보자

- Vanishing gradient문제가 있었는데 해결 방법엔 두가지가 있다.
- 하나는 위의 ReLu함수를 이용하는 것이고
- 다른 하나는 weight 초기값을 잘 정하는 것이다!
- 초기값은 0이 된다면 네트워크가 깊어질수록 학습이 되지 않는다! 
- 초기값을 잘 주기 위해서 RBM과 함께 설명하고 있다. 

<img src="https://t1.daumcdn.net/cfile/tistory/251E744B57A007682B" />

- 굉장히 자세하게 설명하셨는데 초기값을 실제로 주는 방법도 정말 복잡하다.
- 하지만, 굳이 복잡한 형태의 초기화를 하지 않아도 비슷한 결과를 낼 수 있다고 한다.
- Xavier 초기화와 xavier초기화를 응용한 He 초기화가 있다. 이 두가지 초기화 방법은 놀랄 정도로 단순하고, 결과가 좋다고 한다.

<img src="https://t1.daumcdn.net/cfile/tistory/2777CD4E57A0077436" />

- 단 두줄로 초기화를 잘 할 수 있다고 한다.



## Dropout 과 앙상블

- Overfitting의 문제점 존재

- Overfitting을 확인하는 방법 : 층의 개수가 어느 정도일 때는 잘 동작하지만, 그 어느정도를 넘어가는 순간부터 오차가 증가하는 모습을 보인다.  즉, 학습데이터에선 99퍼센트의 예측을 보이지만, test에선 85퍼센트의 예측률을 보일 수 있다.

- Overfitting을 방지하는 방법 : 

  - training data를 많이 모으기
  - feature의 개수를 줄이기
  - 정규화!!!

- 정규화 (Regularization)

  - 너무 구부리지말고 피는 방법

- Overfitting을 막는 또 다른 방법 : Dropout

  - NN을 학습할 때 연결된 것을 끊어버리는 것

  - 몇 개 노드를 죽이는 것

  - Tensorflow구현

    <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdK4wSV%2FbtqvzwpnVf9%2FMHakkkg2ryEFjEJyPDKFCk%2Fimg.png" />

- 앙상블 

  - 학습할 수 있는 장비가 많을 때 사용할 수 있다.
  - 그니까 여러개의 독립적인 NN에 테스트를 돌려보는 것이다.



## 레고처럼 넷트윅 모듈을 마음껏 쌓아 보자

- NN의 구조를 우리가 다양하게 구성가능하다.
  - Fast forward
    - 출력을 뽑아서 두 단 앞으로 추가 시키는 구조
  - Split & merge
    - 출력을 두개로 나누거나, 합치거나, 연산을 넣거나, 갈라지거나 등등으로 결과 예측시키는 구조
  - Recurrent NN
    - 옆으로 펼친 모듈 

