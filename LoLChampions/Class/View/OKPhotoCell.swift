//
//  OKPhotoCell.swift
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//
import Kingfisher
/// Classe view da celula de Splash do campeão (tela de info)
class OKPhotoCell: UITableViewCell {
    @IBOutlet weak var Photo: UIImageView!
    
    /**
     Função que conecta o model na celula
     
     - parameter champion: model de informações do campeão
     */
    func bind(champinf:ChampInfo) {
        self.Photo.kf_setImageWithURL(NSURL(string:champinf.splashPath!)!,
            placeholderImage:UIImage(named: "HolderInfo"),
            optionsInfo: [.Transition(ImageTransition.Fade(1))])
    }
}
