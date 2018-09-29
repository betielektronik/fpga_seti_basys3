----------------------------------------------------------------------------------
-- Company: BETÝ BÝLÝÞÝM

-- 
-- Create Date:    14:36:38 10/14/2010 
-- Design Name: lcd ustune sýcaklýk ve nem deðerini seÇime gÖre yazýrýyor.
-- Module Name:    sht1x_iyilestirme - Behavioral 


--METEOROLOJÝ DENEYÝ--UYGULAMA 1--
--SHT1X METEOROLOJÝ MODÜLÜNDEN SICAKLIK VE NEM
--BÝLGÝSÝ ALINIR VE LCD EKRANA BASTIRILIR.

----------------------------------------------------------------------------------
library IEEE;											--Kütüphane
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity meteoroloji is

generic(
		init_d  : integer  :=  4000000;  --40 ms gecikme
		com_dl  : integer  :=  200000;   --2  ms gecikme
	   com_ds  : integer  :=  5000);    --50 us gecikme
port(			
				clock:in std_logic;--50MHz.
				output: out std_logic:='0';
			
					 LCD_DB	: inout   unsigned(3 downto 0);
                
					 LCD_E	: out	  std_logic;
                LCD_RS	: out	  std_logic;
					 LCD_RW	: out	  std_logic;
					 
				sw0:in std_logic;--0->nem ölçer; 1->sýcaklýk ölçer.
				
				DATA:inout std_logic:='0';
				SCK:out std_logic
							
);
end meteoroloji;

architecture Behavioral of meteoroloji is


type tip_mesaj is array (0 to 45) of unsigned(7 downto 0);
signal  lcd  :  unsigned(6 downto 0):="1111111";
signal mesaj_lcd : tip_mesaj; 
signal	m	:	integer range 0 to 45		:=	0;
signal adim: integer range 0 to 35:=0;
signal D: unsigned(15 downto 0):="0000000000000000";
signal clock_50Mhz : std_logic :='0';
begin



LCD_DB	<=	lcd(3 downto 0);
LCD_E	<=	lcd(6);
LCD_RS	<=	lcd(5);
LCD_RW	<=	lcd(4);

process(clock)
begin
    if rising_edge(clock) then
        clock_50Mhz <= not clock_50Mhz;
    end if;
end process;


process(clock_50Mhz)

variable	adim_lcd	:	integer range 0 to 23		:=	0;
variable	sayac	:	integer range 0 to 5000000	:=	0;




variable butun_vector: unsigned(35 downto 0):="000000000000000000000000000000000000";

alias data_final:unsigned(15 downto 0) is butun_vector(15 downto 0);

alias ten_thousands:unsigned(3 downto 0) is butun_vector(35 downto 32);--BCD converter
alias thousands:unsigned(3 downto 0) is butun_vector(31 downto 28);--BCD converter
alias hundreds :unsigned(3 downto 0) is butun_vector(27 downto 24);--BCD converter
alias tens:unsigned(3 downto 0) is butun_vector(23 downto 20);--BCD converter
alias unit:unsigned(3 downto 0) is butun_vector(19 downto 16);--BCD converter


variable counter:integer range 0 to 100000000:=0;--2s
variable i:integer range 0 to 10:=9;


begin



if rising_edge(clock_50Mhz) then--counter 50.000.000 geldiðinde 1 sn geçmiþ oluyor.
counter:=counter+1;

case (i) is
when 0=>--UYANMASI ÝÇÝN BEKLENÝYOR.
	if counter=600000 then--12 ms geçmiþ oluyor.
	i:=1;
	counter:=0;
	end if;
	adim<=0;
	DATA<='Z';
	SCK<='0';

		
