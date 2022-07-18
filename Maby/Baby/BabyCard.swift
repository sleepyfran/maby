import Factory
import MabyKit
import SwiftUI

struct BabyCard: View {
    let baby: Baby
    
    var body: some View {
        VStack {
            HStack {
                Text("👶🏻")
                    .font(.system(size: 80))
                    .padding([.trailing], 20)
                
                VStack(alignment: .leading) {
                    Text(baby.name)
                        .font(.title)
                    
                    Text("\(baby.formattedAge) old")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 8)
    }
}

#if DEBUG
struct BabyCard_Previews: PreviewProvider {
    static var previews: some View {
        BabyCard(baby: Baby(
            context: Container.previewContainer().viewContext,
            name: "Test Baby",
            birthday: Calendar.current.date(
                byAdding: .weekOfMonth,
                value: -10,
                to: Date.now
            )!,
            gender: Baby.Gender.boy
        ))
    }
}
#endif
