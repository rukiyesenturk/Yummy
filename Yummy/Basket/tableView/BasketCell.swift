//
//  BasketCell.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 22.09.2022.
//

import UIKit

protocol BasketCellProtocol {
    func btnIncreasePieceClicked(indexPath:IndexPath, foodPiece: Int)
    func btnDecreasePieceClicked(indexPath:IndexPath, foodPiece: Int)
}
class BasketCell: UITableViewCell {

    @IBOutlet weak var basketBackground: UIView!
    @IBOutlet weak var lblFoodName: UILabel!
  
    @IBOutlet weak var imgFoodBasket: UIImageView!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodPiece: UILabel!
    

    var basketProtocol: BasketCellProtocol?
    var indexPath:IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnIncreasePiece(_ sender: UIButton) {
        if var foodPiece = Int(lblFoodPiece.text!) {
            foodPiece += 1
            lblFoodPiece.text = String(foodPiece)
            basketProtocol?.btnDecreasePieceClicked(indexPath: indexPath!, foodPiece: foodPiece)
        }
    }
    
    @IBAction func btnDecreasePiece(_ sender: UIButton) {
        if var foodPiece = Int(lblFoodPiece.text!) {
            if foodPiece > 1 {
                foodPiece -= 1
                lblFoodPiece.text = String(foodPiece)
                basketProtocol?.btnIncreasePieceClicked(indexPath: indexPath!, foodPiece: foodPiece)
            }
        }
    }

}

