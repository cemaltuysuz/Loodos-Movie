//
//  PropertyView.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 25.06.2023.
//

import UIKit

class PropertyView: UIView {
    
    var property: Property
    
    private lazy var contentHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = ImageLoader.load(name: property.imageIcon)
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .colorPrimary
        return imageView
    }()
    
    private lazy var propertyValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = property.propertyValue
        label.font = Font.font(.cabinMedium, size: 14.0)
        label.textColor = .colorPrimary
        label.textAlignment = .left
        label.text = property.propertyValue.capitalized
        return label
    }()
    
    init(frame: CGRect = .zero, property: Property) {
        self.property = property
        super.init(frame: frame)
        configureUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(contentHStackView)
        contentHStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentHStackView.addArrangedSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(contentHStackView.snp.height)
        }
        contentHStackView.addArrangedSubview(propertyValueLabel)
    }
}
