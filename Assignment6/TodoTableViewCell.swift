//
//  TodoTableViewCell.swift
//  Assignment6
//
//  Created by Adriano Gaiotto de Oliveira on 2021-01-08.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    let checkLabel: UILabel = {
        let lb = UILabel()
        lb.text = "✓"
        lb.setContentHuggingPriority(.required, for: .horizontal)
        return lb
    }()
    
    let taskNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    let taskDescLabel: UILabel =  {
        let lb = UILabel()
        lb.numberOfLines = 0
        return lb
    }()
    
    let editSymbolLabel: UIButton = {
        let bt  = UIButton(type: .custom)
        bt.setTitle("ℹ︎",for: .normal)
        bt.setTitleColor(.systemBlue, for: .normal)
        bt.setContentHuggingPriority(.required, for: .horizontal)
        return bt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let vStackView = VerticalStackView(arrangedSubviews: [
            taskNameLabel,
            taskDescLabel
        ], spacing: 0, alignment: .fill,distribution: .fill)
        
        let hStackView = HorizontalStackView(arrangedSubviews: [
            checkLabel, vStackView, editSymbolLabel
        ], spacing: 16, alignment: .fill, distribution: .fill)
        
        contentView.addSubview(hStackView)
        hStackView.matchParent(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with task: Task) {
        
        taskNameLabel.text = task.name
        taskDescLabel.text = task.desc
    }
    
    
    
}