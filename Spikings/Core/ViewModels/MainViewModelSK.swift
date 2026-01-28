import SwiftUI
import Combine

class MainViewModelSK: ObservableObject {
    @Published var articles: [ArticleModelSK] = []
    @Published var tasks: [TaskModelSK] = []
    @Published var selectedTheme: ThemeModelSK = .desertSands
    @Published var searchQuery: String = ""
    @Published var selectedTab: Int = 0
    
    private let persistence = PersistenceManagerSK.shared
    let storeManager = StoreManagerSK()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
        loadTheme()
        
        storeManager.objectWillChange
            .sink { [weak self] _ in
                // Re-evaluate theme access when store updates (e.g. entitlements load)
                self?.loadTheme()
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    private func loadData() {
        if let loadedArticles: [ArticleModelSK] = JSONLoaderSK.load("articles_sk") {
            self.articles = loadedArticles
        }
        
        if let loadedTasks: [TaskModelSK] = JSONLoaderSK.load("tasks_sk") {
            self.tasks = loadedTasks
        }
    }
    
    private func loadTheme() {
        let themeId = persistence.selectedTheme
        if let theme = ThemeModelSK.allThemes.first(where: { $0.id == themeId }) {
            // Only validate premium access if entitlements are fully loaded
            if theme.isPremium && storeManager.areEntitlementsLoaded {
                 if !storeManager.hasAccess(to: theme.id) {
                     selectedTheme = .desertSands // Cleanup: user lost access
                 } else {
                     selectedTheme = theme
                 }
            } else {
                // If entitlements aren't loaded yet (app launch), we trust the persistence temporarily
                // The sink on storeManager.objectWillChange will trigger re-evaluation once they load
                selectedTheme = theme
            }
        }
    }
    
    func selectTheme(_ theme: ThemeModelSK) {
        if theme.isPremium && !storeManager.hasAccess(to: theme.id) {
            return
        }
        
        selectedTheme = theme
        persistence.selectedTheme = theme.id
    }
    
    var readArticles: Set<String> {
        persistence.readArticles
    }
    
    var favoriteArticles: Set<String> {
        persistence.favoriteArticles
    }
    
    var favoriteTasks: Set<String> {
        persistence.favoriteTasks
    }
    
    var completedTasks: Set<String> {
        persistence.completedTasks
    }
    
    func markArticleAsRead(_ articleId: String) {
        var articles = persistence.readArticles
        articles.insert(articleId)
        persistence.readArticles = articles
        objectWillChange.send()
    }
    
    func toggleArticleFavorite(_ articleId: String) {
        var favorites = persistence.favoriteArticles
        if favorites.contains(articleId) {
            favorites.remove(articleId)
        } else {
            favorites.insert(articleId)
        }
        persistence.favoriteArticles = favorites
        objectWillChange.send()
    }
    
    func toggleTaskFavorite(_ taskId: String) {
        var favorites = persistence.favoriteTasks
        if favorites.contains(taskId) {
            favorites.remove(taskId)
        } else {
            favorites.insert(taskId)
        }
        persistence.favoriteTasks = favorites
        objectWillChange.send()
    }
    
    func isArticleFavorite(_ articleId: String) -> Bool {
        persistence.favoriteArticles.contains(articleId)
    }
    
    func isTaskFavorite(_ taskId: String) -> Bool {
        persistence.favoriteTasks.contains(taskId)
    }
    
    func markTaskStepCompleted(taskId: String, step: Int) {
        persistence.markTaskStepCompleted(taskId: taskId, step: step)
        objectWillChange.send()
    }
    
    func isTaskStepCompleted(taskId: String, step: Int) -> Bool {
        persistence.isTaskStepCompleted(taskId: taskId, step: step)
    }
    
    func taskProgress(taskId: String) -> Int {
        persistence.taskProgress(taskId: taskId)
    }
    
    var filteredArticles: [ArticleModelSK] {
        if searchQuery.isEmpty {
            return articles
        }
        return articles.filter { article in
            article.title.localizedCaseInsensitiveContains(searchQuery) ||
            article.subtitle.localizedCaseInsensitiveContains(searchQuery) ||
            article.tags.contains { $0.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
    
    var filteredTasks: [TaskModelSK] {
        if searchQuery.isEmpty {
            return tasks
        }
        return tasks.filter { task in
            task.title.localizedCaseInsensitiveContains(searchQuery) ||
            task.subtitle.localizedCaseInsensitiveContains(searchQuery)
        }
    }
    
    var favoriteArticlesList: [ArticleModelSK] {
        articles.filter { favoriteArticles.contains($0.id) }
    }
    
    var favoriteTasksList: [TaskModelSK] {
        tasks.filter { favoriteTasks.contains($0.id) }
    }
    
    var completedTasksList: [TaskModelSK] {
        tasks.filter { completedTasks.contains($0.id) }
    }
    
    var readArticlesList: [ArticleModelSK] {
        articles.filter { readArticles.contains($0.id) }
    }
    
    var totalArticlesRead: Int {
        readArticles.count
    }
    
    var totalTasksCompleted: Int {
        completedTasks.count
    }
    
    var totalReadingTime: Int {
        readArticlesList.reduce(0) { $0 + $1.estimatedReadTime }
    }
}
