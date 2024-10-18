import SwiftUI

/**
 A property wrapper that can be used to abstract the state and binding properties.
 */
@propertyWrapper
public struct AbstractState<Value>: DynamicProperty {
  
  private let _binding: Binding<Value>?
  
  // ideally, it should not being present when using binding. but SwiftUI runtime won't handle State for their state when it's optional type.
  private let _state: State<Value?>
  
  public var wrappedValue: Value {
    get {
      
      if let binding = _binding {
        return binding.wrappedValue
      }
      
      return _state.wrappedValue!
      
    }
    nonmutating set {
      
      if let binding = _binding {
        binding.wrappedValue = newValue
        return
      }
      
      _state.wrappedValue = newValue
      
    }
  }
  
  public init(wrappedValue: Value) {
    _state = .init(initialValue: wrappedValue)
    _binding = nil
  }
  
  public init(_ wrappedValue: Value) {
    self.init(wrappedValue: wrappedValue)
  }
  
  public init(_ binding: Binding<Value>) {
    _binding = binding
    _state = .init(initialValue: nil)
  }
  
  public mutating func update() {
    // no operation
  }
  
}

#if DEBUG

private struct Book: View {
  
  @AbstractState var count: Int = 1
  
  var body: some View {
    Button("Up \(count)") {
      count += 1
    }
  }
}

private struct BookBinding: View {
  
  @AbstractState var count: Int
  
  init(binding: Binding<Int>) {
    _count = AbstractState(binding)
  }
  
  var body: some View {
    Button("Up \(count)") {
      count += 1
    }
  }
}

private struct BookBindingWrapper: View {
  
  @State private var count: Int = 1
  
  var body: some View {
    BookBinding(binding: $count)
  }
  
}

#Preview("State") {
  Book()  
}

#Preview("Binding") {
  BookBindingWrapper()
}

#endif

