name=SBUtilities
ifndef PKG_TARG
target :=
else
target := $(PKG_TARG)-
endif

SDK = /var/toolchain/sys30

substrate := -I../mobilesubstrate -L../mobilesubstrate -lsubstrate

all: $(name).dylib

$(name).dylib: Tweak.mm makefile ../mobilesubstrate/substrate.h
	$(target)g++ -dynamiclib -g0 -O2 -Wall -o $@ $(filter %.mm,$^) -framework CoreFoundation -framework Foundation -lobjc -init _TweakInitialize -framework CoreGraphics -framework ImageIO -framework GraphicsServices -framework Celestial $(substrate) -framework UIKit -F$(SDK)/System/Library/PrivateFrameworks -F$(SDK)/System/Library/Frameworks -L$(SDK)/usr/lib
	ldid -S $@