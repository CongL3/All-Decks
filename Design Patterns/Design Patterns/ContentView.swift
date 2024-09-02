//
//  ContentView.swift
//  Design Patterns
//
//  Created by Cong Le on 02/09/2024.
//

import SwiftUI
import DeckUI

struct ContentView: View {
    var body: some View {
        Presenter(deck: self.deck, showCamera: true)
    }
}

extension ContentView {
    var deck: Deck {
        Deck(title: "Design patterns") {
            Slide(alignment: .center, comment: "Here are some presenter notes") {
                Title("Design patterns in CardApp")
            }
            
            Slide(alignment: .center) {
                RawView {
                    Text("DeckUI")
                        .font(.system(size: 200, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .padding(60)
                        .border(.white.opacity(0.5), width: 20)
                }
            }
            
            Slide {
                Title("Design patterns", subtitle: "Head first Design Patterns")
                Bullets(style: .bullet) {
                    Words("Go through them all on a high level")
                    Words("If we're using it in CardApp, I'll share the example of it and how we're using it")
                    Words("If I'm wrong anywhere, please let me know and I'll take it away and correct.")
                }
            }
            
            Slide {
                Title("Observer Pattern", subtitle: "")
                Words("The Observer Pattern allows an object (the subject) to notify other objects (observers) about changes in its state. This is particularly useful in scenarios where an object needs to notify multiple other objects about updates or changes, without tightly coupling them.")

                Words("The Observer Pattern allows an object to broadcase a message to many listeners without tight coupling")
            }

            Slide {
                Title("Observer Pattern in iOS", subtitle: "")
                Words("In iOS, `NotificationCenter` is a common implementation of the Observer Pattern. It allows different parts of your app to communicate with each other by posting and observing notifications. This approach helps in managing events like user actions, data updates, or system notifications without needing to directly reference other components.")
                
                Code(.swift) {
                """
                // Observer (Subscriber)
                NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .myNotification, object: nil)

                @objc func handleNotification(notification: Notification) {
                    // Handle notification
                }

                // Publisher
                NotificationCenter.default.post(name: .myNotification, object: nil)
                """
                }
            }


            Slide {
                Title("Decorator Pattern", subtitle: "")
                Words("The Decorator Pattern dynamically adds new functionality to an object without altering its structure. This pattern is useful when you want to extend the behavior of objects in a flexible and reusable way.")
            }

            Slide {
                Title("Decorator Pattern in iOS", subtitle: "")
                Words("In iOS, you might use the Decorator Pattern to enhance UI components or view controllers with additional features like borders, shadows, or other styles without modifying the core implementation of those components.")
                
                Code(.swift) {
                """
                protocol ViewDecorator {
                    func decorate(view: UIView)
                }

                class BorderDecorator: ViewDecorator {
                    func decorate(view: UIView) {
                        view.layer.borderColor = UIColor.black.cgColor
                        view.layer.borderWidth = 1.0
                    }
                }

                // Usage
                let myView = UIView()
                let borderDecorator = BorderDecorator()
                borderDecorator.decorate(view: myView)
                """
                }
            }
            
            Slide {
                Title("Factory Pattern", subtitle: "")
                Words("The Factory Pattern provides a method for creating objects without specifying the exact class of object that will be created. This pattern helps in managing and abstracting the creation of objects, especially when the creation process is complex or varies based on input parameters.")
            }

            Slide {
                Title("Factory Pattern in iOS", subtitle: "")
                Words("In iOS, factories are often used to create view controllers, models, or services based on specific conditions or configurations. For example, you might use a factory to create different view controllers depending on the user’s state or app context.")
                
                Code(.swift) {
                """
                protocol ViewControllerFactory {
                    func createViewController() -> UIViewController
                }

                class LoginFactory: ViewControllerFactory {
                    func createViewController() -> UIViewController {
                        return LoginViewController()
                    }
                }

                class HomeFactory: ViewControllerFactory {
                    func createViewController() -> UIViewController {
                        return HomeViewController()
                    }
                }

                // Usage
                let factory: ViewControllerFactory = userIsLoggedIn ? HomeFactory() : LoginFactory()
                let viewController = factory.createViewController()
                """
                }
            }
            
            Slide {
                Title("Singleton Pattern", subtitle: "")
                Words("The Singleton Pattern ensures that a class has only one instance and provides a global point of access to it. This pattern is useful for managing shared resources or services that need to be accessed throughout the application.")
            }

            Slide {
                Title("Singleton Pattern in iOS", subtitle: "")
                Words("In iOS development, singletons are commonly used for services like network management, data caching, or managing app-wide configurations. A singleton ensures that there is only one instance of these services, which can be accessed globally, thus simplifying resource management.")
                
                Code(.swift) {
                """
                class NetworkManager {
                    static let shared = NetworkManager()
                    
                    private init() {}
                    
                    func fetchData() {
                        // Perform network request
                    }
                }

                // Usage
                NetworkManager.shared.fetchData()
                """
                }
            }
            
            Slide {
                Title("Command Pattern", subtitle: "")
                Words("The Command Pattern encapsulates a request as an object, allowing you to parameterize clients with queues, requests, and operations. This pattern is particularly useful for implementing undo functionality, logging, and transactional operations.")
            }

            Slide {
                Title("Command Pattern in iOS", subtitle: "")
                Words("In iOS apps, the Command Pattern can be used to encapsulate user actions or commands. For instance, you might use commands to handle button actions, menu selections, or other user interactions, allowing for more flexible and extensible code.")
                
                Code(.swift) {
                """
                protocol Command {
                    func execute()
                }

                class SaveDocumentCommand: Command {
                    func execute() {
                        // Save document logic
                    }
                }

                class RemoteControl {
                    private var command: Command?
                    
                    func setCommand(command: Command) {
                        self.command = command
                    }
                    
                    func pressButton() {
                        command?.execute()
                    }
                }

                // Usage
                let saveCommand = SaveDocumentCommand()
                let remote = RemoteControl()
                remote.setCommand(command: saveCommand)
                remote.pressButton()
                """
                }
            }
            
            Slide {
                Title("Adapter Pattern", subtitle: "")
                Words("The Adapter Pattern allows objects with incompatible interfaces to work together by wrapping its own interface around that of an existing class. This pattern is helpful when you need to integrate third-party libraries or systems with your own codebase.")
            }

            Slide {
                Title("Adapter Pattern in iOS", subtitle: "")
                Words("In iOS, you might use the Adapter Pattern to bridge between different APIs or to adapt data from legacy systems. For example, adapting old network APIs to fit into a new, more modern data handling system.")
                
                Code(.swift) {
                """
                protocol NewPaymentGateway {
                    func processPayment(amount: Double)
                }

                class OldPaymentProcessor {
                    func makePayment(amount: Int) {
                        // Old payment logic
                    }
                }

                class PaymentAdapter: NewPaymentGateway {
                    private let oldProcessor: OldPaymentProcessor
                    
                    init(oldProcessor: OldPaymentProcessor) {
                        self.oldProcessor = oldProcessor
                    }
                    
                    func processPayment(amount: Double) {
                        oldProcessor.makePayment(amount: Int(amount))
                    }
                }

                // Usage
                let oldProcessor = OldPaymentProcessor()
                let adapter = PaymentAdapter(oldProcessor: oldProcessor)
                adapter.processPayment(amount: 50.0)
                """
                }
            }
            
            Slide {
                Title("Facade Pattern", subtitle: "")
                Words("The Facade Pattern provides a simplified interface to a complex subsystem. It is used to make a system easier to use by providing a higher-level interface that hides the complexity of the underlying subsystem.")
            }

            Slide {
                Title("Facade Pattern in iOS", subtitle: "")
                Words("In iOS, a facade can simplify interactions with various services or frameworks. For example, you might create a facade to manage interactions with multiple network services, data managers, and user settings, providing a unified API to the rest of your app.")
                
                Code(.swift) {
                """
                class WeatherService {
                    func fetchCurrentWeather() {}
                    func fetchForecast() {}
                }

                class UserService {
                    func fetchUserDetails() {}
                    func updateUserProfile() {}
                }

                class ApplicationFacade {
                    private let weatherService = WeatherService()
                    private let userService = UserService()
                    
                    func updateApp() {
                        weatherService.fetchCurrentWeather()
                        weatherService.fetchForecast()
                        userService.fetchUserDetails()
                    }
                }

                // Usage
                let facade = ApplicationFacade()
                facade.updateApp()
                """
                }
            }
            
            Slide {
                Title("Template Method Pattern", subtitle: "")
                Words("The Template Method Pattern defines the skeleton of an algorithm, deferring some steps to subclasses. It allows subclasses to redefine certain steps of an algorithm without changing the algorithm’s structure.")
            }

            Slide {
                Title("Template Method Pattern in iOS", subtitle: "")
                Words("In iOS, this pattern is useful for handling variations in data processing or UI rendering. For example, you might define a base class with a template method for data fetching, allowing subclasses to implement specific details like data parsing or UI updates.")
                
                Code(.swift) {
                """
                class DataFetcher {
                    func fetchData() {
                        openConnection()
                        retrieveData()
                        closeConnection()
                    }
                    
                    func openConnection() {
                        // Default implementation
                    }
                    
                    func retrieveData() {
                        // To be overridden
                    }
                    
                    func closeConnection() {
                        // Default implementation
                    }
                }

                class JSONDataFetcher: DataFetcher {
                    override func retrieveData() {
                        // Fetch JSON data
                    }
                }

                // Usage
                let fetcher = JSONDataFetcher()
                fetcher.fetchData()
                """
                }
            }
            
            Slide {
                Title("Iterator Pattern", subtitle: "")
                Words("The Iterator Pattern provides a way to access elements of an aggregate object sequentially without exposing its underlying representation. This pattern is useful for traversing collections or sequences.")
            }

            Slide {
                Title("Iterator Pattern in iOS", subtitle: "")
                Words("In iOS, the Iterator Pattern can be used to traverse through custom data collections or UI elements. For example, iterating through a list of items in a table view or a collection view.")
                
                Code(.swift) {
                """
                protocol Iterator {
                    associatedtype Element
                    func next() -> Element?
                }

                class StringIterator: Iterator {
                    private var index = 0
                    private let collection: [String]
                    
                    init(collection: [String]) {
                        self.collection = collection
                    }
                    
                    func next() -> String? {
                        guard index < collection.count else { return nil }
                        let element = collection[index]
                        index += 1
                        return element
                    }
                }

                // Usage
                let strings = ["A", "B", "C"]
                let iterator = StringIterator(collection: strings)
                while let item = iterator.next() {
                    print(item)
                }
                """
                }
            }
            
            Slide {
                Title("Composite Pattern", subtitle: "")
                Words("The Composite Pattern allows you to compose objects into tree structures to represent part-whole hierarchies. This pattern lets you treat individual objects and compositions of objects uniformly.")
            }

            Slide {
                Title("Composite Pattern in iOS", subtitle: "")
                Words("In iOS, this pattern can be used to manage complex UI hierarchies, such as nested views or view controllers. For example, handling a view hierarchy where views are composed of other views or containers.")
                
                Code(.swift) {
                """
                protocol UIComponent {
                    func draw()
                }

                class Leaf: UIComponent {
                    func draw() {
                        print("Drawing leaf")
                    }
                }

                class Composite: UIComponent {
                    private var children = [UIComponent]()
                    
                    func add(child: UIComponent) {
                        children.append(child)
                    }
                    
                    func draw() {
                        for child in children {
                            child.draw()
                        }
                    }
                }

                // Usage
                let composite = Composite()
                let leaf1 = Leaf()
                let leaf2 = Leaf()
                composite.add(child: leaf1)
                composite.add(child: leaf2)
                composite.draw()
                """
                }
            }
            
            Slide {
                Title("State Pattern", subtitle: "")
                Words("The State Pattern allows an object to alter its behavior when its internal state changes. This pattern helps manage state-dependent behavior without using a large number of conditional statements.")
            }

            Slide {
                Title("State Pattern in iOS", subtitle: "")
                Words("In iOS, you might use the State Pattern to manage different states of UI components, such as buttons or form fields. For example, changing the appearance or behavior of a button based on whether it's enabled or disabled.")
                
                Code(.swift) {
                """
                protocol State {
                    func press()
                }

                class EnabledState: State {
                    func press() {
                        print("Button pressed - enabled")
                    }
                }

                class DisabledState: State {
                    func press() {
                        print("Button pressed - disabled")
                    }
                }

                class Button {
                    private var state: State
                    
                    init(state: State) {
                        self.state = state
                    }
                    
                    func setState(state: State) {
                        self.state = state
                    }
                    
                    func press() {
                        state.press()
                    }
                }

                // Usage
                let button = Button(state: EnabledState())
                button.press() // Button pressed - enabled
                button.setState(state: DisabledState())
                button.press() // Button pressed - disabled
                """
                }
            }
            
            Slide {
                Title("Proxy Pattern", subtitle: "")
                Words("The Proxy Pattern provides a surrogate or placeholder for another object to control access to it. This pattern is used to manage access, control, or add additional functionality to the original object.")
            }

            Slide {
                Title("Proxy Pattern in iOS", subtitle: "")
                Words("In iOS, you might use the Proxy Pattern to control access to a resource-intensive object, such as loading images or data. For example, a proxy can handle loading and caching images to improve performance.")
                
                Code(.swift) {
                """
                protocol Image {
                    func display()
                }

                class RealImage: Image {
                    private let filename: String
                    
                    init(filename: String) {
                        self.filename = filename
                    }
                    
                    func display() {
                        print("Displaying image: \\(filename)")
                    }
                }

                class ProxyImage: Image {
                    private var realImage: RealImage?
                    private let filename: String
                    
                    init(filename: String) {
                        self.filename = filename
                    }
                    
                    func display() {
                        if realImage == nil {
                            realImage = RealImage(filename: filename)
                        }
                        realImage?.display()
                    }
                }

                // Usage
                let image: Image = ProxyImage(filename: "example.jpg")
                image.display() // Loading image: example.jpg \n Displaying image: example.jpg
                """
                }
            }
            
            Slide {
                Title("Compound Patterns", subtitle: "")
                Words("Compound Patterns are combinations of multiple design patterns to solve complex design problems. These patterns leverage the strengths of individual patterns to address complex use cases effectively.")
            }

            Slide {
                Title("Compound Patterns in iOS", subtitle: "")
                Words("In iOS, you might combine patterns like Observer, Command, and State to handle sophisticated UI interactions. For example, using these patterns together can help manage different states of a UI element, execute commands based on user actions, and notify other components about state changes.")

                Code(.swift) {
                """
                protocol Command {
                    func execute()
                }

                class ButtonState {
                    func press() {}
                }

                class EnabledState: ButtonState {
                    override func press() {
                        print("Button is pressed and enabled")
                    }
                }

                class DisabledState: ButtonState {
                    override func press() {
                        print("Button is disabled and cannot be pressed")
                    }
                }

                class Button {
                    private var state: ButtonState
                    private var command: Command?
                    
                    init(state: ButtonState) {
                        self.state = state
                    }
                    
                    func setState(state: ButtonState) {
                        self.state = state
                    }
                    
                    func setCommand(command: Command) {
                        self.command = command
                    }
                    
                    func press() {
                        state.press()
                        command?.execute()
                    }
                }

                class PrintCommand: Command {
                    func execute() {
                        print("Command executed")
                    }
                }

                // Usage
                let button = Button(state: EnabledState())
                button.setCommand(command: PrintCommand())
                button.press() // Button is pressed and enabled \n Command executed
                """
                }
            }
        }
    }
}

extension Theme {
    public static let venonat: Theme = Theme(
        background: Color(hex: "#624a7b"),
        title: Foreground(
            color: Color(hex: "#ff5a5a"),
            font: Font.system(size: 80,
                              weight: .bold,
                              design: .default)
        ),
        subtitle: Foreground(
            color: Color(hex: "#a48bbd"),
            font: Font.system(size: 50,
                              weight: .light,
                              design: .default).italic()
        ),
        body: Foreground(
            color: Color(hex: "#FFFFFF"),
            font: Font.system(size: 50,
                              weight: .regular,
                              design: .default)
        ),
        code: Foreground(
            color: Color(hex: "#FFFFFF"),
            font: Font.system(size: 26,
                              weight: .regular,
                              design: .monospaced)
        ),
        codeHighlighted: (Color(hex: "#312952"), Foreground(
            color: Color(hex: "#FFFFFF"),
            font: Font.system(size: 26,
                              weight: .heavy,
                              design: .monospaced)
        ))
    )
}

struct CounterView: View {
    @State var count = 0
    
    var body: some View {
        Button {
            self.count += 1
        } label: {
            Text("Press me - \(self.count)")
                .font(.system(size: 60))
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white, lineWidth: 2)
                )
        }.buttonStyle(.plain)
    }
}