when 1=>--RESET PROSEDÜRÜ
	if counter<5000  then--100us
	SCK<='0';
	elsif counter<10000 then
	SCK<='1';
	elsif counter<15000 then
	SCK<='0';
	elsif counter<20000 then
	SCK<='1';
	elsif counter<25000 then
	SCK<='0';
	elsif counter<30000 then
	SCK<='1';
	elsif counter<35000 then
	SCK<='0';
	elsif counter<40000 then
	SCK<='1';
	elsif counter<45000 then
	SCK<='0';
	elsif counter<50000 then
	SCK<='1';
	elsif counter<55000 then
	SCK<='0';
	elsif counter<60000 then
	SCK<='1';
	elsif counter<65000 then
	SCK<='0';
	elsif counter<70000 then
	SCK<='1';
	elsif counter<75000 then
	SCK<='0';
	elsif counter<80000 then
	SCK<='1';
	elsif counter<85000 then
	SCK<='0';
	elsif counter<90000 then
	SCK<='1';
	elsif counter<95000 then
	SCK<='0';
	end if;
	
DATA<='Z';	

if counter=95000 then
counter:=0;
i:=2;
end if;
		

--when 2=>--SHT1X ÝLE HABERLEÞME BAÞLAR
--	if counter<5000 then--100us
--	SCK<='0';
--	elsif counter<10000 then--200us
--	SCK<='1';
--	elsif counter<15000 then--300us
--	SCK<='0';
--	elsif counter<20000 then--300us
--	SCK<='1';
--	elsif counter<25000 then
--	SCK<='0';
--	end if;
	
--	if counter>7500 and counter<17500 then
--	DATA<='0';
--	else
--	DATA<='Z';
--	end if;
	
--	if counter=25000 then
--	i:=3;
--	counter:=0;
--	end if;
	

--when 3=>--sýcaklýk veya nem ölçümü yapýlmasýný istediðimiz komutun gönderilmesi
--	if counter<500  then--10us
--	SCK<='0';
--	elsif counter<1000 then
--	SCK<='1';
--	elsif counter<1500 then--
--	SCK<='0';
--	elsif counter<2000 then
--	SCK<='1';
--	elsif counter<2500 then--
--	SCK<='0';
--	elsif counter<3000 then
--	SCK<='1';
--	elsif counter<3500 then
--	SCK<='0';
--	elsif counter<4000 then
--	SCK<='1';
--	elsif counter<4500 then
--	SCK<='0';
--	elsif counter<5000 then
--	SCK<='1';
--	elsif counter<5500 then
--	SCK<='0';
--	elsif counter<6000 then
--	SCK<='1';
--	elsif counter<6500 then
--	SCK<='0';
--	elsif counter<7000 then
--	SCK<='1';
--	elsif counter<7500 then
--	SCK<='0';
--	elsif counter<8000 then
--	SCK<='1';
--	elsif counter<8500 then
--	SCK<='0';
--	elsif counter<9000 then
--	SCK<='1';
--	elsif counter<9500 then
--	SCK<='0';
--	end if;
--if sw0='0' then--nem
--		if (counter>5490 and counter<6010) or (counter>7490 and counter<8010)  then--DATA="000"&"00101" => NEM ÖLÇ KOMUTU
--		DATA<='1';
--		elsif counter>8010 then
--		DATA<='Z';
--		else
--		DATA<='0';
--		end if;
--else	--sýcaklýk
	
--		if counter>6490 and counter<8001 then	--DATA="000"&"00011"=> SICAKLIK ÖLÇ KOMUTU
--		DATA<='1';
--		elsif  counter<6490  then
--		DATA<='0';
--		else
--		DATA<='Z';
--		end if;
--end if;		
	
--	if  counter=8900 then--komutu algýlayýp algýlayamadýðýný test eder.
--	if DATA='0' then
--	NULL;
--	else
--	i:=0;
--	counter:=0;
--	end if;
--	end if;
	
--	if counter=9500 then
--	counter:=0;
--	i:=4;
--	end if;


--when 4=>--ölçümün tamamlandýðýna dair SHT1X'den gelecek yanýtýn beklenmesi
	
--	D<="0000000000000000";
--	SCK<='0';
--	DATA<='Z';
	
--	if data='0' then
--	i:=5;
--	counter:=0;
--	end if;

--	if counter=50000000 then--1sn bekledikten sonra data sinyalinde deðiþim olmazsa baþa döner.
--	i:=0;
--	counter:=0;
--	end if;

--when 5=>--1. byte datanýn okunmasý 

