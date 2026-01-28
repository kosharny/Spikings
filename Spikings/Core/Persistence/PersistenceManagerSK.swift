import Foundation

class PersistenceManagerSK {
    static let shared = PersistenceManagerSK()
    
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let completedTasks = "completedTasks"
        static let completedSteps = "completedSteps"
        static let readArticles = "readArticles"
        static let favoriteArticles = "favoriteArticles"
        static let favoriteTasks = "favoriteTasks"
        static let selectedTheme = "selectedTheme"
        static let purchasedThemes = "purchasedThemes"
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
    }
    
    var completedTasks: Set<String> {
        get {
            Set(defaults.stringArray(forKey: Keys.completedTasks) ?? [])
        }
        set {
            defaults.set(Array(newValue), forKey: Keys.completedTasks)
        }
    }
    
    var completedSteps: [String: Set<Int>] {
        get {
            guard let data = defaults.data(forKey: Keys.completedSteps),
                  let dict = try? JSONDecoder().decode([String: [Int]].self, from: data) else {
                return [:]
            }
            return dict.mapValues { Set($0) }
        }
        set {
            let dict = newValue.mapValues { Array($0) }
            if let data = try? JSONEncoder().encode(dict) {
                defaults.set(data, forKey: Keys.completedSteps)
            }
        }
    }
    
    var readArticles: Set<String> {
        get {
            Set(defaults.stringArray(forKey: Keys.readArticles) ?? [])
        }
        set {
            defaults.set(Array(newValue), forKey: Keys.readArticles)
        }
    }
    
    var favoriteArticles: Set<String> {
        get {
            Set(defaults.stringArray(forKey: Keys.favoriteArticles) ?? [])
        }
        set {
            defaults.set(Array(newValue), forKey: Keys.favoriteArticles)
        }
    }
    
    var favoriteTasks: Set<String> {
        get {
            Set(defaults.stringArray(forKey: Keys.favoriteTasks) ?? [])
        }
        set {
            defaults.set(Array(newValue), forKey: Keys.favoriteTasks)
        }
    }
    
    var selectedTheme: String {
        get {
            defaults.string(forKey: Keys.selectedTheme) ?? "desert_sands"
        }
        set {
            defaults.set(newValue, forKey: Keys.selectedTheme)
        }
    }
    
    var purchasedThemes: Set<String> {
        get {
            Set(defaults.stringArray(forKey: Keys.purchasedThemes) ?? ["desert_sands"])
        }
        set {
            defaults.set(Array(newValue), forKey: Keys.purchasedThemes)
        }
    }
    
    var hasCompletedOnboarding: Bool {
        get {
            defaults.bool(forKey: Keys.hasCompletedOnboarding)
        }
        set {
            defaults.set(newValue, forKey: Keys.hasCompletedOnboarding)
        }
    }
    
    func markTaskStepCompleted(taskId: String, step: Int) {
        var steps = completedSteps
        var taskSteps = steps[taskId] ?? Set<Int>()
        taskSteps.insert(step)
        steps[taskId] = taskSteps
        completedSteps = steps
        
        if taskSteps.count == 6 {
            var tasks = completedTasks
            tasks.insert(taskId)
            completedTasks = tasks
        }
    }
    
    func isTaskStepCompleted(taskId: String, step: Int) -> Bool {
        completedSteps[taskId]?.contains(step) ?? false
    }
    
    func taskProgress(taskId: String) -> Int {
        completedSteps[taskId]?.count ?? 0
    }
}
