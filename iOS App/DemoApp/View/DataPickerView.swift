//
//  DataPickerView.swift
//  DemoApp
//
//  Created by Erick Sanchez on 10/02/20.
//  Copyright © 2020 David Morales. All rights reserved.
//

import UIKit
import Foundation

protocol DataPickerViewDelegate {
	func optionSelected(field:UITextField, position:Int);
}

class DataPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
	
	var pickerData : [String]!;
	var pickerTextField : UITextField!;
	var initialId:String! = "";
	var deli : DataPickerViewDelegate! = nil {
		
		didSet {
			
			if (pickerData != nil && (pickerData?.count)! > 0) {
				//deli.initialOption(obj: pickerData[0]);
			}
		}
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame);
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public init(pickerData: [String]!, dropdownField: UITextField) {
		
		super.init(frame: CGRect.zero);
		self.pickerData = pickerData;
		self.pickerTextField = dropdownField;
		
		self.delegate = self;
		self.dataSource = self;
		
		DispatchQueue.main.async {
			
			if (pickerData.count > 0) {
				
				self.pickerTextField.text = self.pickerData[0];
				self.pickerTextField.isEnabled = false;
				
				if (pickerData.count > 1) {
					
					self.pickerTextField.isEnabled = true;
					
					let w = UIWindow.init(frame: UIScreen.main.bounds).bounds.width;
					let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: w, height: 40));
					
					let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonPressed(sender:)));
					
					let label = UILabel(frame: CGRect(x: 0, y: 0, width: w/3, height: 40));
					label.text = "Escoge una opción:";
					let labelButton = UIBarButtonItem(customView:label);
					let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil);
					toolBar.setItems([flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true);
					
					// -- Adding toolbar
					self.pickerTextField.inputAccessoryView = toolBar;
					
					// -- Adding right icon
					self.pickerTextField.rightViewMode = UITextField.ViewMode.always;
					let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 28));
					imageView.image = UIImage(named: "arrow_down");
					self.pickerTextField.rightView = imageView;
				}
				
			} else {
				
				self.pickerTextField.text = nil;
				self.pickerTextField.isEnabled = false;
			}
		}
	}
	
	@objc func doneButtonPressed(sender: UIBarButtonItem) {
		self.pickerTextField.resignFirstResponder();
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1;
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerData.count;
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerData[row];
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		self.pickerTextField.resignFirstResponder();
		pickerTextField.text = pickerData[row];
		if (self.deli != nil) {
			self.deli.optionSelected(field: self.pickerTextField, position: row);
		}
	}
}
