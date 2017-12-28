//
//  KPageViewController.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/28/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit
import RxSwift

/**
 guide use this class
 1. subclass KPageViewController
 2. setUpViewMenu
 3. setUpController
 */

class KPageViewController: KBaseViewController {
    
    let vContaintMenu: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    let vMenu: KPageMenuView = {
        let view = KPageMenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let cvContentController: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        
        return cv
    }()
    var currentIndexVariable: Variable<Int> = Variable<Int>(0)
    
    let cellId = "CellId"
    var currentIndex = 0 {
        didSet {
            self.currentIndexVariable.value = currentIndex
        }
    }
    
    var lcLeadingMenu: NSLayoutConstraint?
    var lcTraillingMenu: NSLayoutConstraint?
    var lcHeightMenu: NSLayoutConstraint?
    
    var controllers: [UIViewController] = [] {
        didSet {
            cvContentController.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configureCollection()
        vMenu.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func setUpView() {
        self.view.addSubview(vContaintMenu)
        self.vContaintMenu.addSubview(vMenu)
        self.view.addSubview(cvContentController)
        
        if #available(iOS 11, *) {
            //---
            vContaintMenu.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            lcHeightMenu = vContaintMenu.safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: 47.5)
            lcHeightMenu?.isActive = true
            
            vMenu.topAnchor.constraint(equalTo: vContaintMenu.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            vMenu.bottomAnchor.constraint(equalTo: vContaintMenu.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            
            lcLeadingMenu = vMenu.leftAnchor.constraint(equalTo: vContaintMenu.safeAreaLayoutGuide.leftAnchor, constant: 0)
            lcLeadingMenu?.isActive = true
            
            lcTraillingMenu = vMenu.rightAnchor.constraint(equalTo: vContaintMenu.safeAreaLayoutGuide.rightAnchor, constant: 0)
            lcTraillingMenu?.isActive = true
            
            cvContentController.anchor(vContaintMenu.safeAreaLayoutGuide.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        } else {
            //---
            vContaintMenu.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            lcHeightMenu = vContaintMenu.heightAnchor.constraint(equalToConstant: 47.5)
            lcHeightMenu?.isActive = true
            
            vMenu.topAnchor.constraint(equalTo: vContaintMenu.topAnchor, constant: 0).isActive = true
            vMenu.bottomAnchor.constraint(equalTo: vContaintMenu.bottomAnchor, constant: 0).isActive = true
            
            lcLeadingMenu = vMenu.leftAnchor.constraint(equalTo: vContaintMenu.leftAnchor, constant: 0)
            lcLeadingMenu?.isActive = true
            
            lcTraillingMenu = vMenu.rightAnchor.constraint(equalTo: vContaintMenu.rightAnchor, constant: 0)
            lcTraillingMenu?.isActive = true
            
            cvContentController.anchor(vContaintMenu.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        }
    }
}

extension KPageViewController: KPageMenuViewDelegate {
    func setUpViewMenu(menuColorBackground: UIColor, menuFont: UIFont, menuColorNormal: UIColor, menuColorSelected: UIColor, menuColorHorizontal: UIColor, heightHorizontal: CGFloat, listItem: [KCategory], isFull: Bool = false, isHaveLineTop: Bool = false) {
        vMenu.backgroundColor = menuColorBackground
        vMenu.menuFont = menuFont
        vMenu.menuColorSelected = menuColorSelected
        vMenu.menuColorNormal = menuColorNormal
        vMenu.heightHorizontal = heightHorizontal
        vMenu.menuColorHorizontal = menuColorHorizontal
        vMenu.isFullView = isFull
        vMenu.vLineTop.isHidden = !isHaveLineTop
        
        vMenu.listItem = listItem
    }
    
    func setController(listController: [UIViewController]) {
        self.controllers = listController
    }
    
    private func setLayoutMenu(leading: CGFloat, trailling: CGFloat, heightMenu: CGFloat = 47.5) {
        lcTraillingMenu?.constant = 0 - trailling
        lcLeadingMenu?.constant = leading
        lcHeightMenu?.constant = heightMenu
    }
    
    func itemMenuSelected(index: Int) {
        currentIndex = index
        let controller = controllers[index]
        controller.viewWillAppear(true)
        let indexPath = IndexPath(item: index, section: 0)
        cvContentController.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    private func scrollToController(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        cvContentController.scrollToItem(at: indexPath, at: .left, animated: true)
        vMenu.scrollToIndex(index: index)
        let controller = controllers[index]
        controller.viewWillAppear(true)
    }
}

// MARK: handle Collection view
extension KPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollection() {
        cvContentController.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cvContentController.delegate = self
        cvContentController.dataSource = self
        
        if let flow = cvContentController.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let controler = controllers[indexPath.item]
        addChildViewController(controler)
        controler.view.frame = cell.bounds
        cell.addSubview(controler.view)
        controler.view.fillSuperview()
        didMove(toParentViewController: controler)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let controler = controllers[indexPath.item]
        controler.view.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        vMenu.setHorizontal(index: currentIndex)
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int ( targetContentOffset.pointee.x / cvContentController.frame.width )
        currentIndex = index
        vMenu.scrollToIndex(index: index)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let controler = controllers[indexPath.item]
        if let _con = controler as? KPageViewController {
            _con.cvContentController.reloadData()
        } else {
            controler.viewWillAppear(true)
        }
    }
}

extension KPageViewController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.cvContentController.collectionViewLayout.invalidateLayout()
            self.vMenu.cvMenu.collectionViewLayout.invalidateLayout()
            if self.currentIndex == 0 {
                self.cvContentController.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.currentIndex, section: 0)
                self.cvContentController.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        }) { (_) in
            
        }
    }
    
}

//--- KPageViewControllerCell

class KPageViewControllerCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setUpView() {
        self.backgroundColor = .clear
    }
}
