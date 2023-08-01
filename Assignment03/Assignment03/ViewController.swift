import UIKit

class ViewController: UIViewController {
    
    private var followingCountLabel: UILabel!
    private var connectButton: UIButton!
    
    private var followingCount: Int = 100 {
        didSet {
            followingCountLabel.text = "Following: \(followingCount)"
        }
    }
    
    private var isFollowing: Bool = false {
        didSet {
            if isFollowing {
                followingCount += 1
            } else {
                followingCount -= 1
            }
            updateFollowButtonTitle()
        }
    }
    
    private func updateFollowButtonTitle() {
        let title = isFollowing ? "Unfollow" : "Follow"
        connectButton.setTitle(title, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackViews()
    }
    
    private func setupStackViews() {
        
        // Create a fixed image view
        let fixedImageView = UIImageView(image: UIImage(named: "cat_in_the_city"))
        fixedImageView.contentMode = .scaleAspectFit
        fixedImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        fixedImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        fixedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a horizontal stack view to hold the title label and following count label
        let titleFollowingStackView = UIStackView()
        titleFollowingStackView.axis = .horizontal
        titleFollowingStackView.spacing = 4
        titleFollowingStackView.alignment = .leading
        
        // Add your title label to the title Following Stack View
        let titleLabel = UILabel()
        titleLabel.text = "Cat In The City"
        titleLabel.numberOfLines = 1
        // Adjust content compression resistance priority to allow stretching and shrinking
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleFollowingStackView.addArrangedSubview(titleLabel)
        
        // Add your following count label to the title Following Stack View
        let followingCountLabel = UILabel()
        followingCountLabel.text = "Following: \(followingCount)"
        followingCountLabel.numberOfLines = 1
        followingCountLabel.setContentHuggingPriority(.required, for: .horizontal)
        followingCountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleFollowingStackView.addArrangedSubview(followingCountLabel)
        self.followingCountLabel = followingCountLabel
        
        // Create the vertical stack view for dynamic description label and connect button
        let bottomStackView = UIStackView()
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 8
        
        // Add your dynamic description label to the bottom stack view
        let descriptionLabel = UILabel()
        descriptionLabel.text = "In Tokyo - one of the world's largest megacities - a stray cat is wending her way through the back alleys. And, with each detour, she brushes up against the seemingly disparate lives of the city-dwellers, connecting them in unexpected ways."
        descriptionLabel.numberOfLines = 0 // Allow multiple lines
        bottomStackView.addArrangedSubview(descriptionLabel)
        
        // Add your connect button to the bottom stack view (replace `connectButton` with your button)
        connectButton = UIButton(type: .system)
        connectButton.setTitle("Connect", for: .normal)
        connectButton.addTarget(self, action: #selector(connectButtonTapped), for: .touchUpInside)
        connectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        bottomStackView.addArrangedSubview(connectButton)
        
        // Create the main vertical stack view and add both the top and bottom stack views to it
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 16
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        
        mainStackView.addArrangedSubview(fixedImageView)
        mainStackView.addArrangedSubview(titleFollowingStackView)
        mainStackView.addArrangedSubview(bottomStackView)
        
        // Add the main stack view to your view controller's view (replace `yourMainView` with your desired view)
        view.addSubview(mainStackView)
        
        // Set constraints for the main stack view to fill the available space
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    @objc private func connectButtonTapped() {
        isFollowing.toggle()
    }
}