--	if counter<500 then--10us
--	SCK<='1';
--	elsif counter<1000 then
--	SCK<='0';
--	elsif counter<1500 then
--	SCK<='1';
--	elsif counter<2000 then--
--	SCK<='0';
--	elsif counter<2500 then
--	SCK<='1';
--	elsif counter<3000 then--
--	SCK<='0';
--	elsif counter<3500 then
--	SCK<='1';
--	elsif counter<4000 then--
--	SCK<='0';
--	elsif counter<4500 then
--	SCK<='1';
--	elsif counter<5000 then--
--	SCK<='0';
--	elsif counter<5500 then
--	SCK<='1';
--	elsif counter<6000 then--
--	SCK<='0';
--	elsif counter<6500 then
--	SCK<='1';
--	elsif counter<7000 then--
--	SCK<='0';
--	elsif counter<7500 then
--	SCK<='1';
--	elsif counter<8000 then
--	SCK<='0';
--	elsif counter<8500 then--ACK baþlar.counter=8000.
--	SCK<='1';
--	elsif counter<9500 then
--	SCK<='0';
--	end if;
	
--if counter=250 then
--D(15)<=DATA;
--elsif counter=1250 then
--D(14)<=DATA;
--elsif counter=2250 then
--D(13)<=DATA;
--elsif counter=3250 then
--D(12)<=DATA;
--elsif counter=4250 then
--D(11)<=DATA;
--elsif counter=5250 then
--D(10)<=DATA;
--elsif counter=6250 then
--D(9)<=DATA;
--elsif counter=7250 then
--D(8)<=DATA;
--end if;

--if counter>8000 and counter<9000 then
--DATA<='0';
--else 
--data<='Z';
--end if;	
	
--if counter=9500 then
--counter:=0;
--i:=6;
--end if;


--when 6=>--2. byte datanýn okunmasý
--	data<='Z';
--	if counter<500 then
--	SCK<='1';
--	elsif counter<1000 then
--	SCK<='0';
--	elsif counter<1500 then
--	SCK<='1';
--	elsif counter<2000 then--
--	SCK<='0';
--	elsif counter<2500 then
--	SCK<='1';
--	elsif counter<3000 then--
--	SCK<='0';
--	elsif counter<3500 then
--	SCK<='1';
--	elsif counter<4000 then--
--	SCK<='0';
--	elsif counter<4500 then
--	SCK<='1';
--	elsif counter<5000 then--
--	SCK<='0';
--	elsif counter<5500 then
--	SCK<='1';
--	elsif counter<6000 then--
--	SCK<='0';
--	elsif counter<6500 then
--	SCK<='1';
--	elsif counter<7000 then--
--	SCK<='0';
--	elsif counter<7500 then
--	SCK<='1';
--	elsif counter<8000 then--
--	SCK<='0';
--	end if;
	
--if counter=250 then
--D(7)<=DATA;
--elsif counter=1250 then
--D(6)<=DATA;
--elsif counter=2250 then
--D(5)<=DATA;
--elsif counter=3250 then
--D(4)<=DATA;
--elsif counter=4250 then
--D(3)<=DATA;
--elsif counter=5250 then
--D(2)<=DATA;
--elsif counter=6250 then
--D(1)<=DATA;
--elsif counter=7250 then
--D(0)<=DATA;
--end if;

--if counter=8000 then
--counter:=0;
--i:=7;
--end if;

--when 7=>	--ilgili hesaplamalarýn yapýlmasý(bknz. SHT1X DATASHEET)

--if sw0='0' then--nem
----data_final:=((((143*D)-512)/4096)*100);
--else--sýcaklýk
--data_final:=D-4010;
--end if;

--i:=8;

--when 8=>--BCD ÇEVÝRÝCÝ

----BÝNARY DATA EKRANDA GÖSTERÝLECEÐÝ ÝÇÝN BCD FORMATINA ÇEVRÝLÝR.

--case adim is

--when 0=>
--unit:="0000";
--tens:="0000";
--hundreds:="0000";
--thousands:="0000";
--ten_thousands:="0000";
--adim<=1;

