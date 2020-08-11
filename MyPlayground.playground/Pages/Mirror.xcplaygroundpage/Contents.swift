//: [Previous](@previous)

import Foundation

struct Hoge {
    let hoge: String
    let nyassu: Int
}

let hoge = Hoge(hoge: "hoge", nyassu: 28)
let hogeMirror = Mirror(reflecting: hoge)

print("hogeMirror: \(hogeMirror)")
print("children: \(hogeMirror.children)")
print("subjectType: \(hogeMirror.subjectType)")
print("displayStyle: \(hogeMirror.displayStyle)")
print("description: \(hogeMirror.description)")
hogeMirror.children.map { print("\($0)") }
print(String(reflecting: hoge))

// hogeMirror: Mirror for Hoge
// children: AnyCollection<(label: Optional<String>, value: Any)>(_box: Swift._RandomAccessCollectionBox<Swift.LazyMapSequence<Swift.Range<Swift.Int>, (label: Swift.Optional<Swift.String>, value: Any)>>)
// subjectType: Hoge
// displayStyle: Optional(Swift.Mirror.DisplayStyle.struct)
// description: Mirror for Hoge
// (label: Optional("hoge"), value: "hoge")
// (label: Optional("nyassu"), value: 28)

class Fuga {
    let hoge: Hoge
    
    init(hoge: Hoge) {
        self.hoge = hoge
    }
}

let fuga = Fuga(hoge: hoge)
let fugaMirror = Mirror(reflecting: fuga)

print("mirror: \(fugaMirror)")
print("children: \(fugaMirror.children)")
print("subjectType: \(fugaMirror.subjectType)")
print("displayStyle: \(fugaMirror.displayStyle)")
print("description: \(fugaMirror.description)")
fugaMirror.children.map { print("\($0)") }
print(String(reflecting: fuga))


// __lldb_expr_45.Hoge(hoge: "hoge", nyassu: 28)
// mirror: Mirror for Fuga
// children: AnyCollection<(label: Optional<String>, value: Any)>(_box: Swift._RandomAccessCollectionBox<Swift.LazyMapSequence<Swift.Range<Swift.Int>, (label: Swift.Optional<Swift.String>, value: Any)>>)
// subjectType: Fuga
// displayStyle: Optional(Swift.Mirror.DisplayStyle.class)
// description: Mirror for Fuga
// (label: Optional("hoge"), value: __lldb_expr_45.Hoge(hoge: "hoge", nyassu: 28))
// __lldb_expr_45.Fuga


//: [Next](@next)
