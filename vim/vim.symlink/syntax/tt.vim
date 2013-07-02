"Created by Svakanda for tt++ January 2008
"    cheshire.in.darkness@gmail.com
"anything behind these double quotes are COMMENTS.  This is a Comment.

"sets the '#' character as a valid keyword character
setlocal iskeyword+=#

"defines valid keywords the '[]'s in #ac[tion] designates autofill, and so on.
syntax keyword ttCommands #alias #ac[tion] #all #bell #buffer #chat #class #colors #config #cr #credits
syntax keyword ttCommands #cursor #delay #echo #end #gag #gagline #help #high[light] #history #if #ig[nore]
syntax keyword ttCommands #debug #escape #forall #format #fu[nction] #grep #history #info #kill #list
syntax keyword ttCommands #loadpath #log #logline #loop #macro #map #mark #math #message #nop 
syntax keyword ttCommands #parse #path #pathdir #prompt #read #rep[lacestring] #savepath #return #scan 
syntax keyword ttCommands #send #session #showme #snoop #spe[edwalk] #split #sub[stitute] #suspend #system 
syntax keyword ttCommands #tab #textin #ti[ck] #unaction #unalias #unclass #unfunction #ungag #unhighlight
syntax keyword ttCommands #unmacro #unpath #unprompt #unsplit #unsubstitute #untab #untick #unvariable
syntax keyword ttCommands #var[iable] #walk #write #zap 

"ttNum is one color group
syntax match ttNum /\d*/ "matches plain numbers

"ttMacros group is one color group
syntax match ttMacros /<\d\d\d>/ "matches color codes such as <030>
syntax match ttMacros /%\d/ "matches dynamic arguments like %0 %1 etc...
syntax match ttMacros /&\d/ "matches list indexes like &0 and &1

"ttIdentifier is one color group
syntax match ttIdentifier /\<\a\+\>/ "matches any string of capital or lowercase letters

syntax match ttVar /\$\%[{]\a*/ "matches variables that are going to be expanded / preceded by the '$' symbol
syntax match ttVar /;/ "matches command separator ';' 

"matchgroup just colors the delimiters '{' and '}'. the contains=ALLBUT is
"means that this region is completely recursive upon itself, and filters down
"to as many inner-regions as you need...in addition it allows
"definitions/matches of all other groups besides ttIdentifier.
"
"The ttVarBlock region is used to color variables expressed within
"braces...such as ${charHp}
syntax region ttBlock matchgroup=ttBraces start=/{/ skip=/$/ end=/}/ contains=ALLBUT,ttIdentifier
syntax region ttVarBlock matchgroup=ttVarBraces start=/${/ end=/}/ contained

"all prior syntax commands just divide different areas into groups, in order
"to actually apply color you need to link the groups (everything that starts
"with two lowercase t's..such as ttBlock and ttMacros) link the groups to
"color...in order to provide user modularity, vim as special groups already
"assigned colors, you can view a list of these groups with the vim command
"-> :help group-name <-  
"The presents I am using below are Number, Special, Statement, Identifier,
"PreProc, and Structure...vim then binds these Groups to color statements...so
"if you want to change the colors, you need to change your vim user settings
"to modify the color of these groups.
"
highlight link ttNum Number

highlight link ttVar Special
highlight link ttVarBraces Special
highlight link ttVarBlock Special

highlight link ttCommands Statement
highlight link ttBraces Statement

highlight link ttIdentifier Identifier

highlight link ttMacros PreProc

highlight link ttBlock Structure

let b:current_syntax = "tt"