--when 1=>

--butun_vector:=butun_vector+butun_vector;--SOLA KAYDIR(1 BÝT)
--adim<=2;

--when 2=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=3;

--when 3=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=4;

--when 4=>
--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=5;

--when 5=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=6;

--when 6=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=7;

--when 7=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=8;

--when 8=>
--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=9;

--when 9=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=10;

--when 10=>
--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=11;

--when 11=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=12;

--when 12=>
--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=13;

--when 13=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=14;
--when 14=>
--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=15;

--when 15=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=16;
--when 16=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=17;

--when 17=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=18;
--when 18=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=19;

--when 19=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=20;
--when 20=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=21;

--when 21=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=22;
--when 22=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=23;

--when 23=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=24;
--when 24=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=25;

--when 25=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=26;
--when 26=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=27;

--when 27=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=28;
--when 28=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=29;

--when 29=>

--butun_vector:=butun_vector+butun_vector;--shift left
--adim<=30;
--when 30=>

--if ten_thousands>"0100" then
--ten_thousands:=ten_thousands+"0011";
--end if;
--if thousands>"0100" then
--thousands:=thousands+"0011";
--end if;
--if hundreds>"0100" then
--hundreds:=hundreds+"0011";
--end if;
--if tens>"0100" then
--tens:=tens+"0011";
--end if;
--if unit>"0100" then
--unit:=unit+"0011";
--end if;

--adim<=31;

--when others=>

--butun_vector:=butun_vector+butun_vector;--shift left
--i:=9;
--end case;
--when 9=>
----YAZDIRILACAK VERI ASAGIDA TANIMLANIR----
  
--if sw0='0' then--nem
--mesaj_lcd(3 to 15)<=((X"10"),(X"10"),(X"10"),(X"10"),(X"10"),(X"10"),(X"10"),(X"10"),(X"10"),(X"10"),(X"10"),(X"10"),(X"10"));
--mesaj_lcd(16 to 39)<=(others=>(X"00"));
--mesaj_lcd(40 TO 44)<= (("0011"&thousands(3 downto 0)),("0011"&hundreds(3 downto 0)), (X"2E"),("0011"&tens(3 downto 0)),("0011"&unit(3 downto 0))); 
--mesaj_lcd(45)<=(X"25");
--mesaj_lcd(0 to 2)<=((X"4E"),(X"45"),(X"4D"));
-------------------------N-------E-------M---
--else--sýcaklýk
--mesaj_lcd(16 to 39)<=(others=>(X"00"));
--mesaj_lcd(40 TO 44)<= (("0011"&thousands(3 downto 0)),("0011"&hundreds(3 downto 0)), (X"2E"),("0011"&tens(3 downto 0)),("0011"&unit(3 downto 0))); 
--mesaj_lcd(45)<=(X"43");
--mesaj_lcd  (0 TO 15) <=((X"4f"),(X"52"),(X"54"),(X"41"),(X"4d"),(X"10"),(X"53"),(X"49"),(X"43"),(X"41"),(X"4b"),(X"4c"),(X"49"),(X"47"),(X"49"),(X"10"));
--------------------------O-------R-------T-------A--------M---(     )----S-------I-------C-------A-------K--------L-------I-------G-------I-----(  )--
--end if;

--i:=10;
  
----------------------------------------------


--when 10 =>--LCD'ye yazdýrma.

  
  
------LCDye bastirma kismi----
  
 	 
--       sayac:=sayac+1;
		  
		 
		 
