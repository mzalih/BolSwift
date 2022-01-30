//
//  ReceipieListCell.swift
//  Recepie
//
//  Created by Muhammed salih T A on 29/01/22.
//

import UIKit

class ReceipieListCell: UICollectionViewCell {
    
    private var viewModel:ViewModel?
    
    fileprivate var label:UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var image:UIView = {
        let image  = UIView()
        return image
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
    public func setItem(item:Receipie){
        self.viewModel = ViewModel(receipie:item)
        self.label.text = viewModel?.title
        self.image.backgroundColor = viewModel?.color
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }
    
    func setView(){
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label )
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        contentView.addSubview(image )
        
        let imageWidth = frame.width/3
        image.anchor(top :contentView.topAnchor,
                     paddingTop:imageWidth ,width:imageWidth, height:imageWidth)
        // image.center(inView: contentView)
        image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
      
        
        label.anchor(top :image.bottomAnchor,
                     left:contentView.leftAnchor, right:contentView.rightAnchor, paddingTop:10)
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 1
        image.layer.cornerRadius = imageWidth/2

    }
}

extension ReceipieListCell{
    class ViewModel{
        private let receipie:Receipie
        var title: String {
            receipie.value
        }
        var color: UIColor{
            receipie.color.asUIColor
        }
        init(receipie:Receipie) {
            self.receipie = receipie
        }
    }
}
