//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "startWith") {
  
  let disposeBag = DisposeBag()
  
  let prequelEpisodes = Observable.of(1, 2, 3)
  
  let flashback = prequelEpisodes.startWith(4, 5)
  
  flashback
    .subscribe(onNext: { episode in
      print(episode)
    })
    .disposed(by: disposeBag)
}

example(of: "concat") {
  
  let disposeBag = DisposeBag()
  
  let prequelTrilogy = Observable.of(1, 2, 3)
  
  let originalTrilogy = Observable.of(4, 5, 6)
  
  prequelTrilogy.concat(originalTrilogy)
    .subscribe(onNext: { episode in
      print(episode)
    })
    .disposed(by: disposeBag)
}

example(of: "merge") {
  
  let disposeBag = DisposeBag()
  
  let firstObservable = PublishSubject<String>()
  
  let secondObservable = PublishSubject<String>()
  
  let storyOrder = Observable.of(firstObservable, secondObservable)
  
  storyOrder.merge()
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
  firstObservable.onNext("First 1")
  firstObservable.onNext("First 2")
  
  secondObservable.onNext("Second 1")
  
  firstObservable.onNext("First 3")
  
  secondObservable.onNext("Second 2")
  secondObservable.onNext("Second 3")
  
  firstObservable.onNext("First 4")
}

/*:
 Copyright (c) 2014-2018 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
