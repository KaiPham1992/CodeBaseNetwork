//
//  ViewController.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import UIKit
import  RxSwift

class ViewController: UIViewController {
    let bag = DisposeBag()
    @IBOutlet weak var cvTest: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
    }
    
    func getList() {
        APIProvider(target: TestAPI.getAllWordbook()).rxRequestArray(TestModel.self).subscribe(onNext: { (testList) in
            testList.forEach({ (test) in
                print(test.nameWordBook)
            })
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: bag)
    }
    
    func getOne() {
        APIProvider(target: TestAPI.getWordbookWith(id: "Wb22")).rxRequestObject(TestModel.self).subscribe(onNext: { (model) in
            print(model?.nameWordBook)
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: bag)
    }

}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollection() {
        cvTest.registerCustomCell(TestCell.self, fromNib: true)
        cvTest.registerCustomHeader(TestCell.self, fromNib: true)
        cvTest.registerCustomFooter(TestCell.self, fromNib: true)
        cvTest.delegate = self
        cvTest.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCustomCell(TestCell.self, indexPath: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueCustomHeader(TestCell.self, indexPath: indexPath)
            header.backgroundColor = .yellow
            
            return header
        } else {
            let header = collectionView.dequeueCustomFooter(TestCell.self, indexPath: indexPath)
            header.backgroundColor = .green
            
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
}


