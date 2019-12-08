//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

enum ErrorDayo: Error {
    case error
}

let output = BehaviorRelay<[String]>(value: [])
let input = PublishRelay<String>()

func apiRequest(string: String) -> Observable<[String]> {
    return Observable<[String]>.create { (observer) -> Disposable in
        DispatchQueue.main.async {
            let strings = string.split(separator: ".").map { String($0) }
            if strings.count == 0 {
                print("onError")
                observer.onError(ErrorDayo.error)
            } else {
                print("onNext: \(strings)")
                observer.onNext(strings)
            }
        }
        return Disposables.create()
    }
}

let response = input.flatMapLatest { input in
    return apiRequest(string: input)
}.share()

response
    .asDriver(onErrorDriveWith: Driver.empty())
    .drive(output)

output
    .asDriver()
    .drive(onNext: { (strings) in
        print(strings)
    }, onCompleted: {
        print("completed")
    }) {
        print("disposed")
}

DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: {
    input.accept("h.o.g.e")
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: {
        input.accept("")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: {
            input.accept("n.y.a.n")
        })

    })
})
//: [Next](@next)
