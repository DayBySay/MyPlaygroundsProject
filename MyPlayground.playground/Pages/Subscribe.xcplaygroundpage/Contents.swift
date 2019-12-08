import UIKit
import App
import RxSwift
import RxCocoa

enum HogeError: Error {
    case errordayo
}

let ob = Observable<String>.create { (observer) -> Disposable in
    observer.onNext("hoge")
    observer.onNext("fuga")
    observer.onError(HogeError.errordayo)
    observer.onNext("nyassu")
    observer.onCompleted()
    observer.onNext("uhyo-")
    return Disposables.create()
}

ob.subscribe(onNext: { (str) in
    print("next: \(str)")
}, onError: { (error) in
    print("error: \(error)")
}, onCompleted: {
    print("completed")
}) {
    print("disposed")
}

let materialized = ob.materialize()
let elements = materialized.filter { $0.element != nil }.map { $0.element! }
let error = materialized.filter { $0.error != nil }.map { $0.error! }

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
