//
//  ContentView.swift
//  Conversions App
//
//  Created by Ujval Shah on 06/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var userTemp = 0.0
    @State private var tempInput = ""
    @State private var tempOutput = ""
    @FocusState private var tempFocused : Bool
    var ConvertedTemp : Double {
        var convertedtemp = 0.0
        if tempInput == "Celsius" {
            if tempOutput == "Fahrenheit"{
                convertedtemp = (userTemp * 9/5) + 32
            }
            else{
                convertedtemp = userTemp + 273.15
            }
        }
        if tempInput == "Fahrenheit" {
            if tempOutput == "Celsius"{
                convertedtemp = (userTemp - 32) * 5/9
            }
            else{
                convertedtemp = (userTemp - 32) * 5/9 + 273.15
            }
        }
        if tempInput == "Kelvin" {
            if tempOutput == "Celsius"{
                convertedtemp = userTemp - 273.15
            }
            else{
                convertedtemp = (userTemp - 273.15) * 9/5 + 32
            }
        }
        if tempInput == tempOutput {
            convertedtemp = userTemp
        }
        return convertedtemp
    }
    let tempUnit = ["Celsius","Fahrenheit","Kelvin"]
    var body: some View {
        NavigationView{
            Form {
                Section{
                    Picker("Temperature Input Unit",selection: $tempInput){
                        ForEach(tempUnit, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Input Unit")
                }
                Section{
                    Picker("Temperature Output Unit",selection: $tempOutput){
                        ForEach(tempUnit, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Output Unit")
                }
                Section{
                    TextField("Temperature" , value: $userTemp, format:.number)
                        .keyboardType(.decimalPad)
                        .focused($tempFocused)
                } header: {
                    Text("Enter the number you want to convert")
                }
                Section {
                    Text(ConvertedTemp , format:.number)
                }header: {
                    Text("Converted Temperature")
                }
            } .navigationTitle("The Converter")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard) {
                            Button("Done") {
                                tempFocused = false
                            }
                        }
                }
        }
    }
}

//enum TemperatureUnit:String , CaseIterable {
//    case 
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
