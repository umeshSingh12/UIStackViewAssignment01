import UIKit

class ViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let fixedViewHeight: CGFloat = 100
    private var viewCount = 0
    private let maxViews = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateButtonsState()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        // Create the two custom buttons
        let addButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addNewView))
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32)], for: .normal)
        let removeButton = UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(removeLastView))
        removeButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32)], for: .normal)
        
        // Set the bar button items in the navigation bar
        navigationItem.rightBarButtonItems = [addButton, removeButton]
        
        // Configure the stack view
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createNewView() -> UIView {
        let newView = UIView()
        newView.backgroundColor = UIColor.random
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        viewCount += 1
        newView.layer.cornerRadius = 10
        newView.clipsToBounds = true
        
        let label = UILabel()
        label.text = "View \(viewCount)"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        newView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: newView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: newView.centerYAnchor)
        ])
        
        return newView
    }
    
    @objc private func addNewView() {
        if viewCount < maxViews {
            let newView = createNewView()
            stackView.addArrangedSubview(newView)
            NSLayoutConstraint.activate([
                newView.heightAnchor.constraint(equalToConstant: fixedViewHeight)
            ])
            updateButtonsState()
        }
    }
    
    @objc private func removeLastView() {
        if let lastView = stackView.arrangedSubviews.last {
            stackView.removeArrangedSubview(lastView)
            lastView.removeFromSuperview()
            viewCount -= 1
            updateButtonsState()
        }
    }
    
    private func updateButtonsState() {
        navigationItem.rightBarButtonItem?.isEnabled = viewCount < maxViews
        navigationItem.rightBarButtonItems?.last?.isEnabled = viewCount > 0
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
