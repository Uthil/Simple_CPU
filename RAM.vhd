Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Entity RAM is
	port( din     : in std_logic_vector(7 downto 0);
	      addr    : in std_logic_vector(7 downto 0);
	      we, clk : in std_logic;
	      dout    : out std_logic_vector(15 downto 0));
End RAM;

Architecture mem256 of RAM is

signal data_in : std_logic_vector (15 downto 0);
type vector_array is array (0 to 255) of std_logic_vector (15 downto 0);
signal memory : 
	vector_array:= (
		0=>"0000000000000000",	-- 0x0000 : LOAD ACC, 0
		1=>"0100000000001010",	-- 0x400A : ADD ACC, 10
		2=>"1110000000101011",	-- 0xE02B : OUTPUT ACC, 43
		3=>"1010000000101001",	-- 0xA029 : INPUT ACC, 41
		4=>"0110000000000001",	-- 0x6001 : SUB ACC, 1
		5=>"1110000000101001",	-- 0xE029 : OUTPUT ACC, 41
		6=>"1010000000101011",	-- 0xA02B : INPUT ACC, 43
		7=>"1001010000000001",	-- 0x9401 : JUMP NZ, 1
		8=>"1000000000001000",	-- 0x8008 : JUMP U, 8
	   41=>"0000000000000101",	-- 0x0005 : DATA: 5
   others=>"0000000000000000"); 
   
begin
	data_in <="00000000" & din; --επέκταση των DATA εισόδου σε 16bit
	
	process(clk)
		begin
			if rising_edge(clk) then
				if (we='1') then 
					memory(conv_integer(addr)) <= data_in;
				end if;
			end if;
	End process;

dout <= memory(conv_integer(addr));

End mem256;