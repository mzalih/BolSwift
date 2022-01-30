//
//  ReceipieListViewController.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import UIKit
import Combine

protocol  ReceipieListViewControllerDelegate: AnyObject {
    func openRecipie(receipie:Receipie)
}

class ReceipieListViewController: UIViewController, StoryboardInitializable, PullToReloadable {

    let viewModel:ViewModel
    weak var delegate:ReceipieListViewControllerDelegate?
    
    @IBOutlet weak var collectionView:UICollectionView!
    var cancellableRequest: Cancellable?
    var cancellable: Cancellable?
    
    init?(viewModel:ViewModel,delegate:ReceipieListViewControllerDelegate, coder: NSCoder){
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView(){
        collectionView.alwaysBounceVertical = true;
        addRefresh(target: self, scrollView: collectionView, #selector(reload))
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(ReceipieListCell.self,forCellWithReuseIdentifier:viewModel.reuseIdentifier)
        cancellable = viewModel.publisher(for: \.loading)
            .receive(on: RunLoop.main)
            .sink { (value) in
                if (value == false) {
                    self.view.hideLoader()
                    self.collectionView.reloadData()
                }else{
                    self.view.showLoader()
                }
            }
        loadData()
     
    }
    
    @objc func logout(){
        
    }
    
    func loadData(){
        cancellableRequest = viewModel.loadData().sink(receiveCompletion: { (status) in }, receiveValue: { (status) in })
    }
    
    @objc func reload(_ sender:UIRefreshControl?){
        sender?.endRefreshing()
        loadData()
    }
    
}
extension ReceipieListViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // tell the collection view how many cells to make
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.items.count
      }
      
      // make a cell for each cell index path
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
          // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.viewModel.reuseIdentifier, for: indexPath as IndexPath) as! ReceipieListCell
          
          let item =  self.viewModel.items[indexPath.item]
          //the same as the index of the desired text within the array.
            cell.setItem(item:item)
        
          return cell
      }
    
}
extension ReceipieListViewController: UICollectionViewDelegate{
      
      // MARK: - UICollectionViewDelegate protocol
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          // handle tap events
        let item =  self.viewModel.items[indexPath.item]
        print("You selected cell #\(item.value)!")
    
        delegate?.openRecipie(receipie: item)
      }
    
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.red.cgColor
    }

    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
    }
    
}

extension ReceipieListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  collectionView.bounds.size.width/3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
