import SwiftUI

enum FieldType {
    case regular
    case secure
    case dropdown([String])
    case datePicker
}

struct CustomTextField: View {
    let icon: String
    let placeHolder: String
    var useTopLeftPlaceHolder: Bool
    @Binding var text: String
    let fieldType: FieldType
    var datePickerType: DatePickerType = .timeOnly
    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero
    @State private var selectedDate: Date? = nil
    @State private var showDatePicker = false
    @State private var showDropdown = false
    @State private var selectedOption: String?
    
    
    var body: some View {
        HStack(alignment: .center) {
            switch fieldType {
            case .regular:
                TextFieldView(with: self.useTopLeftPlaceHolder)
            case .secure:
                SecureFieldView()
            case .dropdown(let options):
                DropdownView(options: options)
            case .datePicker:
                DatePickerView(with: self.datePickerType)
            }
        }
        .background {
            switch fieldType {
            case .regular:
                backgroundField(with: self.useTopLeftPlaceHolder)
            case .secure:
                backgroundField(with: true)
            case .dropdown(_):
                backgroundField(with: false)
            case .datePicker:
                backgroundField(with: false)
            }
        }
        .frame(minWidth: 150, maxWidth: Constant.UIScreenWidth)
    }
    
    private func backgroundField(with topLeftPlaceHolder: Bool) -> some View {
        ZStack {
            if topLeftPlaceHolder {
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0, to: 0.55)
                    .stroke(.gray, lineWidth: 1)
                
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0.565 + (0.44 * (labelWidth / width)), to: 1)
                    .stroke(.gray, lineWidth: 1)
                
                HStack {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 34, height: 34)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
                Text(placeHolder)
                    .foregroundColor(SwiftUIColor.textBlack)
                    .overlay {
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                labelWidth = geo.size.width
                            }
                        }
                    }
                    .padding(2)
                    .font(FontSize.tabBarItem.font(weight: .regular))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 20, y: -10)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
                
                Text(placeHolder)
                    .foregroundColor(SwiftUIColor.textBlack)
                    .overlay {
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                labelWidth = geo.size.width
                            }
                        }
                    }
                    .padding(2)
                    .font(FontSize.tabBarItem.font(weight: .regular))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 5, y: -30)
                    .lineLimit(1)
            }
            
        }
    }
    
    private func TextFieldView(with topLeftPlaceHolder: Bool) -> some View {
        if topLeftPlaceHolder {
            TextField("", text: $text)
                .foregroundColor(.black)
                .font(FontSize.footnote.font(weight: .regular))
                .keyboardType(.alphabet)
                .padding(EdgeInsets(top: 24, leading: 60, bottom: 24, trailing: 60))
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            width = geo.size.width
                        }
                    }
                }
        } else {
            TextField("", text: $text)
                .foregroundColor(.black)
                .font(FontSize.footnote.font(weight: .regular))
                .keyboardType(.alphabet)
                .padding(EdgeInsets(top: 24, leading: 10, bottom: 24, trailing: 10))
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            width = geo.size.width
                        }
                    }
                }
        }
    }
    
    private func SecureFieldView() -> some View {
        SecureField("", text: $text)
            .foregroundColor(.black)
            .font(FontSize.footnote.font(weight: .regular))
            .keyboardType(.alphabet)
            .padding(EdgeInsets(top: 15, leading: 60, bottom: 15, trailing: 60))
            .overlay {
                GeometryReader { geo in
                    Color.clear.onAppear {
                        width = geo.size.width
                    }
                }
            }
    }
    
    private func DropdownView(options: [String]) -> some View {
            VStack {
                Button(action: {
                    showDropdown.toggle()
                }) {
                    HStack {
                        if let selectedOption = selectedOption {
                            Text(selectedOption)
                                .foregroundColor(SwiftUIColor.textBlack)
                        } else {
                            Text("")
                                .foregroundColor(SwiftUIColor.textWhite)
                        }
                    }
                    .font(FontSize.footnote.font(weight: .regular))
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                    .overlay {
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                width = geo.size.width
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 77, maxHeight: 77)
                }
                if showDropdown {
                    Picker("", selection: Binding(
                        get: { text },
                        set: {
                            text = $0
                            selectedOption = $0
                            showDropdown = false
                        }
                    )) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .tag(option)
                                .foregroundColor(SwiftUIColor.textBlack)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .accentColor(.black)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                }
            }
        }
  
    private func DatePickerView(with type: DatePickerType) -> some View {
        VStack {
            Button(action: {
                showDatePicker.toggle()
            }) {
                HStack {
                    if let date = selectedDate {
                        switch type {
                        case .dateAndTime:
                            Text(dateFormattedToYearMonthDateHourTime(date))
                                .foregroundColor(SwiftUIColor.textBlack)
                        case .timeOnly:
                            Text(dateFormattedToHHmm(date))
                                .foregroundColor(SwiftUIColor.textBlack)
                        }
                    } else {
                        switch type {
                        case .dateAndTime:
                            Text("yyyy-mm-dd HH:mm")
                                .foregroundColor(SwiftUIColor.textGray)
                        case .timeOnly:
                            Text("HH:mm")
                                .foregroundColor(SwiftUIColor.textGray)
                        }
                    }
                }
                .font(FontSize.footnote.font(weight: .regular))
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            width = geo.size.width
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 77, maxHeight: 77)
            
            if showDatePicker {
                DatePicker("", selection: Binding(
                    get: { selectedDate ?? Date() },
                    set: {
                        selectedDate = $0
                        switch type {
                        case .dateAndTime:
                            text = dateFormattedToYearMonthDateHourTime($0)
                        case .timeOnly:
                            text = dateFormattedForParams($0)
                        }
                        
                        showDatePicker = false
                    }
                ), displayedComponents: {
                    switch type {
                    case .dateAndTime:
                        return [.date, .hourAndMinute]
                    case .timeOnly:
                        return [.hourAndMinute]
                    }
                }())
                .labelsHidden()
                .datePickerStyle(.compact)
                .accentColor(SwiftUIColor.orangeColor)
                .background(SwiftUIColor.grayColor)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
        }
    }

    
    private func dateFormattedToHHmm(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func dateFormattedToYearMonthDateHourTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm"
        return formatter.string(from: date)
    }

    
    private func dateFormattedForParams(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}


enum DatePickerType {
    case dateAndTime
    case timeOnly
}
