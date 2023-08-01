import UIKit

class ReadMoreViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read More", for: .normal)
        button.setTitle("Read Less", for: .selected)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.blue, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isExpanded = false {
        didSet {
            let textColor: UIColor = isExpanded ? .red : .blue
            let buttonColor: UIColor = isExpanded ? .red : .blue
            

            // Apply fade-in effect during expansion
            UIView.transition(with: label, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                self.label.textColor = textColor
                self.readMoreButton.setTitleColor(buttonColor, for: .normal)
            }, completion: nil)
            

            // Use spring animation for smooth and dynamic expansion/collapse
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                self.label.numberOfLines = self.isExpanded ? 0 : 2
                self.view.layoutIfNeeded()
            }, completion: nil)
            updateLabel()
        }
    }
    
    // Function to update the label's text and button title
    
    private func updateLabel() {
        if isExpanded {
            label.numberOfLines = 0
            readMoreButton.setTitle("Read Less", for: .normal)
        } else {
            label.numberOfLines = 2
            readMoreButton.setTitle("Read More", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        readMoreButton.addTarget(self, action: #selector(readMoreButtonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(readMoreButton)
        
        view.addSubview(stackView)
        
        // Center the stackView in the parent view.
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        // Provide your long text here that you want to display in the label.
        let longText = """
        The color of animals is by no means a matter of chance; it depends on many considerations, but in the majority of cases tends to protect the animal from danger by rendering it less conspicuous. Perhaps it may be said that if coloring is mainly protective, there ought to be but few brightly colored animals. There are, however, not a few cases in which vivid colors are themselves protective. The kingfisher itself, though so brightly colored, is by no means easy to see. The blue harmonizes with the water, and the bird as it darts along the stream looks almost like a flash of sunlight.

        Desert animals are generally the color of the desert. Thus, for instance, the lion, the antelope, and the wild donkey are all sand-colored. “Indeed,” says Canon Tristram, “in the desert, where neither trees, brushwood, nor even undulation of the surface afford the slightest protection to its foes, a modification of color assimilated to that of the surrounding country is absolutely necessary. Hence, without exception, the upper plumage of every bird, and also the fur of all the smaller mammals and the skin of all the snakes and lizards, is of one uniform sand color.”
        """

        
        label.text = longText
    }
    
    @objc private func readMoreButtonTapped() {
        isExpanded.toggle()
    }
}
