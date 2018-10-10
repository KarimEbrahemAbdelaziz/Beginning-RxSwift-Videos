
import RxSwift

example(of: "Create Observables") {
    let mostPopular = Observable<String>.just(episodeV)
    let originalTrilogy = Observable.of(episodeI, episodeV, episodeVI)
    let prequalTrilogy = Observable.of([episodeI, episodeV, episodeVI])
    let sequalTrilogy = Observable.from([episodeI, episodeV, episodeVI])
}

example(of: "Subscribe") {
    let observable = Observable.of(episodeI, episodeV, episodeVI)
    
    // Listen to observable and print events
    observable.subscribe { event in
        print(event)
    }
    
    // Listen to observable and print value if there, or print event
    print("-------------------------------------")
    observable.subscribe { event in
        print(event.element ?? event)
    }
    
    // Listen to observable on onNext event only and print value
    print("-------------------------------------")
    observable.subscribe(onNext: { (value) in
        print(value)
    })
}

example(of: "Empty Observable") {
    // Observable that only completed
    let observable = Observable<Void>.empty()
    observable.subscribe(onNext: { (value) in
        print(value)
    }, onCompleted: {
        print("Completed")
    })
}

example(of: "Never Observable") {
    // Finite observable no ended :D
    let observable = Observable<Any>.never()
    observable.subscribe(onNext: { (value) in
        print(value)
    }, onCompleted: {
        print("Completed")
    })
}

example(of: "Didpose") {
    let observable = Observable.of(episodeI, episodeV, episodeVI)
    
    let subscription = observable.subscribe { event in
        print(event)
    }
    
    subscription.dispose()
}

example(of: "DidposeBag") {
    
    let disposeBag = DisposeBag()
    Observable
        .of(episodeI, episodeV, episodeVI)
        .subscribe {
            print($0)
        }
        .disposed(by: disposeBag)
}


