
import RxSwift

example(of: "Create Observables") {
    
    let mostPopular = Observable<String>.just(episodeV)
    
    let originalTrilogy = Observable.of(episodeI, episodeV, episodeVI)
    
    let prequalTrilogy = Observable.of([episodeI, episodeV, episodeVI])
    
    let sequalTrilogy = Observable.from([episodeI, episodeV, episodeVI])

}
