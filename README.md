# SwiftUI - AbstractState

A property wrapper that can be used to abstract the state and binding properties.

```swift
struct Counter: View {
  
  @AbstractState var count: Int
  
  init(initialValue: Int) {
    _count = AbstractState(initialValue)
  }
  
  init(binding: Binding<Int>) {
    _count = AbstractState(binding)
  }
  
  var body: some View {
    Button("Up \(count)") {
      count += 1
    }
  }
  
}
```

```swift
#Preview("State") {
  Counter(initialValue: 1)
}
```

```swift
struct Wrapper: View {
  
  @State private var count: Int = 1
  
  var body: some View {
    Counter(binding: $count)
  }
  
}

#Preview("Binding") {  
  Wrapper()
}
```
