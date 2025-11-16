## 프로젝트 구조(요약)
- lib/
    - core/            : 전역 설정/기초 타입 (`config.dart`, `result.dart`)
    - base/            : 디자인/네비/네트워크 공통 (`theme/`, `navigation/`, `network/`, `logger.dart`)
    - data/
        - db/
            - app_database.dart           : Drift DB 초기화 및 마이그레이션
            - tables/tables.dart          : Drift 테이블(Counters, Todos)
            - daos/                       : DAO (타입세이프 DriftAccessor)
            - models/                     : 화면/도메인에서 쓰는 단순 모델
        - repositories/                 : Repository 구현체 (DB/네트워크 의존)
    - domain/
        - entities/                     : 순수 도메인 엔티티
        - repositories/                 : Repository 인터페이스
        - usecases/                     : 유스케이스 
    - presentation/
        - home/                         : 홈(메뉴) 화면 Provider/VM
        - counter/                      : 카운트 화면
        - todo/                         : TODO 화면(추가/수정/삭제)

## 역할과 흐름
- UI(Widget) → ViewModel(StateNotifier) → UseCase → Repository → DAO/네트워크
- ViewModel은 비즈니스 액션을 “UseCase”로 의존해 의도를 명확히 함
- Repository는 데이터 소스(Drift/네트워크)를 캡슐화

## 패턴
- 아키텍처: Clean Architecture + MVVM
- 상태관리: Riverpod(StateNotifier)
- DB: Drift(코드생성), 마이그레이션: `schemaVersion` + `onUpgrade`
- 네트워크: Dio(+ Retrofit 예시), 인터셉터/로깅은 `base/network/`

## Riverpod 사용법(간단)
1) Provider 선언
```dart
final counterRepositoryProvider = Provider<CounterRepository>((ref) {
  final dao = ref.watch(countersDaoProvider);
  return CounterRepositoryImpl(dao);
});
```
2) ViewModel(StateNotifier) Provider
```dart
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final get = ref.watch(getCounterProvider);
  final inc = ref.watch(incrementCounterProvider);
  final reset = ref.watch(resetCounterProvider);
  final vm = HomeViewModel(getCounter: get, incrementCounter: inc, resetCounter: reset);
  vm.load();
  return vm;
});
```
3) 위젯에서 사용
```dart
final state = ref.watch(homeViewModelProvider);
final vm = ref.read(homeViewModelProvider.notifier);
```

## Drift 코드생성
- 아래 명령 실행 후 타입세이프 심볼/믹스인 사용 가능
```
flutter pub run build_runner build --delete-conflicting-outputs
```

## 네비게이션
- 전역 `navigatorKey` + `onGenerateRoute` 사용
- 안전 이동 유틸: `NavigationService.pushNamedSafe`, `context.popSafe()`

## 빌드 러너 커맨드
dart run build_runner build --delete-conflicting-outputs
flutter pub run build_runner build — delete-conflicting-outputs;

## 패키지 추가
flutter create --template=package packageName
packageName에 패키지 이름을 넣는다. ex) flutter create --template=package splash

## ios 빌드 에러시 조치
cd macos
rm -rf Podfile.lock
rm -rf Pods
rm -rf ~/Library/Developer/Xcode/DerivedData/*
pod deintegrate
pod install
pod cache clean --all
pod install --repo-update --clean-install

## FVM 통해서 flutter version 설정
아래에 블로그 참조 하시면 됩니다.
https://dev-yongsu.tistory.com/30
추가적으로 원하는 flutter version 설치후 use 커맨드 사용해야 합니다.
fvm install <version>
fvm use <version>

pub get 또는 build_runner 진행시 앞에 fvm 붙여서 커맨드 입력하셔야 됩니다.
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs

## 앱 아이콘 빌드
flutter_launcher_icons.yaml을 편집 후, 다음 두 커맨드를 실행한다.
flutter pub run flutter_launcher_icons -f flutter_launcher_icons.yaml
flutter pub run flutter_launcher_icons

## 시스템 스플래시 편집
flutter_native_splash.yaml를 편집 후, 다음 커맨드를 실행한다. flutter로 실행하면 안되고 dart로 실행해야 한다.
dart run flutter_native_splash:create