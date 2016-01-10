//
//  OKStatisticsCell.swift
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//
import MBCircularProgressBar
/// Classe view da celula de estatistica (graficos) do campeão (tela de info)
class OKStatisticsCell: UITableViewCell {
    @IBOutlet weak var Statistic: MBCircularProgressBarView!
    
    /**
     Função que conecta o model na celula
     
     - parameter champion: model de informações do campeão
     */
    func bind(champinf:ChampInfo, kind:NSInteger){
        switch(kind){
        case 1:
            self.Statistic.value = champinf.defense as! CGFloat
        case 2:
            self.Statistic.value = champinf.attack as! CGFloat
        case 3:
            self.Statistic.value = champinf.magic as! CGFloat
        default:
            self.Statistic.value = champinf.difficulty as! CGFloat
        }
        
    }
}
