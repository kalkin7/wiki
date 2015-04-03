---
layout: post
title: 라즈베리파이 2
description: "라즈베리파이 정보 모음. Kodi 머신으로 쓸 때의 정보 위주"
category: IT
tags: [ raspberry-pi ]
published: true
---

* TOC
{:toc}


## 개요

집에서 미디어 플레이어로 쓸 요량으로 구입했다. 그래서 이 항목에서는 라즈베리파이 2를 어떻게 미디어 플레이어를 쓸 수 있는지에 대해서 주로 쓸 예정이다.

### 라즈베리파이 소개

영국 라즈베리 파이(Raspberry Pi) 재단에서 만든 초소형/초저가 PC이다. 교육용 프로젝트의 일환으로 개발되었으며, 이 때문에 RCA 연결 잭을 가지고 있다. 2012년 3월에 출시되었는데, 1시간만에 매진되는 진풍경을 보여줬다. 2013년 11월 기준 200만대 이상이 팔렸다.[^1]

[라즈베리 파이 홈페이지](http://www.raspberrypi.org/)



### 라즈베리파이 2 스펙

| 사양      | 2 모델 B                         |
|-----------|----------------------------------|
| SoC       | Broadcom BCM2836 SoC             |
| CPU       | 900 MHz ARM Cortex-A7 쿼드코어   |
| GPU       | 900 MHz ARM Cortex-A7 쿼드코어   |
| 메모리    | 1 GB LPDDR2                      |
| 네트워크  | 10/100 Mbit 이더넷               |
| 영상 출력 | 컴포지트 HDMI(rev 1.3 & 1.4) DSI |
| 음성 출력 | 3.5mm 잭, HDMI, I²S              |
| USB 지원  | 4포트                            |
| GPIO      | 40핀                             |
| 기타지원  | UART, I²C버스 칩 선택 가능한 SPI |
| 규격      | 85.60 × 56.5 mm, 45 g            |


### 라즈베리파이용 OS






## 라즈베리파이 2를 미디어 플레이어로 만들기

### 준비물

– 라즈베리파이2
– HDMI 케이블
– 4GB 이상의 Micro SD 카드
– 5핀 충전기(2000mA 이상)
– 마우스
– 랜 케이블 or Wifi 동글
– 기타: 라즈베리파이2 케이스(B+ 케이스와 호환), 방열판


### OS 선택

[OSMC](https://osmc.tv)와 [Openelec](http://openelec.tv/) 그리고 [xbian](http://www.xbian.org/) 중에서 선택하기로 했다. 모두 이미 라지베리파이 2용으로 만든 OS 이미지를 제공하고 있었지만 OSMC는 아직 정식 버전이 안 나왔고, xbian은 아직 좀 불안하다는 얘기가 있어서 Openelec를 선택했다.


### Openelec 설치

1. [Openelec](http://openelec.tv/)에 접속해서 최신 버전으로 다운로드. 라즈베리파이 2는 [다운로드 페이지](http://openelec.tv/get-openelec)로 접속해서 **ARMv7 builds** Diskimage를 다운 받으면 된다.
2. [Win32DiskImager](http://sourceforge.net/projects/win32diskimager/)를 다운받아 설치한다.
3. 다운받은 Openelec 최신 이미지를 압축 프로그램을 이용하여 압축해제한다.
4. Micro SD 카드를 리더기등을 이용해서 윈도우즈 인식시킨 후 Win32DiskImager를 실행한다.
5. Win32DiskImager에서 Micro SD 카드가 인식된 드라이브 레터를 선택한 후, Openelec 최신 이미지를 불러오고 하단의 **write**버튼을 클릭한다.
6. 필요에 따라 config.txt 파일을 편집해서 설정을 조정한다.


### Openelec config.txt 수정을 통한 성능 향상

먼저 **gpu에 할당할 램의 양**을 수정한다.

**gpu_mem_1024**의 값을 **256**에서 **320**으로 수정한다.

다음은 **오버클럭킹**이다. 다음 값을 수정해서 오버클럭킹을 할 수 있다. 아래가 기본값이다. 

	arm_freq=700
	core_freq=250
	sdram_freq=400
	over_voltage=0

제조사에서 제공하는 프리셋은 다음과 같다.

**1\. Medium 모드**

	arm_freq=900
	core_freq=333 
	sdram_freq=450
	over_voltage=2

**2\. High 모드**

	arm_freq=950
	core_freq=450 
	sdram_freq=450
	over_voltage=6

**3\. Turbo 모드**

	arm_freq=1000
	core_freq=500 
	sdram_freq=500
	over_voltage=6

나는 [검색을 통해 얻은 정보](http://iluku.net/blog/archives/3120)로 다음과 같이 세팅했다.

	arm_freq=1000
	core_freq=500
	sdram_freq=500
	over_voltage=2

	arm_freq_min=400
	sdram_freq_min=250
	core_freq_min=250

여기에 추가적으로 다음 설정도 적용했다.

	initial_turbo=30


또한 다음 설정도 적용했다.

	# 단일 USB 외장하드 인식
	max_usb_current=2
	safe_mode_gpio=4

	# 무지개 부팅 화면 삭제
	disable_splash=1



### MPEG-2, VC1 라이센스 적용

라즈베리파이에는 MPEG-2, VC1 코덱이 비활성화되어 있다. 비용 때문이다. 그래서 MPEG-2, VC1 코덱을 활성화하려면 라이센스 키를 사서 따로 적용해 주어야 한다.

1. 먼저 자신이 가지고 있는 라즈베리파이 기기의 시리얼 번호를 알아내야 한다. ssh로 접속해서 **'cat /proc/cpuinfo'**와 같은 명령어를 입력하면 마지막에 시리얼 번호가 출력된다. 또한 Kodi의 시스템 정보에서도 라즈베리파이의 시리얼 번호를 알 수 있다.
2. [라즈베리파이 라이센스 구입 페이지](http://www.raspberrypi.com/license-keys/)에 접속해서 구입한다. 이 때 **1**에서 알아낸 시리얼 번호를 입력해야 한다.    
![라즈베리파이 라이센스 구입 페이지](https://lh5.googleusercontent.com/-tyyJNHWOyYk/VR5-VI3-MSI/AAAAAAABr0o/l2S1edoKwMo/s0/Raspberry-pi-licence-01.png)    
▲ 라즈베리파이 라이센스 구입 페이지     
![라즈베리파이 라이센스 구입시 시리얼 입력](https://lh3.googleusercontent.com/-tt06t2ciELw/VR5-qdirefI/AAAAAAABr0w/q9-cvVw09Vo/s0/Raspberry-pi-licence-02.png)     
▲ 라즈베리파이 라이센스 구입시 시리얼 입력
3. 이제 72시간 안에 라이센스 코드를 이메일로 보내준다. 그럼 그 코드를 config.txt 맨 아래에 입력해준다.
4. 라이센스가 제대로 설치되었는지 확인하려면 다음과 같이 한다. 먼저 ssh로 접속하거나, 본체에 직접 키보드를 사용해서 **'vcgencmd codec_enabled MPG2'**와 같은 명령어를 입력한다. 그런 후 **'MPG2=enabled'**라고 출력되면 제대로 설치된 것이다.
5. 이제 DVD가 제대로 플레이될 것이다.







[^1]: 리그베다위키에서 발췌 [https://mirror.enha.kr/wiki/라즈베리 파이](https://mirror.enha.kr/wiki/%EB%9D%BC%EC%A6%88%EB%B2%A0%EB%A6%AC%20%ED%8C%8C%EC%9D%B4)