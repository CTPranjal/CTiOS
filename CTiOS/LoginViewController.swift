
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Background Image
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage")) // Replace with your image asset
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Log In Label
        let loginLabel = UILabel()
        loginLabel.text = "Log In"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 28)
        loginLabel.textColor = .white
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // White Card
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 10
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // Sign Up Label
        let signUpLabel = UILabel()
        signUpLabel.text = "Sign up"
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 28)
        signUpLabel.textColor = .black
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(signUpLabel)
        
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            signUpLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        ])
        
        // Phone Input Field
        let phoneStackView = UIStackView()
        phoneStackView.axis = .horizontal
        phoneStackView.spacing = 8
        phoneStackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(phoneStackView)
        
        let countryCodeField = UITextField()
        countryCodeField.text = "+1"
        countryCodeField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        countryCodeField.layer.cornerRadius = 8
        countryCodeField.textAlignment = .center
        countryCodeField.translatesAutoresizingMaskIntoConstraints = false
        countryCodeField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let phoneField = UITextField()
        phoneField.placeholder = "Phone Number"
        phoneField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        phoneField.layer.cornerRadius = 8
        phoneField.translatesAutoresizingMaskIntoConstraints = false
        
        phoneStackView.addArrangedSubview(countryCodeField)
        phoneStackView.addArrangedSubview(phoneField)
        
        NSLayoutConstraint.activate([
            phoneStackView.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
            phoneStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            phoneStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20)
        ])
        
        // Sign Up Button
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor.brown
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            signUpButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
