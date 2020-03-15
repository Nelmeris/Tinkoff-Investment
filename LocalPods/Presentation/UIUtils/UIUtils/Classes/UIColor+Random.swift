//
//  UIColor+Random.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

extension UIColor {
    public class var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
