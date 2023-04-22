import Combine

protocol StateObservable: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Intent
    func connect() -> Published<State>.Publisher
    func trigger(_ intent: Intent)
}
