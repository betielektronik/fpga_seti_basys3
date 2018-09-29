

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;



entity hesap_makinasi is
port(
clock :in std_logic;

toplama :in std_logic;
cikarma :in std_logic;
carpma	:in std_logic;
bolme		:in std_logic;

sign :out std_logic;
gelen1 :in unsigned (3 downto 0);
gelen2 :in unsigned (3 downto 0);

anot_per :inout std_logic_vector (3 downto 0);
katot_per :out std_logic_vector (6 downto 0);
dp :out std_logic;

anot :inout std_logic_vector (3 downto 0);
led :out std_logic_vector (6 downto 0)

);

end hesap_makinasi;

architecture Behavioral of hesap_makinasi is

	COMPONENT giris
	PORT(
		clock : IN std_logic;
		gelen1 : IN unsigned(3 downto 0);
		gelen2 : IN unsigned(3 downto 0);    
		anot : INOUT std_logic_vector(3 downto 0);      
		led_out : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT islem_blogu
	PORT(
		clock : IN std_logic;
		toplama : IN std_logic;
		cikarma : IN std_logic;
		carpma : IN std_logic;
		bolme : IN std_logic;
		gelen1 : IN unsigned(3 downto 0);
		gelen2 : IN unsigned(3 downto 0);          
		sign : OUT std_logic;
		sayi_sonuc_bolum_cik : OUT unsigned(3 downto 0);
		sayi_sonuc_kalan_cik : OUT unsigned(3 downto 0);
		sayi_sonuc : OUT unsigned(7 downto 0)
		);
	END COMPONENT;
	
		COMPONENT binbcd8
	PORT(
		b : IN unsigned(7 downto 0);          
		p : OUT unsigned(9 downto 0)
		);
	END COMPONENT;
	
	COMPONENT harici_gosterge
	PORT(
		toplama : IN std_logic;
		cikarma : IN std_logic;
		carpma : IN std_logic;
		bolme : IN std_logic;
		clock : IN std_logic;
		sayi_gelen : IN unsigned(15 downto 0);
		bolum : IN unsigned(3 downto 0);
		kalan : IN unsigned(3 downto 0);    
		anot : INOUT std_logic_vector(3 downto 0);      
		katot : OUT std_logic_vector(6 downto 0);
		dp : OUT std_logic
		);
	END COMPONENT;



signal sayi_sonuc	: unsigned(7 downto 0):=(others=>'0');
signal sayi_sonuc_bcd	: unsigned(9 downto 0):=(others=>'0');
signal sayi_sonuc_bcd_new	: unsigned(15 downto 0):=(others=>'0');

signal sayi_sonuc_bolum_cik	: unsigned(3 downto 0):=(others=>'0');
signal sayi_sonuc_kalan_cik	: unsigned(3 downto 0):=(others=>'0');


begin

sayi_sonuc_bcd_new<="000000"&sayi_sonuc_bcd;


	Inst_giris: giris PORT MAP(
		clock => clock,
		gelen1 => gelen1,
		gelen2 => gelen2,
		anot => anot,
		led_out => led 
	);



	Inst_islem_blogu: islem_blogu PORT MAP(
		clock => clock,
		toplama => toplama,
		cikarma => cikarma,
		carpma => carpma,
		bolme => bolme,
		sign => sign,
		gelen1 => gelen1,
		gelen2 => gelen2,
		sayi_sonuc_bolum_cik => sayi_sonuc_bolum_cik,
		sayi_sonuc_kalan_cik => sayi_sonuc_kalan_cik,
		sayi_sonuc => sayi_sonuc
	);

		Inst_binbcd8: binbcd8 PORT MAP(
		b => sayi_sonuc,
		p => sayi_sonuc_bcd
	);
	


		Inst_harici_gosterge: harici_gosterge PORT MAP(
		toplama =>toplama ,
		cikarma => cikarma,
		carpma => carpma,
		bolme => bolme,
		clock => clock,
		sayi_gelen => sayi_sonuc_bcd_new,
		anot => anot_per,
		katot => katot_per,
		dp => dp,
		bolum => sayi_sonuc_bolum_cik,
		kalan => sayi_sonuc_kalan_cik

	);

end Behavioral;

