rule dyndns_group_1 { 

	meta:
		author: 	Matthew Ulm //@mattulm
		description:List of Dynamic DNS domains as I discover them.
		
	strings: 
		$001 = "d.la"
		$002 = "sytes.net"
		$003 = "ath.ro"
		$004 = "no-ip.com"
		$005 = "no-ip.biz"
		$006 = "no-ip.org"
		$007 = "o-ip.info"
		$008 = "ddns.info"
		$009 = "ddns.net"
		$010 = "myftp.org"
		$011 = "zapto.org"
		$012 = "noip.me"
		$013 = "linkpc.net"
		$014 = "myftp.biz"
		$015 = "hopto.org"
		$016 = "chickenkiller.com"
		$017 = "ddnsking.com"
		$018 = "publicvm.com"
		$019 = "x64.me"
		$020 = "mooo.com"
		$021 = "myfreeip.me"
		$022 = "3322.org"
		$023 = "dyndns-mail.com"
		$024 = "dyndns.biz"
		$025 = "dyndns.com"
		$026 = "dyndns.info"
		$027 = "dyndns.org"
		$028 = "dyndns.tv"
		$029 = "dyndns-home.com"
		$030 = "dyndns-free.com"
		$031 = "dyndns-work.com"
		$032 = "serveblog.net"
		$033 = "8800.org"
		$034 = "gnway.net"
		$035 = "mooo.com"
		$036 = "gicp.net"
		$037 = "dlinkddns.com"
		$038 = "vicp.net"
		$039 = "blogdns.com"
		$040 = "selfip.org"
		$041 = "homeftp.org"
		
	condition: 
		any of them 
}