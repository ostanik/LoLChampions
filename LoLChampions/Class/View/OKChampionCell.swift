//
//  OKChampionCell.swift
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//
import Kingfisher
/// Classe view criada para exibir o campeão (tela de listagem)
class OKChampionCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    /**
     Função que conecta o model na celula
     
     - parameter champion: model do campeão
     */
    func bind (champion:Champions){
        self.name.text = champion.name
        self.title.text = champion.title
        self.thumb.kf_setImageWithURL(NSURL(string:champion.iconPath!)!,
            placeholderImage:UIImage(named: "Holder"),
            optionsInfo: [.Transition(ImageTransition.Fade(1))])
    }
}
