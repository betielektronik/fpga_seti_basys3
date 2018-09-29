----------------------------------------------------------------------------------
-- Company: 


--DOT MATRIX DENEYÝ--UYGULAMA 1--
--8*8 RGB DOT MATRIX MODÜLÜ KULLANILARAK
--SIRASIYLA B,E,T,Ý HARFLERÝ GÖRÜNTÜLENÝR.

--NOT:




--KOD ÝÇÝNDEKÝ SÝNYALLERÝN GÖREVLERÝNÝN TAM OLARAK ANLAÞILABÝLMESÝ ÝÇÝN
--BETÝ FPGA EÐÝTÝM SETÝ DOT MATRÝX MODÜLÜ DONANIMSAL OLARAK ÝNCELENMELÝDÝR.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity beti_duz is
port(
			  CLOCK : in  STD_LOGIC;--50 MHz
         
			  OE:inout std_logic;--output enable
			  
			  SH_CP:OUT STD_LOGIC;--shift register clock pulse
			  ST_CP:OUT STD_LOGIC;--store register clock pulse
			  
			  reset:OUT STD_LOGIC;--shift register için reset
		
			  
				DS : out  std_logic;--digital signal
				
           KATOT : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end beti_duz;

architecture Behavioral of beti_duz is
signal mesaj:std_logic_vector(24 downto 1);
alias kýrmýzý : Std_Logic_Vector(7 downto 0) is mesaj(24 downto 17) ;
alias yesil: Std_Logic_Vector(7 downto 0) is mesaj(16 downto 9) ;
alias mavi : Std_Logic_Vector(7 downto 0) is mesaj(8 downto 1) ;

signal f:std_logic;
signal e:std_logic;

begin
process(clock)

variable counter: unsigned(7 downto 0);
variable i:integer range 410 downto 1:=1;--data signalin seri olarak iletilmesini kontrol eder.
variable a:integer range 7 downto 0:=0;
variable d:integer range 100 downto 0:=0;

begin


if rising_edge(clock) then--registerlar için clock üretmek için kullanýlýyor.
counter:=counter+1;
end if;

f<=counter(7);--Shift register için saat
e<=not f;--Shift register için saat

if rising_edge(e) then--sei olarak datayý almak için her clock pulse tan sonra i bir arttýrýlýyor.
i:=i+1;
end if;

if i<4 then---baþlangýçta i 4'e gelene kadar sisteme reset atýlýr.
reset<='0';
else
reset<='1';
end if;

if i>3 and i<28 then--4'le 27 arasýnda data akýþý seri olarak.
DS<=mesaj(i-3);
else 
DS<='0';
end if;

if i<28 then--i 28'a geldiðinde data akýþý tamamlanýyor.24 bit data alýnmýþ oluyor. 
SH_CP<=f;	--bu sureden sonra clock durduluyor yeni data akýþýna kadar.             
ST_CP<=e;
else
SH_CP<='0';
ST_CP<='1';
end if;

if rising_edge(f) then--clock un durduðu surede OE=0 yani output registerin çýkýþýnda aktif durumda.
if (i>28 and i<409) then
oe<='0';
else
oe<='1';
end if;
end if;

if rising_edge(f) then--bir satýr tamamlandýðýnda a bir arttýrýlýyor 2. satýra geçmek için.
if i=410 then
a:=a+1;
end if;
end if;

if rising_edge(f) then--satrlar ve sutunlar tamamlandýðýnda yeni görüntü için(ful ekran) d bir arttýrýlýyor.
if i=410 then
if a=7 then
d:=d+1;
end if;
end if;
end if;

--a katotlarý taramak için kullanýlýyor.
		
if a=0 then
katot<="10000000";
elsif a=1 then
katot<="01000000";
elsif a=2 then
katot<="00100000";
elsif a=3 then
katot<="00010000";
elsif a=4 then
katot<="00001000";
elsif a=5 then
katot<="00000100";
elsif a=6 then
katot<="00000010";
else
katot<="00000001";
end if;

		if d<25 then--B

if a=0 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=1 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=2 then
kýrmýzý<="00000000";
mavi<="01101100";
yesil<="00000000";
elsif a=3 then
kýrmýzý<="00000000";
mavi<="10010010";
yesil<="00000000";
elsif a=4 then
kýrmýzý<="00000000";
mavi<="10010010";
yesil<="00000000";
elsif a=5 then
kýrmýzý<="00000000";
mavi<="11111110";
yesil<="00000000";
elsif a=6 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
else
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
end if;

		elsif d<50 then--E

if a=0 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=1 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=2 then
kýrmýzý<="00000000";
mavi<="10000010";
yesil<="00000000";
elsif a=3 then
kýrmýzý<="00000000";
mavi<="10010010";
yesil<="00000000";
elsif a=4 then
kýrmýzý<="00000000";
mavi<="10010010";
yesil<="00000000";
elsif a=5 then
kýrmýzý<="00000000";
mavi<="11111110";
yesil<="00000000";
elsif a=6 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
else				
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
end if;
		
		elsif d<75 then----T
		
if a=0 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=1 then
kýrmýzý<="00000000";
mavi<="10000000";
yesil<="00000000";
elsif a=2 then
kýrmýzý<="00000000";
mavi<="10000000";
yesil<="00000000";
elsif a=3 then
kýrmýzý<="00000000";
mavi<="11111110";
yesil<="00000000";
elsif a=4 then
kýrmýzý<="00000000";
mavi<="10000000";
yesil<="00000000";
elsif a=5 then
kýrmýzý<="00000000";
mavi<="10000000";
yesil<="00000000";
elsif a=6 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
else
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
end if;

		else		----Ý
		
if a=0 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=1 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=2 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=3 then
kýrmýzý<="00000000";
mavi<="10111110";
yesil<="00000000";
elsif a=4 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=5 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
elsif a=6 then
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
else
kýrmýzý<="00000000";
mavi<="00000000";
yesil<="00000000";
end if;

		end if;

end process;
end Behavioral;