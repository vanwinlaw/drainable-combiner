# drainable-combiner
A Project Zomboid mod that will combine all of a single selected drainable item in the players inventory on a single inventory click. Get away from having to combine each singular item.

## Status
| Mode | Works | Notes |
| ----- | ----- | ----- | 
| Singleplayer | ✔️ | |
| Multiplayer | ✔️ | Seems to work fine on 41.66 |
| Splitscreen Co-op | ⚠️ - Unverified | |


## How
Right click on the drainable item in your inventory and click "Combine All". Your character will go through the process of combining the glue until it is as condensed as possible.

![image](https://user-images.githubusercontent.com/15162189/155799635-44a6f4cb-7091-4d68-9248-7c923c96602d.png)

#### Note
This functionality only works for items with a `canConsolidate = true` according to Project Zomboid. Things like Car Batteries/etc will not present the option.

### Translations
If you are fluent in a language and would like to contribute to this mod to make it better, please feel free to reach out and provide the following translations with your country code/language. Or open up a PR yourself! 

See existing text to translate [here](https://github.com/vanwinlaw/drainable-combiner/blob/master/Contents/mods/Drainable%20Combiner/media/lua/shared/Translate/EN/UI_EN.txt). 

#### Currently Supported
- CN (Chinese)
- EN (English)
- FR (French)
- IT (Italia)


## Mod Disclaimer
Use at your own risk. This is just an excuse for me to play around with PZ modding, however I hope others find it useful and that it works as well.

## Release
- Remove the `ISCombineAlldebug.lua` file before releasing it to the workshop.
- Update work notes in Steam to detail the functionality released.
- Update GitHub releases.