import Factory
import MabyKit
import SwiftUI

struct BabyCard: View {
    @FetchRequest private var babies: FetchedResults<Baby>
    
    init() {
        self._babies = FetchRequest(fetchRequest: allBabies)
    }
    
    private var baby: Baby {
        babies.first!
    }
    
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
        BabyCard()
            .mockedDependencies()
    }
}
#endif
