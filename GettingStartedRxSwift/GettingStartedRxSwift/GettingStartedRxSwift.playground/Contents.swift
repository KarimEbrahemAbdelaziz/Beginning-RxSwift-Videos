
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

example(of: "Create") {
    
    enum Droid: Error {
        case OU812
    }
    
    let disposeBag = DisposeBag()
    
    Observable<String>.create { observer in
        
        observer.onNext("R2-D2")
        observer.onError(Droid.OU812)
        observer.onNext("C-3PO")
        observer.onNext("K-2SO")
        //observer.onCompleted()
        
        return Disposables.create()
    }
    .subscribe(
        onNext: { print($0) },
        onError: { print("Error: \($0)") },
        onCompleted: { print("Completed") },
        onDisposed: { print("Disposed") })
    .disposed(by: disposeBag)
    
}

example(of: "Single Trait") {
    let disposeBag = DisposeBag()
    
    enum FileReadError: Error {
        case fileNotFound, unreadable, encodingFaild
    }
    
    func loadText(from filename: String) -> Single<String> {
        return Single.create { single in
            let disposable = Disposables.create()
            
            guard let path = Bundle.main.path(forResource: filename, ofType: "txt") else {
                single(.error(FileReadError.fileNotFound))
                return disposable
            }
            
            guard let data = FileManager.default.contents(atPath: path) else {
                single(.error(FileReadError.unreadable))
                return disposable
            }
            
            guard let contents = String(data: data, encoding: .utf8) else {
                single(.error(FileReadError.encodingFaild))
                return disposable
            }
            
            single(.success(contents))
            
            return disposable
        }
    }
    
    loadText(from: "ANewHope")
        .subscribe(onSuccess: { value in
            print(value)
        }, onError: { error in
            print(error)
        })
    .disposed(by: disposeBag)
}

example(of: "Challenge Perform Side Effect: do operator") {
    // Finite observable no ended :D
    let observable = Observable<Any>.never()
    observable
        .do(
            onNext: { value in
                print(value)
        },
            onError: { error in
                print(error)
        },
            onCompleted: {
                print("Completed")
        },
            onSubscribe: {
                print("On Subscribe")
        },
            onSubscribed: {
                print("On subscribed")
        },
            onDispose: {
                print("On disposable")
        })
        .subscribe(
            onNext: { (value) in
                print(value)
        }, onCompleted: {
            print("Completed")
        })
    .disposed(by: DisposeBag())
}

example(of: "PublishSubject Example") {
    
    let quotes = PublishSubject<String>()
    
    quotes.onNext(itsNotMyFault)
    
    let subsribtionOne = quotes
        .subscribe {
            print(label: "1)", event: $0)
    }
    
    quotes.onNext(doOrDoNot)
    
    let subsribtionTwo = quotes
        .subscribe {
            print(label: "2)", event: $0)
    }
    
    quotes.onNext(lackOfFaith)
    
    subsribtionOne.disposed(by: DisposeBag())
    
    quotes.onNext(eyesCanDeceive)
    
    quotes.onCompleted()
    
    let subscribtionThree = quotes.subscribe {
        print(label: "3)", event: $0)
    }
    
    quotes.onNext(stayOnTarget)
    
    subsribtionTwo.dispose()
    subscribtionThree.dispose()
}

example(of: "BehaviorSubject Example") {
    let disposeBag = DisposeBag()
    
    let behaviorQuotes = BehaviorSubject(value: "I am your father")
    
    let subscriberOne = behaviorQuotes.subscribe {
        print(label: "1)", event: $0)
    }
    
    behaviorQuotes.onNext("I am you mother")
    
    let subscriberTwo = behaviorQuotes.subscribe {
        print(label: "2)", event: $0)
    }
    
    behaviorQuotes.onError(Quote.neverSaidThat)
    
    let subscriberThree = behaviorQuotes.subscribe {
        print(label: "3)", event: $0)
    }
    
    subscriberOne.dispose()
    subscriberTwo.dispose()
    subscriberThree.dispose()
}

example(of: "ReplaySubject Example") {
    
    let disposeBag = DisposeBag()
    
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    
    subject.onNext(useTheForce)
    
    subject
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)

    subject.onNext(theForceIsStrong)
    subject.onNext(theForceIsStrong)
    
    subject
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)

}

example(of: "Variable") {
    let disposeBag = DisposeBag()
    
    let variable = Variable(mayTheForceBeWithYou)
    
    print(variable.value)
    
    variable.asObservable()
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)
    
    variable.value = mayThe4thBeWithYou
}

example(of: "PublishSubject") {
    
    let disposeBag = DisposeBag()
    
    let dealtHand = PublishSubject<[(String, Int)]>()
    
    func deal(_ cardCount: UInt) {
        var deck = cards
        var cardsRemaining: UInt32 = 52
        var hand = [(String, Int)]()
        
        for _ in 0..<cardCount {
            let randomIndex = Int(arc4random_uniform(cardsRemaining))
            hand.append(deck[randomIndex])
            deck.remove(at: randomIndex)
            cardsRemaining -= 1
        }
        
        // Add code to update dealtHand here
        if points(for: hand) > 21 {
            dealtHand.onError(HandError.busted)
        } else {
            dealtHand.onNext(hand)
        }
        
    }
    
    // Add subscription to dealtHand here
    dealtHand
        .subscribe(
            onNext: { hand in
                print(cardString(for: hand), "for", points(for: hand), "Points")
        },
            onError: { error in
                print(String(describing: error))
        })
        .disposed(by: disposeBag)
    
    deal(3)
}
