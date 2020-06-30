xcodebuild -project CleanMVVM.xcodeproj \
            -scheme CleanMVVM \
            -destination platform=iOS\ Simulator,OS=13.3,name=iPhone\ 11 \
            clean test
