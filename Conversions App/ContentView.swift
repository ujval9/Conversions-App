//
//  ContentView.swift
//  Conversions App
//
//  Created by Ujval Shah on 06/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var userTemp = 0.0
    @State private var unitInput:TemperatureUnit = .celsius
    @State private var unitOutput:TemperatureUnit = .fahrenheit
    @State private var inputTemperature: String = ""
    @State private var outputTemperature: String = ""
    @FocusState private var tempFocused : Bool

//    let tempUnit = ["Celsius","Fahrenheit","Kelvin"]
    
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    HStack {
                        TextField("Temperature Input" , text: $inputTemperature)
                            .keyboardType(.decimalPad)
                        .focused($tempFocused)
                        Text(unitInput.symbol)
                    }
                } header: {
                    Text("Enter the temperature you want to convert")
                }
                Section{
                    Picker("Input Unit",selection: $unitInput){
                        ForEach(TemperatureUnit.allCases, id: \.self){
                            unit in
                            Text(unit.name)
                        }
                    }.pickerStyle(.segmented)
                        .onChange(of: unitInput){ tag in
                            converTempertaure()
                        }
                }header: {
                    Text("Input Unit")
                }
                Section{
                    Picker("Output Unit",selection: $unitOutput){
                        ForEach(TemperatureUnit.allCases, id: \.self){
                            unit in
                            Text(unit.name)
                        }
                    }.pickerStyle(.segmented)
                        .onChange(of: unitOutput){ tag in
                            converTempertaure()
                        }
                }header: {
                    Text("Output Unit")
                }

                Section {
                    HStack {
                        Text(outputTemperature)
                        Text(unitOutput.symbol)
                    }
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
    private func converTempertaure () {
        let input = Double(inputTemperature) ?? 0.0
        let inputInCelsius = unitInput.convertToCelsius(input)
        outputTemperature = String(format: "%.2f", unitOutput.convertFromCelsius(inputInCelsius))
    }
}

enum TemperatureUnit:String , CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var name:String{
        return self.rawValue
    }
    var symbol:String {
        switch self {
            case .celsius: return "°C"
            case .fahrenheit: return "°F"
            case .kelvin: return "K"
        }
    }
    func convertToCelsius(_ temperature: Double) -> Double {
        switch self {
            case .celsius: return temperature
            case .fahrenheit: return (temperature - 32) / 1.8
            case .kelvin: return temperature - 273.15
        }
    }
    
    func convertFromCelsius(_ temperature: Double) -> Double {
        switch self {
            case .celsius: return temperature
            case .fahrenheit: return temperature * 1.8 + 32
            case .kelvin: return temperature + 273.15
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
