//
//  ContentView.swift
//  WeSplit
//
//  Created by Bibek Bhujel on 30/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State
    private var checkAmount = 0.0
    
    @State
    private var tipPercent = 20
    
    @State
    private var numberOfPeople = 2
    
    var totalTip: Double {
       let tipSelection = Double(tipPercent)
        let tipValue = checkAmount * tipSelection * 0.01
        return tipValue
    }
    
    var totalAmountWithTip:Double {
        let grandTotal = totalTip + checkAmount
        return grandTotal
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
       let amountPerPerson = totalAmountWithTip / peopleCount
       return amountPerPerson
    }
    
    @FocusState
    private var amountIsFocued: Bool
    
    var body: some View {
        NavigationStack {
        Form {
            Section("Enter amount"){
                TextField("Enter Amount:", value: $checkAmount,
                          format: .currency(code:Locale.current.currency?.identifier ?? "NEP"))
                .keyboardType(.decimalPad)
                .focused($amountIsFocued)
            }
            
            Section("Tip Percent") {
                PickerComponentView(pickerLabel: "Tip Percent", selectedValue: $tipPercent, pickerRange: 0...100
                ).pickerStyle(.navigationLink)
            }
          
            
            Section("Splitting into"){
                PickerComponentView(pickerLabel: "Number Of People", selectedValue: $numberOfPeople, pickerRange: 2...100)
                    .pickerStyle(.navigationLink)
            }
            
            Section("total Tip") {
                ShowInformationView(data: totalTip)
            }
            
            Section("total amount with tip") {
                ShowInformationView(data:totalAmountWithTip)
                    .foregroundStyle(tipPercent == 0 ? .red : .black)
            }
            
            Section("total per person"){
               ShowInformationView(data: totalPerPerson)
               }
            
        }.navigationTitle("We Split")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if amountIsFocued {
                        Button("Done") {
                            amountIsFocued = false
                        }
                    }
                }
        }
    }
}

struct Person {
    let name: String = "bibek"
}

#Preview {
    ContentView()
}
struct ShowInformationView: View  {
    var data: Double
    var body: some View {
        Text(data,format: .currency(code:Locale.current.currency?.identifier ?? "NEP"))
    }
}

struct PickerComponentView: View {
    let pickerLabel: String
  
    @Binding
    var selectedValue: Int
    
    let pickerRange: ClosedRange<Int>
    
        var body: some View {
        Picker(pickerLabel,selection: $selectedValue) {
            ForEach(pickerRange, id: \.self) {
                number in Text("\(number)")
            }
        }
    }
}