--       case	adim_lcd	is
-----------------Acilis Gecikmesi, 40 ms -----------------------------
--		when	0	=>	if (sayac=init_d)	then
--						sayac	:=	0;
--						adim_lcd	:=	1;
--					end if;
-----------------Acilis Ayarlari, 2x16 biciminde calis----------------
--		when	1	=>	lcd <= "1000010";
--					if (sayac=com_ds) then
--						sayac	:=	0;
--						adim_lcd	:=	2;
--					end if;
--		when	2	=>	lcd <= "0000010";
--					if (sayac=com_ds) then
--						adim_lcd	:=	3;
--						sayac	:=	0;
--					end if;
--		when	3	=>	lcd <= "1001110";
--					if (sayac=com_ds) then
--						adim_lcd	:=	4;
--						sayac	:=	0;
--					end if;
--		when	4	=>	lcd <= "0001110";
--					if (sayac=3*com_ds) then
--						adim_lcd	:=	5;
--						sayac	:=	0;
--					end if;
--		when	5	=>	lcd <= "1001000";
--					if (sayac=com_ds) then
--						adim_lcd	:=	6;
--						sayac	:=	0;
--					end if;
--		when	6	=>	lcd <= "0000010";
--					if (sayac=com_ds) then
--						adim_lcd	:=	7;
--						sayac	:=	0;
--					end if;
-----------------Ekrani Acma, Imlec ayarlari, Yanip/sonme---------------
--		when	7	=>	lcd <= "1000000";
--					if (sayac=com_ds/20) then
--						adim_lcd	:=	8;
--					end if;
--		when	8	=>	lcd <= "0000000";
--					if (sayac=com_ds/10) then
--						adim_lcd	:=	9;
--					end if;
--		when	9	=>	lcd <= "1001100";
--					if (sayac=3*com_ds/20) then
--						adim_lcd	:=	10;
--					end if;
--		when	10	=>	lcd <= "0001100";
--					if (sayac=com_ds) then
--						adim_lcd	:=	11;
--						sayac	:=	0;
--					end if;
-----------------Ekrani Temizle, Baslangic Adresine Git-----------------
--		when	11	=>	lcd <= "1000000";
--					if (sayac=com_dl/800) then
--						adim_lcd	:=	12;
--					end if;
--		when	12	=>	lcd <= "0000000";
--					if (sayac=com_ds/400) then
--						adim_lcd	:=	13;
--					end if;
--		when	13	=>	lcd <= "1000001";
--					if (sayac=3*com_dl/800) then
--						adim_lcd	:=	14;
--					end if;
--		when	14	=>	lcd <= "0000001";
--					if (sayac=com_dl) then
--						adim_lcd	:=	15;
--						sayac	:=	0;
--					end if;
-----------------Adresleme Ayarlari Adres Arttirici---------------------
--		when	15	=>	lcd <= "1000000";
--					if (sayac=com_ds/20) then
--						adim_lcd	:=	16;
--						end if;
--		when	16	=>	lcd <= "0000000";
--					if (sayac=com_ds/10) then
--						adim_lcd	:=	17;
--					end if;
--		when	17	=>	lcd <= "1000110";
--					if (sayac=3*com_ds/20) then
--						adim_lcd	:=	18;
--					end if;
--		when	18	=>	lcd <= "0000110";
--					if (sayac=com_ds) then
--						adim_lcd	:=	19;
--						sayac	:=	0;
--						m<=0;
--					end if;
-----------------Ekrana Karakter Basma Islemi()--------------------------
--		when	19	=>	lcd <= "110"&mesaj_lcd(m)(7 downto 4);
--					if (sayac=com_ds) then
--						adim_lcd	:=	20;
--						sayac:=0;
--					end if;
--		when	20	=>	lcd <= "010"&mesaj_lcd(m)(7 downto 4);
--					if (sayac=com_ds) then
--						adim_lcd	:=	21;
--						sayac:=0;
--					end if;
--		when	21	=>	lcd <= "110"&mesaj_lcd(m)(3 downto 0);
--					if (sayac=com_ds) then
--						adim_lcd	:=	22;
--						sayac:=0;
--					end if;
--		when	22	=>	lcd <= "010"&mesaj_lcd(m)(3 downto 0);
--					if (sayac=com_ds) then
--						adim_lcd	:=	23;
--						sayac:=0;
--					end if;	
					

--		when	23	=>	if (m<45) then
--						m<=m+1;
--						adim_lcd	:=	19;
--						sayac:=0;		
	
--						else 
--						m<=0;
--						i:=0;
--						sayac:=0;
--						adim_lcd:=11;
--						end if;
   
			
	
						
--end case; 	
--end case;
--end if;
end process;	
end Behavioral;

