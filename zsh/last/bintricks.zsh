# Stole from https://gist.github.com/ohdae/6e52464f8d03b65be37a
dec2hex() { printf "%x\n" "$1"; }
hex2dec() { echo $((0x${1#0x})); }
dec2bin() { echo "obase=2;$1" | bc; }
bin2dec() { echo $((2#$1)); }
b64d() { echo $1 | base64 -d; }
asmgrep() { objdump -d "$2" | grep --color -C 4 -E "$1"; }

hex2bin()
{
    local bin
    for i in $*; do
        bin=$(echo "obase=2;ibase=16;$(echo $i | tr a-f A-F)" | bc)
        echo -n "$bin "
    done
    echo
}

dumpmem()
{
    local stack_addr=$(grep -m 1 "$1" /proc/$2/maps |
     cut -d' ' -f1 | sed 's/^/0x/; s/-/ 0x/')

    test -n "$stack_addr" && \
    echo "dump memory "$3" $stack_addr" | gdb --pid $2 &> /dev/null
}

ip2bin()
{
    local r
    r=$(echo $1 | tr . \;)

    (for i in $(echo "obase=2;$r" | bc); do printf '%.8d.' $i; done) | sed 's/.$//'
    echo
}

geoip()
{
    wget -q --timeout=30 "http://xml.utrace.de/?query=$1" -O - | sed '4d' | sed "s/<[^>]*>//g; s/\t//g; /^$/d" | tr '\n' ',' ; echo "\n"

}

dec2asc() { echo -e $(printf "\\\x%x" $1); }
asc2dec() { printf "%d\n" "'$1"; }

asciitable()
{
    echo -en \
    "Dec Hex    Dec Hex    Dec Hex  Dec Hex  Dec Hex  Dec Hex   Dec Hex   Dec Hex\n\                           
    0 00 NUL  16 10 DLE  32 20    48 30 0  64 40 @  80 50 P   96 60 \`  112 70 p\n\
    1 01 SOH  17 11 DC1  33 21 !  49 31 1  65 41 A  81 51 Q   97 61 a  113 71 q\n\
    2 02 STX  18 12 DC2  34 22 \"  50 32 2  66 42 B  82 52 R   98 62 b  114 72 r\n\
    3 03 ETX  19 13 DC3  35 23 #  51 33 3  67 43 C  83 53 S   99 63 c  115 73 s\n\
    4 04 EOT  20 14 DC4  36 24 $  52 34 4  68 44 D  84 54 T  100 64 d  116 74 t\n\
    5 05 ENQ  21 15 NAK  37 25 %  53 35 5  69 45 E  85 55 U  101 65 e  117 75 u\n\
    6 06 ACK  22 16 SYN  38 26 &  54 36 6  70 46 F  86 56 V  102 66 f  118 76 v\n\
    7 07 BEL  23 17 ETB  39 27 '  55 37 7  71 47 G  87 57 W  103 67 g  119 77 w\n\
    8 08 BS   24 18 CAN  40 28 (  56 38 8  72 48 H  88 58 X  104 68 h  120 78 x\n\
    9 09 HT   25 19 EM   41 29 )  57 39 9  73 49 I  89 59 Y  105 69 i  121 79 y\n\
   10 0A LF   26 1A SUB  42 2A *  58 3A :  74 4A J  90 5A Z  106 6A j  122 7A z\n\
   11 0B VT   27 1B ESC  43 2B +  59 3B ;  75 4B K  91 5B [  107 6B k  123 7B {\n\
   12 0C FF   28 1C FS   44 2C ,  60 3C <  76 4C L  92 5C \\  108 6C l  124 7C |\n\
   13 0D CR   29 1D GS   45 2D -  61 3D =  77 4D M  93 5D ]  109 6D m  125 7D }\n\
   14 0E SO   30 1E RS   46 2E .  62 3E >  78 4E N  94 5E ^  110 6E n  126 7E ~\n\
   15 0F SI   31 1F US   47 2F /  63 3F ?  79 4F O  95 5F _  111 6F o  127 7F DEL\n"
}

alias dumpstack='dumpmem stack'
alias dumpheap='dumpmem heap'

sc2asm()
{
    local mode=32
    local in="$1"

    [ $1 = '-m' ] && mode=$2 in="$3"

    sc=$(echo "$in" | sed 's/\\x/ /g')
    echo "$sc" | udcli -$mode -x -noff -nohex | sed 's/^ //'
}

asm2sc()
{
    local obj=$(mktemp)
    local fmt=elf32
    local in="$1"

    [ $1 = "-f" ] && fmt=$2 in="$3"

    nasm -f $fmt -o $obj $in 

    objdump -M intel -D $obj |
     tr -d \\t |
     sed -nr 's/^.*:(([0-9a-f]{2} )*).*$/\1/p' | 
     tr -d \\n |
     sed 's/\(..\) /\\x\1/g'

    echo
    rm -f $obj                                                                                   
}


