# XOR 문제 딥러닝으로 풀기

- XOR을 Neural Network로 풀어보자!!
- Logistic 회귀 모델 하나로는 절대로 XOR을 풀 수 없다.
- 로지스틱 회귀모델 여러개로 가능할 순 있지만 bias를 하나씩 바꿔가면서 학습시키게 하는 것은 불가능하다.

- 문제를 한번 해결해보자.
- 해결하는 [과정](https://www.youtube.com/watch?v=GYecDQQwTdI&list=PLlMkM4tgfjnLSOjrEJN31gZATbcj_MpUm&index=25)은 영상을 통해 확인을 하자.
- 아래 사진처럼 해결 가능하다.

![image-20210203182727750](/Users/jyong/Library/Application Support/typora-user-images/image-20210203182727750.png)



- 만약 그렇다면 위의 W, b 말고 다른 값들이 존재할 수 있을까?!!

- 네! 있습니다.

- 또한 이 NN을 Multinomial 방식으로 더 줄일 수 도 있다.

  ![image-20210203183013246](/Users/jyong/Library/Application Support/typora-user-images/image-20210203183013246.png)

- 이런방식으로 말이다!

- 그럼 XOR문제를 이제 NN을 이용해서 풀 수 있다는 것을 알았다.
- 그럼 어떤 방식으로 학습을 해볼 수 있을까?
- **Back propagation(chain rule)** 을 이용할 수 있다.
- 이 모든 알고리즘은 코드를 통해 알아볼 수 있다.