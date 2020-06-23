When a player makes a potion, the script will normalize or replace dynamic (custom) potions with standard ones.

# How to build

## Clone this repository
```
git clone https://github.com/Sarevalak/tes3mp-custom-potion-normalizer.git
cd ./tes3mp-custom-potion-normalizer
```
## Install dependencies
```
npm i
```

## Build
```
npm run build
```

## Install lua script on tes3mp server

1. Copy contents of directory `./dist/custom` to `/server/scripts/custom`
2. Copy contents of directory `./data` to `/server/data`
2. Add `require("custom/CustomPotionNormalizer")` to `/server/scripts/customScripts.lua`
