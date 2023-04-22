import Foundation

protocol IMainModuleViewModel: StateObservable where State == MainModuleState, Intent == MainModuleIntent {}

final class MainModuleViewModel: IMainModuleViewModel {
    
    // Service
    
    // View Factory
    
    // State
    @Published
    private var state: MainModuleState = .loading
    
    // MARK: - initialization
    
    init() {
        
    }
    
    func connect() -> Published<MainModuleState>.Publisher {
        return $state
    }
    
    func trigger(_ intent: MainModuleIntent) {
        
    }
    
}
