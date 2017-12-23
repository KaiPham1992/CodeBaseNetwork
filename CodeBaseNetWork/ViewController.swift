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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOne()
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

