//: [Previous](@previous)

import Foundation
import App
import RxSwift
import RxRelay

func apiRequest(string: String) -> Observable<[String]> {
    return Observable<[String]>.create { (observer) -> Disposable in
        DispatchQueue.main.async {
            let strings = string.split(separator: ".").map { String($0) }
            if strings.count == 0 {
                print("onError")
                observer.onError(App.AppError.unkown)
            } else {
                print("onNext: \(strings)")
                observer.onNext(strings)
            }
        }
        return Disposables.create()
    }
}

extension Observable where Element: EventConvertible {
    public func elements() -> Observable<Element.Element> {
        return filter { $0.event.element != nil }.map { $0.event.element! }
    }
    
    public func errors() -> Observable<Error> {
        return filter { $0.event.error != nil }.map { $0.event.error! }
    }
}

let input = PublishRelay<String>()
let output = BehaviorRelay<[String]>(value: [])

let response = input.flatMapLatest { string in
    return apiRequest(string: string).materialize()
}.share()

let elements = response.elements()
let errors = response.errors()

elements.subscribe(onNext: { (str) in
    print("elements next: \(str)")
}, onError: { (error) in
    print("elements error: \(error)")
}, onCompleted: {
    print("elements completed")
}) {
    print("elements disposed")
}

error.subscribe(onNext: { (str) in
    print("error next: \(str)")
}, onError: { (error) in
    print("error error: \(error)")
}, onCompleted: {
    print("error completed")
}) {
    print("error disposed")
}



//: [Next](@next)
