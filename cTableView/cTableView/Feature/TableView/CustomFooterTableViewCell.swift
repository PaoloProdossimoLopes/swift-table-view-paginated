import UIKit

final class CustomFooterTableViewCell: UITableViewCell, ReusableCell {
    
    //MARK: - Properties
    
    
    //MARK: - UI Components
    private(set) lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.tintColor = .black
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Atualizado em ..."
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading() {
        descriptionLabel.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        descriptionLabel.isHidden = false
        loadingIndicator.stopAnimating()
    }
    
    //MARK: - Helpers
    private func commonInit() {
        setupStyle()
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        contentView.addSubview(loadingIndicator)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //contentView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupStyle() {
        //translatesAutoresizingMaskIntoConstraints = false
    }
}
