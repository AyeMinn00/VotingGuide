//
//  InfiniteListDelegate.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

protocol InfiniteListDelegate : class {
    /*
     regiter main cell
     */
    func registerCell()
    
    /*
     for collection view cell offset to request next
     */
    func getOffSet() -> Int
    
    /*
     preform request because collection view did meet end of screen
     */
    func loadData()
    
    /*
     to create data source
     */
    func makeDataSource()

    /*
     create collectionlayout to provide cell width and height and style
     */
    func createCollectionLayout() -> UICollectionViewLayout

    /*
     to listen view model changes
     */
    func watchData()
    
}
