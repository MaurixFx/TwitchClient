//
//  MockCollectionView.swift
//  TwitchClientTests
//
//  Created by Mauricio Figueroa olivares on 24-05-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class MockCollectionView: UICollectionView {

    var reloadDataIsCalled: Bool = false
    
    override func reloadData() {
        super.reloadData()
        reloadDataIsCalled = true
    }
}
