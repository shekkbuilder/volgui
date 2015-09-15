rule cf_pdf_cve_2007_5659 {
meta:
	maltype = "all"
	filetype = "pdf"
	yaraexchange = "No distribution without author's consent"
	author = "Michael Remen"
	source = "Yara Exchange"
	date = "2012-08"
	version = "1.0"
	cve = "CVE-2007-5659"
strings:
	$a = {255044462d}
	$b = {7961727073}
	$c = {6570616373656e75}
	$d = {6e6f6974636e7566}
	$e = {7961727241}
condition:
	all of them
}

rule cf_pdf_suspicious_obfuscation : pdf {
        meta:
                author = "Glenn Edwards (@hiddenillusion)"
                version = "0.1"
                weight = 2
                maltype = "all"
                filetype = "pdf"
                yaraexchange = "No distribution without author's consent"
        strings:
                $magic = { 25 50 44 46 }
                $reg = /\/\w#[a-zA-Z0-9]{2}#[a-zA-Z0-9]{2}/
				
        condition:
                $magic at 0 and #reg > 5
}

rule cf_java_execute_write {
        meta:
                author = "Glenn Edwards (@hiddenillusion)"
                version = "0.1"
                ref = "http://docs.oracle.com"
                maltype = "all"
                filetype = "jar"
                yaraexchange = "No distribution without author's consent"
                date = "2012-09"
        strings:
                $magic = { CA FE BA BE }
                /* Local execution */
                $exec0 = "Runtime.getRuntime"
                $exec1 = "exec"
                /* Exploit */
                $exp0 = /arrayOf(Byte|String)/
                $exp1 = "toByteArray"
                $exp2 = "HexDecode"
                $exp3 = "StringtoBytes"
                $exp6 = "InputStream"
                $exp7 = "Exception.printStackTrace"
                $fwrite0 = "FileOutputStream" /*contains a byte stream with the serialized representation of an object given to its constructor*/
                $fwrite3 = "MarshalledObject"
                $fwrite4 = "writeObject"
                $fwrite5 = "OutputStreamWriter"
                /* Loader indicators */
                $load0 = "getResourceAsStream"
                $load1 = /l(port|host)/
                $load2 = "ObjectInputStream"
                $load3 = "ArrayOfByte"
                                //$gen1 = "file://"
        condition:
                $magic at 0 and ((all of ($exec*) and 2 of ($fwrite*)) or (2 of ($exp*) and 2 of ($load*)))
}

rule GEN_XOR_256bit_This_program_cannot_decremented {
        meta:
                author = "villys777@gmail.com"
                source = "Yara Exchange"
                date = "2012-08"
                version = "2.0"
                description = "encoded with decremented xor key executable"
                string = "This program cannot be run"
                byte_encode = true


        strings:
                $a1 = {  55 68 96 8d dd 8c 89 95 9e 8a 96 9b d5 97 92 9c 9f 9f 9b ce 8f 89 cb 98 9c 86}
                $a2 = {  56 69 69 8c de 8d 8e 94 9d 8b 99 9a d6 96 95 9d 9c 9e 84 cf 8c 88 cc 99 9f 87}
                $a3 = {  57 6a 68 73 df 8e 8f 93 9c 88 98 95 d7 95 94 9a 9d 9d 85 d0 8d 8b cd 9e 9e 84}
                $a4 = {  50 6b 6b 72 20 8f 8c 92 9b 89 9b 94 d8 94 97 9b 9a 9c 86 d1 92 8a ce 9f 99 85}
                $a5 = {  51 6c 6a 71 21 70 8d 91 9a 8e 9a 97 d9 9b 96 98 9b 9b 87 d2 93 95 cf 9c 98 82}
                $a6 = {  52 6d 6d 70 22 71 72 90 99 8f 9d 96 da 9a 99 99 98 9a 80 d3 90 94 d0 9d 9b 83}
                $a7 = {  53 6e 6c 77 23 72 73 6f 98 8c 9c 91 db 99 98 96 99 99 81 d4 91 97 d1 82 9a 80}
                $a8 = {  5c 6f 6f 76 24 73 70 6e 67 8d 9f 90 dc 98 9b 97 96 98 82 d5 96 96 d2 83 85 81}
                $a9 = {  5d 60 6e 75 25 74 71 6d 66 72 9e 93 dd 9f 9a 94 97 97 83 d6 97 91 d3 80 84 9e}
                $a10 = {  5e 61 61 74 26 75 76 6c 65 73 61 92 de 9e 9d 95 94 96 8c d7 94 90 d4 81 87 9f}
                $a11 = {  5f 62 60 7b 27 76 77 6b 64 70 60 6d df 9d 9c 92 95 95 8d d8 95 93 d5 86 86 9c}
                $a12 = {  58 63 63 7a 28 77 74 6a 63 71 63 6c 20 9c 9f 93 92 94 8e d9 9a 92 d6 87 81 9d}
                $a13 = {  59 64 62 79 29 78 75 69 62 76 62 6f 21 63 9e 90 93 93 8f da 9b 9d d7 84 80 9a}
                $a14 = {  5a 65 65 78 2a 79 7a 68 61 77 65 6e 22 62 61 91 90 92 88 db 98 9c d8 85 83 9b}
                $a15 = {  5b 66 64 7f 2b 7a 7b 67 60 74 64 69 23 61 60 6e 91 91 89 dc 99 9f d9 8a 82 98}
                $a16 = {  44 67 67 7e 2c 7b 78 66 6f 75 67 68 24 60 63 6f 6e 90 8a dd 9e 9e da 8b 8d 99}
                $a17 = {  45 78 66 7d 2d 7c 79 65 6e 7a 66 6b 25 67 62 6c 6f 6f 8b de 9f 99 db 88 8c 96}
                $a18 = {  46 79 79 7c 2e 7d 7e 64 6d 7b 69 6a 26 66 65 6d 6c 6e 74 df 9c 98 dc 89 8f 97}
                $a19 = {  47 7a 78 63 2f 7e 7f 63 6c 78 68 65 27 65 64 6a 6d 6d 75 20 9d 9b dd 8e 8e 94}
                $a20 = {  40 7b 7b 62 30 7f 7c 62 6b 79 6b 64 28 64 67 6b 6a 6c 76 21 62 9a de 8f 89 95}
                $a21 = {  41 7c 7a 61 31 60 7d 61 6a 7e 6a 67 29 6b 66 68 6b 6b 77 22 63 65 df 8c 88 92}
                $a22 = {  42 7d 7d 60 32 61 62 60 69 7f 6d 66 2a 6a 69 69 68 6a 70 23 60 64 20 8d 8b 93}
                $a23 = {  43 7e 7c 67 33 62 63 7f 68 7c 6c 61 2b 69 68 66 69 69 71 24 61 67 21 72 8a 90}
                $a24 = {  4c 7f 7f 66 34 63 60 7e 77 7d 6f 60 2c 68 6b 67 66 68 72 25 66 66 22 73 75 91}
                $a25 = {  4d 70 7e 65 35 64 61 7d 76 62 6e 63 2d 6f 6a 64 67 67 73 26 67 61 23 70 74 6e}
                $a26 = {  4e 71 71 64 36 65 66 7c 75 63 71 62 2e 6e 6d 65 64 66 7c 27 64 60 24 71 77 6f}
                $a27 = {  4f 72 70 6b 37 66 67 7b 74 60 70 7d 2f 6d 6c 62 65 65 7d 28 65 63 25 76 76 6c}
                $a28 = {  48 73 73 6a 38 67 64 7a 73 61 73 7c 30 6c 6f 63 62 64 7e 29 6a 62 26 77 71 6d}
                $a29 = {  49 74 72 69 39 68 65 79 72 66 72 7f 31 73 6e 60 63 63 7f 2a 6b 6d 27 74 70 6a}
                $a30 = {  4a 75 75 68 3a 69 6a 78 71 67 75 7e 32 72 71 61 60 62 78 2b 68 6c 28 75 73 6b}
                $a31 = {  4b 76 74 6f 3b 6a 6b 77 70 64 74 79 33 71 70 7e 61 61 79 2c 69 6f 29 7a 72 68}
                $a32 = {  74 77 77 6e 3c 6b 68 76 7f 65 77 78 34 70 73 7f 7e 60 7a 2d 6e 6e 2a 7b 7d 69}
                $a33 = {  75 48 76 6d 3d 6c 69 75 7e 6a 76 7b 35 77 72 7c 7f 7f 7b 2e 6f 69 2b 78 7c 66}
                $a34 = {  76 49 49 6c 3e 6d 6e 74 7d 6b 79 7a 36 76 75 7d 7c 7e 64 2f 6c 68 2c 79 7f 67}
                $a35 = {  77 4a 48 53 3f 6e 6f 73 7c 68 78 75 37 75 74 7a 7d 7d 65 30 6d 6b 2d 7e 7e 64}
                $a36 = {  70 4b 4b 52 00 6f 6c 72 7b 69 7b 74 38 74 77 7b 7a 7c 66 31 72 6a 2e 7f 79 65}
                $a37 = {  71 4c 4a 51 01 50 6d 71 7a 6e 7a 77 39 7b 76 78 7b 7b 67 32 73 75 2f 7c 78 62}
                $a38 = {  72 4d 4d 50 02 51 52 70 79 6f 7d 76 3a 7a 79 79 78 7a 60 33 70 74 30 7d 7b 63}
                $a39 = {  73 4e 4c 57 03 52 53 4f 78 6c 7c 71 3b 79 78 76 79 79 61 34 71 77 31 62 7a 60}
                $a40 = {  7c 4f 4f 56 04 53 50 4e 47 6d 7f 70 3c 78 7b 77 76 78 62 35 76 76 32 63 65 61}
                $a41 = {  7d 40 4e 55 05 54 51 4d 46 52 7e 73 3d 7f 7a 74 77 77 63 36 77 71 33 60 64 7e}
		$a42 = {  7e 41 41 54 06 55 56 4c 45 53 41 72 3e 7e 7d 75 74 76 6c 37 74 70 34 61 67 7f}
                $a43 = {  7f 42 40 5b 07 56 57 4b 44 50 40 4d 3f 7d 7c 72 75 75 6d 38 75 73 35 66 66 7c}
                $a44 = {  78 43 43 5a 08 57 54 4a 43 51 43 4c 00 7c 7f 73 72 74 6e 39 7a 72 36 67 61 7d}
                $a45 = {  79 44 42 59 09 58 55 49 42 56 42 4f 01 43 7e 70 73 73 6f 3a 7b 7d 37 64 60 7a}
                $a46 = {  7a 45 45 58 0a 59 5a 48 41 57 45 4e 02 42 41 71 70 72 68 3b 78 7c 38 65 63 7b}
                $a47 = {  7b 46 44 5f 0b 5a 5b 47 40 54 44 49 03 41 40 4e 71 71 69 3c 79 7f 39 6a 62 78}
                $a48 = {  64 47 47 5e 0c 5b 58 46 4f 55 47 48 04 40 43 4f 4e 70 6a 3d 7e 7e 3a 6b 6d 79}
                $a49 = {  65 58 46 5d 0d 5c 59 45 4e 5a 46 4b 05 47 42 4c 4f 4f 6b 3e 7f 79 3b 68 6c 76}
                $a50 = {  66 59 59 5c 0e 5d 5e 44 4d 5b 49 4a 06 46 45 4d 4c 4e 54 3f 7c 78 3c 69 6f 77}
                $a51 = {  67 5a 58 43 0f 5e 5f 43 4c 58 48 45 07 45 44 4a 4d 4d 55 00 7d 7b 3d 6e 6e 74}
                $a52 = {  60 5b 5b 42 10 5f 5c 42 4b 59 4b 44 08 44 47 4b 4a 4c 56 01 42 7a 3e 6f 69 75}
                $a53 = {  61 5c 5a 41 11 40 5d 41 4a 5e 4a 47 09 4b 46 48 4b 4b 57 02 43 45 3f 6c 68 72}
                $a54 = {  62 5d 5d 40 12 41 42 40 49 5f 4d 46 0a 4a 49 49 48 4a 50 03 40 44 00 6d 6b 73}
                $a55 = {  63 5e 5c 47 13 42 43 5f 48 5c 4c 41 0b 49 48 46 49 49 51 04 41 47 01 52 6a 70}
                $a56 = {  6c 5f 5f 46 14 43 40 5e 57 5d 4f 40 0c 48 4b 47 46 48 52 05 46 46 02 53 55 71}
                $a57 = {  6d 50 5e 45 15 44 41 5d 56 42 4e 43 0d 4f 4a 44 47 47 53 06 47 41 03 50 54 4e}
                $a58 = {  6e 51 51 44 16 45 46 5c 55 43 51 42 0e 4e 4d 45 44 46 5c 07 44 40 04 51 57 4f}
                $a59 = {  6f 52 50 4b 17 46 47 5b 54 40 50 5d 0f 4d 4c 42 45 45 5d 08 45 43 05 56 56 4c}
                $a60 = {  68 53 53 4a 18 47 44 5a 53 41 53 5c 10 4c 4f 43 42 44 5e 09 4a 42 06 57 51 4d}
                $a61 = {  69 54 52 49 19 48 45 59 52 46 52 5f 11 53 4e 40 43 43 5f 0a 4b 4d 07 54 50 4a}
                $a62 = {  6a 55 55 48 1a 49 4a 58 51 47 55 5e 12 52 51 41 40 42 58 0b 48 4c 08 55 53 4b}
                $a63 = {  6b 56 54 4f 1b 4a 4b 57 50 44 54 59 13 51 50 5e 41 41 59 0c 49 4f 09 5a 52 48}
                $a64 = {  14 57 57 4e 1c 4b 48 56 5f 45 57 58 14 50 53 5f 5e 40 5a 0d 4e 4e 0a 5b 5d 49}
                $a65 = {  15 28 56 4d 1d 4c 49 55 5e 4a 56 5b 15 57 52 5c 5f 5f 5b 0e 4f 49 0b 58 5c 46}
                $a66 = {  16 29 29 4c 1e 4d 4e 54 5d 4b 59 5a 16 56 55 5d 5c 5e 44 0f 4c 48 0c 59 5f 47}
                $a67 = {  17 2a 28 33 1f 4e 4f 53 5c 48 58 55 17 55 54 5a 5d 5d 45 10 4d 4b 0d 5e 5e 44}
                $a68 = {  10 2b 2b 32 60 4f 4c 52 5b 49 5b 54 18 54 57 5b 5a 5c 46 11 52 4a 0e 5f 59 45}
                $a69 = {  11 2c 2a 31 61 30 4d 51 5a 4e 5a 57 19 5b 56 58 5b 5b 47 12 53 55 0f 5c 58 42}
                $a70 = {  12 2d 2d 30 62 31 32 50 59 4f 5d 56 1a 5a 59 59 58 5a 40 13 50 54 10 5d 5b 43}
                $a71 = {  13 2e 2c 37 63 32 33 2f 58 4c 5c 51 1b 59 58 56 59 59 41 14 51 57 11 42 5a 40}
                $a72 = {  1c 2f 2f 36 64 33 30 2e 27 4d 5f 50 1c 58 5b 57 56 58 42 15 56 56 12 43 45 41}
                $a73 = {  1d 20 2e 35 65 34 31 2d 26 32 5e 53 1d 5f 5a 54 57 57 43 16 57 51 13 40 44 5e}
                $a74 = {  1e 21 21 34 66 35 36 2c 25 33 21 52 1e 5e 5d 55 54 56 4c 17 54 50 14 41 47 5f}
                $a75 = {  1f 22 20 3b 67 36 37 2b 24 30 20 2d 1f 5d 5c 52 55 55 4d 18 55 53 15 46 46 5c}
                $a76 = {  18 23 23 3a 68 37 34 2a 23 31 23 2c 60 5c 5f 53 52 54 4e 19 5a 52 16 47 41 5d}
                $a77 = {  19 24 22 39 69 38 35 29 22 36 22 2f 61 23 5e 50 53 53 4f 1a 5b 5d 17 44 40 5a}
                $a78 = {  1a 25 25 38 6a 39 3a 28 21 37 25 2e 62 22 21 51 50 52 48 1b 58 5c 18 45 43 5b}
                $a79 = {  1b 26 24 3f 6b 3a 3b 27 20 34 24 29 63 21 20 2e 51 51 49 1c 59 5f 19 4a 42 58}
                $a80 = {  04 27 27 3e 6c 3b 38 26 2f 35 27 28 64 20 23 2f 2e 50 4a 1d 5e 5e 1a 4b 4d 59}
                $a81 = {  05 38 26 3d 6d 3c 39 25 2e 3a 26 2b 65 27 22 2c 2f 2f 4b 1e 5f 59 1b 48 4c 56}
                $a82 = {  06 39 39 3c 6e 3d 3e 24 2d 3b 29 2a 66 26 25 2d 2c 2e 34 1f 5c 58 1c 49 4f 57}
                $a83 = {  07 3a 38 23 6f 3e 3f 23 2c 38 28 25 67 25 24 2a 2d 2d 35 60 5d 5b 1d 4e 4e 54}
                $a84 = {  00 3b 3b 22 70 3f 3c 22 2b 39 2b 24 68 24 27 2b 2a 2c 36 61 22 5a 1e 4f 49 55}
                $a85 = {  01 3c 3a 21 71 20 3d 21 2a 3e 2a 27 69 2b 26 28 2b 2b 37 62 23 25 1f 4c 48 52}
                $a86 = {  02 3d 3d 20 72 21 22 20 29 3f 2d 26 6a 2a 29 29 28 2a 30 63 20 24 60 4d 4b 53}
                $a87 = {  03 3e 3c 27 73 22 23 3f 28 3c 2c 21 6b 29 28 26 29 29 31 64 21 27 61 32 4a 50}
                $a88 = {  0c 3f 3f 26 74 23 20 3e 37 3d 2f 20 6c 28 2b 27 26 28 32 65 26 26 62 33 35 51}
                $a89 = {  0d 30 3e 25 75 24 21 3d 36 22 2e 23 6d 2f 2a 24 27 27 33 66 27 21 63 30 34 2e}
                $a90 = {  0e 31 31 24 76 25 26 3c 35 23 31 22 6e 2e 2d 25 24 26 3c 67 24 20 64 31 37 2f}
                $a91 = {  0f 32 30 2b 77 26 27 3b 34 20 30 3d 6f 2d 2c 22 25 25 3d 68 25 23 65 36 36 2c}
                $a92 = {  08 33 33 2a 78 27 24 3a 33 21 33 3c 70 2c 2f 23 22 24 3e 69 2a 22 66 37 31 2d}
                $a93 = {  09 34 32 29 79 28 25 39 32 26 32 3f 71 33 2e 20 23 23 3f 6a 2b 2d 67 34 30 2a}
                $a94 = {  0a 35 35 28 7a 29 2a 38 31 27 35 3e 72 32 31 21 20 22 38 6b 28 2c 68 35 33 2b}
		$a95 = {  0b 36 34 2f 7b 2a 2b 37 30 24 34 39 73 31 30 3e 21 21 39 6c 29 2f 69 3a 32 28}
                $a96 = {  34 37 37 2e 7c 2b 28 36 3f 25 37 38 74 30 33 3f 3e 20 3a 6d 2e 2e 6a 3b 3d 29}
                $a97 = {  35 08 36 2d 7d 2c 29 35 3e 2a 36 3b 75 37 32 3c 3f 3f 3b 6e 2f 29 6b 38 3c 26}
                $a98 = {  36 09 09 2c 7e 2d 2e 34 3d 2b 39 3a 76 36 35 3d 3c 3e 24 6f 2c 28 6c 39 3f 27}
                $a99 = {  37 0a 08 13 7f 2e 2f 33 3c 28 38 35 77 35 34 3a 3d 3d 25 70 2d 2b 6d 3e 3e 24}
                $a100 = {  30 0b 0b 12 40 2f 2c 32 3b 29 3b 34 78 34 37 3b 3a 3c 26 71 32 2a 6e 3f 39 25}
                $a101 = {  31 0c 0a 11 41 10 2d 31 3a 2e 3a 37 79 3b 36 38 3b 3b 27 72 33 35 6f 3c 38 22}
                $a102 = {  32 0d 0d 10 42 11 12 30 39 2f 3d 36 7a 3a 39 39 38 3a 20 73 30 34 70 3d 3b 23}
                $a103 = {  33 0e 0c 17 43 12 13 0f 38 2c 3c 31 7b 39 38 36 39 39 21 74 31 37 71 22 3a 20}
                $a104 = {  3c 0f 0f 16 44 13 10 0e 07 2d 3f 30 7c 38 3b 37 36 38 22 75 36 36 72 23 25 21}
                $a105 = {  3d 00 0e 15 45 14 11 0d 06 12 3e 33 7d 3f 3a 34 37 37 23 76 37 31 73 20 24 3e}
                $a106 = {  3e 01 01 14 46 15 16 0c 05 13 01 32 7e 3e 3d 35 34 36 2c 77 34 30 74 21 27 3f}
                $a107 = {  3f 02 00 1b 47 16 17 0b 04 10 00 0d 7f 3d 3c 32 35 35 2d 78 35 33 75 26 26 3c}
                $a108 = {  38 03 03 1a 48 17 14 0a 03 11 03 0c 40 3c 3f 33 32 34 2e 79 3a 32 76 27 21 3d}
                $a109 = {  39 04 02 19 49 18 15 09 02 16 02 0f 41 03 3e 30 33 33 2f 7a 3b 3d 77 24 20 3a}
                $a110 = {  3a 05 05 18 4a 19 1a 08 01 17 05 0e 42 02 01 31 30 32 28 7b 38 3c 78 25 23 3b}
                $a111 = {  3b 06 04 1f 4b 1a 1b 07 00 14 04 09 43 01 00 0e 31 31 29 7c 39 3f 79 2a 22 38}
                $a112 = {  24 07 07 1e 4c 1b 18 06 0f 15 07 08 44 00 03 0f 0e 30 2a 7d 3e 3e 7a 2b 2d 39}
                $a113 = {  25 18 06 1d 4d 1c 19 05 0e 1a 06 0b 45 07 02 0c 0f 0f 2b 7e 3f 39 7b 28 2c 36}
                $a114 = {  26 19 19 1c 4e 1d 1e 04 0d 1b 09 0a 46 06 05 0d 0c 0e 14 7f 3c 38 7c 29 2f 37}
                $a115 = {  27 1a 18 03 4f 1e 1f 03 0c 18 08 05 47 05 04 0a 0d 0d 15 40 3d 3b 7d 2e 2e 34}
                $a116 = {  20 1b 1b 02 50 1f 1c 02 0b 19 0b 04 48 04 07 0b 0a 0c 16 41 02 3a 7e 2f 29 35}
                $a117 = {  21 1c 1a 01 51 00 1d 01 0a 1e 0a 07 49 0b 06 08 0b 0b 17 42 03 05 7f 2c 28 32}
                $a118 = {  22 1d 1d 00 52 01 02 00 09 1f 0d 06 4a 0a 09 09 08 0a 10 43 00 04 40 2d 2b 33}
                $a119 = {  23 1e 1c 07 53 02 03 1f 08 1c 0c 01 4b 09 08 06 09 09 11 44 01 07 41 12 2a 30}
                $a120 = {  2c 1f 1f 06 54 03 00 1e 17 1d 0f 00 4c 08 0b 07 06 08 12 45 06 06 42 13 15 31}
                $a121 = {  2d 10 1e 05 55 04 01 1d 16 02 0e 03 4d 0f 0a 04 07 07 13 46 07 01 43 10 14 0e}
                $a122 = {  2e 11 11 04 56 05 06 1c 15 03 11 02 4e 0e 0d 05 04 06 1c 47 04 00 44 11 17 0f}
                $a123 = {  2f 12 10 0b 57 06 07 1b 14 00 10 1d 4f 0d 0c 02 05 05 1d 48 05 03 45 16 16 0c}
                $a124 = {  28 13 13 0a 58 07 04 1a 13 01 13 1c 50 0c 0f 03 02 04 1e 49 0a 02 46 17 11 0d}
                $a125 = {  29 14 12 09 59 08 05 19 12 06 12 1f 51 13 0e 00 03 03 1f 4a 0b 0d 47 14 10 0a}
                $a126 = {  2a 15 15 08 5a 09 0a 18 11 07 15 1e 52 12 11 01 00 02 18 4b 08 0c 48 15 13 0b}
                $a127 = {  2b 16 14 0f 5b 0a 0b 17 10 04 14 19 53 11 10 1e 01 01 19 4c 09 0f 49 1a 12 08}
                $a128 = {  d4 17 17 0e 5c 0b 08 16 1f 05 17 18 54 10 13 1f 1e 00 1a 4d 0e 0e 4a 1b 1d 09}
                $a129 = {  d5 e8 16 0d 5d 0c 09 15 1e 0a 16 1b 55 17 12 1c 1f 1f 1b 4e 0f 09 4b 18 1c 06}
                $a130 = {  d6 e9 e9 0c 5e 0d 0e 14 1d 0b 19 1a 56 16 15 1d 1c 1e 04 4f 0c 08 4c 19 1f 07}
                $a131 = {  d7 ea e8 f3 5f 0e 0f 13 1c 08 18 15 57 15 14 1a 1d 1d 05 50 0d 0b 4d 1e 1e 04}
                $a132 = {  d0 eb eb f2 a0 0f 0c 12 1b 09 1b 14 58 14 17 1b 1a 1c 06 51 12 0a 4e 1f 19 05}
                $a133 = {  d1 ec ea f1 a1 f0 0d 11 1a 0e 1a 17 59 1b 16 18 1b 1b 07 52 13 15 4f 1c 18 02}
                $a134 = {  d2 ed ed f0 a2 f1 f2 10 19 0f 1d 16 5a 1a 19 19 18 1a 00 53 10 14 50 1d 1b 03}
                $a135 = {  d3 ee ec f7 a3 f2 f3 ef 18 0c 1c 11 5b 19 18 16 19 19 01 54 11 17 51 02 1a 00}
                $a136 = {  dc ef ef f6 a4 f3 f0 ee e7 0d 1f 10 5c 18 1b 17 16 18 02 55 16 16 52 03 05 01}
                $a137 = {  dd e0 ee f5 a5 f4 f1 ed e6 f2 1e 13 5d 1f 1a 14 17 17 03 56 17 11 53 00 04 1e}
                $a138 = {  de e1 e1 f4 a6 f5 f6 ec e5 f3 e1 12 5e 1e 1d 15 14 16 0c 57 14 10 54 01 07 1f}
                $a139 = {  df e2 e0 fb a7 f6 f7 eb e4 f0 e0 ed 5f 1d 1c 12 15 15 0d 58 15 13 55 06 06 1c}
                $a140 = {  d8 e3 e3 fa a8 f7 f4 ea e3 f1 e3 ec a0 1c 1f 13 12 14 0e 59 1a 12 56 07 01 1d}
                $a141 = {  d9 e4 e2 f9 a9 f8 f5 e9 e2 f6 e2 ef a1 e3 1e 10 13 13 0f 5a 1b 1d 57 04 00 1a}
                $a142 = {  da e5 e5 f8 aa f9 fa e8 e1 f7 e5 ee a2 e2 e1 11 10 12 08 5b 18 1c 58 05 03 1b}
                $a143 = {  db e6 e4 ff ab fa fb e7 e0 f4 e4 e9 a3 e1 e0 ee 11 11 09 5c 19 1f 59 0a 02 18}
                $a144 = {  c4 e7 e7 fe ac fb f8 e6 ef f5 e7 e8 a4 e0 e3 ef ee 10 0a 5d 1e 1e 5a 0b 0d 19}
                $a145 = {  c5 f8 e6 fd ad fc f9 e5 ee fa e6 eb a5 e7 e2 ec ef ef 0b 5e 1f 19 5b 08 0c 16}
                $a146 = {  c6 f9 f9 fc ae fd fe e4 ed fb e9 ea a6 e6 e5 ed ec ee f4 5f 1c 18 5c 09 0f 17}
                $a147 = {  c7 fa f8 e3 af fe ff e3 ec f8 e8 e5 a7 e5 e4 ea ed ed f5 a0 1d 1b 5d 0e 0e 14}
		$a148 = {  c0 fb fb e2 b0 ff fc e2 eb f9 eb e4 a8 e4 e7 eb ea ec f6 a1 e2 1a 5e 0f 09 15}
                $a149 = {  c1 fc fa e1 b1 e0 fd e1 ea fe ea e7 a9 eb e6 e8 eb eb f7 a2 e3 e5 5f 0c 08 12}
                $a150 = {  c2 fd fd e0 b2 e1 e2 e0 e9 ff ed e6 aa ea e9 e9 e8 ea f0 a3 e0 e4 a0 0d 0b 13}
                $a151 = {  c3 fe fc e7 b3 e2 e3 ff e8 fc ec e1 ab e9 e8 e6 e9 e9 f1 a4 e1 e7 a1 f2 0a 10}
                $a152 = {  cc ff ff e6 b4 e3 e0 fe f7 fd ef e0 ac e8 eb e7 e6 e8 f2 a5 e6 e6 a2 f3 f5 11}
                $a153 = {  cd f0 fe e5 b5 e4 e1 fd f6 e2 ee e3 ad ef ea e4 e7 e7 f3 a6 e7 e1 a3 f0 f4 ee}
                $a154 = {  ce f1 f1 e4 b6 e5 e6 fc f5 e3 f1 e2 ae ee ed e5 e4 e6 fc a7 e4 e0 a4 f1 f7 ef}
                $a155 = {  cf f2 f0 eb b7 e6 e7 fb f4 e0 f0 fd af ed ec e2 e5 e5 fd a8 e5 e3 a5 f6 f6 ec}
                $a156 = {  c8 f3 f3 ea b8 e7 e4 fa f3 e1 f3 fc b0 ec ef e3 e2 e4 fe a9 ea e2 a6 f7 f1 ed}
                $a157 = {  c9 f4 f2 e9 b9 e8 e5 f9 f2 e6 f2 ff b1 f3 ee e0 e3 e3 ff aa eb ed a7 f4 f0 ea}
                $a158 = {  ca f5 f5 e8 ba e9 ea f8 f1 e7 f5 fe b2 f2 f1 e1 e0 e2 f8 ab e8 ec a8 f5 f3 eb}
                $a159 = {  cb f6 f4 ef bb ea eb f7 f0 e4 f4 f9 b3 f1 f0 fe e1 e1 f9 ac e9 ef a9 fa f2 e8}
                $a160 = {  f4 f7 f7 ee bc eb e8 f6 ff e5 f7 f8 b4 f0 f3 ff fe e0 fa ad ee ee aa fb fd e9}
                $a161 = {  f5 c8 f6 ed bd ec e9 f5 fe ea f6 fb b5 f7 f2 fc ff ff fb ae ef e9 ab f8 fc e6}
                $a162 = {  f6 c9 c9 ec be ed ee f4 fd eb f9 fa b6 f6 f5 fd fc fe e4 af ec e8 ac f9 ff e7}
                $a163 = {  f7 ca c8 d3 bf ee ef f3 fc e8 f8 f5 b7 f5 f4 fa fd fd e5 b0 ed eb ad fe fe e4}
                $a164 = {  f0 cb cb d2 80 ef ec f2 fb e9 fb f4 b8 f4 f7 fb fa fc e6 b1 f2 ea ae ff f9 e5}
                $a165 = {  f1 cc ca d1 81 d0 ed f1 fa ee fa f7 b9 fb f6 f8 fb fb e7 b2 f3 f5 af fc f8 e2}
                $a166 = {  f2 cd cd d0 82 d1 d2 f0 f9 ef fd f6 ba fa f9 f9 f8 fa e0 b3 f0 f4 b0 fd fb e3}
                $a167 = {  f3 ce cc d7 83 d2 d3 cf f8 ec fc f1 bb f9 f8 f6 f9 f9 e1 b4 f1 f7 b1 e2 fa e0}
                $a168 = {  fc cf cf d6 84 d3 d0 ce c7 ed ff f0 bc f8 fb f7 f6 f8 e2 b5 f6 f6 b2 e3 e5 e1}
                $a169 = {  fd c0 ce d5 85 d4 d1 cd c6 d2 fe f3 bd ff fa f4 f7 f7 e3 b6 f7 f1 b3 e0 e4 fe}
                $a170 = {  fe c1 c1 d4 86 d5 d6 cc c5 d3 c1 f2 be fe fd f5 f4 f6 ec b7 f4 f0 b4 e1 e7 ff}
                $a171 = {  ff c2 c0 db 87 d6 d7 cb c4 d0 c0 cd bf fd fc f2 f5 f5 ed b8 f5 f3 b5 e6 e6 fc}
                $a172 = {  f8 c3 c3 da 88 d7 d4 ca c3 d1 c3 cc 80 fc ff f3 f2 f4 ee b9 fa f2 b6 e7 e1 fd}
                $a173 = {  f9 c4 c2 d9 89 d8 d5 c9 c2 d6 c2 cf 81 c3 fe f0 f3 f3 ef ba fb fd b7 e4 e0 fa}
                $a174 = {  fa c5 c5 d8 8a d9 da c8 c1 d7 c5 ce 82 c2 c1 f1 f0 f2 e8 bb f8 fc b8 e5 e3 fb}
                $a175 = {  fb c6 c4 df 8b da db c7 c0 d4 c4 c9 83 c1 c0 ce f1 f1 e9 bc f9 ff b9 ea e2 f8}
                $a176 = {  e4 c7 c7 de 8c db d8 c6 cf d5 c7 c8 84 c0 c3 cf ce f0 ea bd fe fe ba eb ed f9}
                $a177 = {  e5 d8 c6 dd 8d dc d9 c5 ce da c6 cb 85 c7 c2 cc cf cf eb be ff f9 bb e8 ec f6}
                $a178 = {  e6 d9 d9 dc 8e dd de c4 cd db c9 ca 86 c6 c5 cd cc ce d4 bf fc f8 bc e9 ef f7}
                $a179 = {  e7 da d8 c3 8f de df c3 cc d8 c8 c5 87 c5 c4 ca cd cd d5 80 fd fb bd ee ee f4}
                $a180 = {  e0 db db c2 90 df dc c2 cb d9 cb c4 88 c4 c7 cb ca cc d6 81 c2 fa be ef e9 f5}
                $a181 = {  e1 dc da c1 91 c0 dd c1 ca de ca c7 89 cb c6 c8 cb cb d7 82 c3 c5 bf ec e8 f2}
                $a182 = {  e2 dd dd c0 92 c1 c2 c0 c9 df cd c6 8a ca c9 c9 c8 ca d0 83 c0 c4 80 ed eb f3}
                $a183 = {  e3 de dc c7 93 c2 c3 df c8 dc cc c1 8b c9 c8 c6 c9 c9 d1 84 c1 c7 81 d2 ea f0}
                $a184 = {  ec df df c6 94 c3 c0 de d7 dd cf c0 8c c8 cb c7 c6 c8 d2 85 c6 c6 82 d3 d5 f1}
                $a185 = {  ed d0 de c5 95 c4 c1 dd d6 c2 ce c3 8d cf ca c4 c7 c7 d3 86 c7 c1 83 d0 d4 ce}
                $a186 = {  ee d1 d1 c4 96 c5 c6 dc d5 c3 d1 c2 8e ce cd c5 c4 c6 dc 87 c4 c0 84 d1 d7 cf}
                $a187 = {  ef d2 d0 cb 97 c6 c7 db d4 c0 d0 dd 8f cd cc c2 c5 c5 dd 88 c5 c3 85 d6 d6 cc}
                $a188 = {  e8 d3 d3 ca 98 c7 c4 da d3 c1 d3 dc 90 cc cf c3 c2 c4 de 89 ca c2 86 d7 d1 cd}
                $a189 = {  e9 d4 d2 c9 99 c8 c5 d9 d2 c6 d2 df 91 d3 ce c0 c3 c3 df 8a cb cd 87 d4 d0 ca}
                $a190 = {  ea d5 d5 c8 9a c9 ca d8 d1 c7 d5 de 92 d2 d1 c1 c0 c2 d8 8b c8 cc 88 d5 d3 cb}
                $a191 = {  eb d6 d4 cf 9b ca cb d7 d0 c4 d4 d9 93 d1 d0 de c1 c1 d9 8c c9 cf 89 da d2 c8}
                $a192 = {  94 d7 d7 ce 9c cb c8 d6 df c5 d7 d8 94 d0 d3 df de c0 da 8d ce ce 8a db dd c9}
                $a193 = {  95 a8 d6 cd 9d cc c9 d5 de ca d6 db 95 d7 d2 dc df df db 8e cf c9 8b d8 dc c6}
                $a194 = {  96 a9 a9 cc 9e cd ce d4 dd cb d9 da 96 d6 d5 dd dc de c4 8f cc c8 8c d9 df c7}
                $a195 = {  97 aa a8 b3 9f ce cf d3 dc c8 d8 d5 97 d5 d4 da dd dd c5 90 cd cb 8d de de c4}
                $a196 = {  90 ab ab b2 e0 cf cc d2 db c9 db d4 98 d4 d7 db da dc c6 91 d2 ca 8e df d9 c5}
                $a197 = {  91 ac aa b1 e1 b0 cd d1 da ce da d7 99 db d6 d8 db db c7 92 d3 d5 8f dc d8 c2}
                $a198 = {  92 ad ad b0 e2 b1 b2 d0 d9 cf dd d6 9a da d9 d9 d8 da c0 93 d0 d4 90 dd db c3}
                $a199 = {  93 ae ac b7 e3 b2 b3 af d8 cc dc d1 9b d9 d8 d6 d9 d9 c1 94 d1 d7 91 c2 da c0}
		$a200 = {  9c af af b6 e4 b3 b0 ae a7 cd df d0 9c d8 db d7 d6 d8 c2 95 d6 d6 92 c3 c5 c1}
                $a201 = {  9d a0 ae b5 e5 b4 b1 ad a6 b2 de d3 9d df da d4 d7 d7 c3 96 d7 d1 93 c0 c4 de}
                $a202 = {  9e a1 a1 b4 e6 b5 b6 ac a5 b3 a1 d2 9e de dd d5 d4 d6 cc 97 d4 d0 94 c1 c7 df}
                $a203 = {  9f a2 a0 bb e7 b6 b7 ab a4 b0 a0 ad 9f dd dc d2 d5 d5 cd 98 d5 d3 95 c6 c6 dc}
                $a204 = {  98 a3 a3 ba e8 b7 b4 aa a3 b1 a3 ac e0 dc df d3 d2 d4 ce 99 da d2 96 c7 c1 dd}
                $a205 = {  99 a4 a2 b9 e9 b8 b5 a9 a2 b6 a2 af e1 a3 de d0 d3 d3 cf 9a db dd 97 c4 c0 da}
                $a206 = {  9a a5 a5 b8 ea b9 ba a8 a1 b7 a5 ae e2 a2 a1 d1 d0 d2 c8 9b d8 dc 98 c5 c3 db}
                $a207 = {  9b a6 a4 bf eb ba bb a7 a0 b4 a4 a9 e3 a1 a0 ae d1 d1 c9 9c d9 df 99 ca c2 d8}
                $a208 = {  84 a7 a7 be ec bb b8 a6 af b5 a7 a8 e4 a0 a3 af ae d0 ca 9d de de 9a cb cd d9}
                $a209 = {  85 b8 a6 bd ed bc b9 a5 ae ba a6 ab e5 a7 a2 ac af af cb 9e df d9 9b c8 cc d6}
                $a210 = {  86 b9 b9 bc ee bd be a4 ad bb a9 aa e6 a6 a5 ad ac ae b4 9f dc d8 9c c9 cf d7}
                $a211 = {  87 ba b8 a3 ef be bf a3 ac b8 a8 a5 e7 a5 a4 aa ad ad b5 e0 dd db 9d ce ce d4}
                $a212 = {  80 bb bb a2 f0 bf bc a2 ab b9 ab a4 e8 a4 a7 ab aa ac b6 e1 a2 da 9e cf c9 d5}
                $a213 = {  81 bc ba a1 f1 a0 bd a1 aa be aa a7 e9 ab a6 a8 ab ab b7 e2 a3 a5 9f cc c8 d2}
                $a214 = {  82 bd bd a0 f2 a1 a2 a0 a9 bf ad a6 ea aa a9 a9 a8 aa b0 e3 a0 a4 e0 cd cb d3}
                $a215 = {  83 be bc a7 f3 a2 a3 bf a8 bc ac a1 eb a9 a8 a6 a9 a9 b1 e4 a1 a7 e1 b2 ca d0}
                $a216 = {  8c bf bf a6 f4 a3 a0 be b7 bd af a0 ec a8 ab a7 a6 a8 b2 e5 a6 a6 e2 b3 b5 d1}
                $a217 = {  8d b0 be a5 f5 a4 a1 bd b6 a2 ae a3 ed af aa a4 a7 a7 b3 e6 a7 a1 e3 b0 b4 ae}
                $a218 = {  8e b1 b1 a4 f6 a5 a6 bc b5 a3 b1 a2 ee ae ad a5 a4 a6 bc e7 a4 a0 e4 b1 b7 af}
                $a219 = {  8f b2 b0 ab f7 a6 a7 bb b4 a0 b0 bd ef ad ac a2 a5 a5 bd e8 a5 a3 e5 b6 b6 ac}
                $a220 = {  88 b3 b3 aa f8 a7 a4 ba b3 a1 b3 bc f0 ac af a3 a2 a4 be e9 aa a2 e6 b7 b1 ad}
                $a221 = {  89 b4 b2 a9 f9 a8 a5 b9 b2 a6 b2 bf f1 b3 ae a0 a3 a3 bf ea ab ad e7 b4 b0 aa}
                $a222 = {  8a b5 b5 a8 fa a9 aa b8 b1 a7 b5 be f2 b2 b1 a1 a0 a2 b8 eb a8 ac e8 b5 b3 ab}
                $a223 = {  8b b6 b4 af fb aa ab b7 b0 a4 b4 b9 f3 b1 b0 be a1 a1 b9 ec a9 af e9 ba b2 a8}
                $a224 = {  b4 b7 b7 ae fc ab a8 b6 bf a5 b7 b8 f4 b0 b3 bf be a0 ba ed ae ae ea bb bd a9}
                $a225 = {  b5 88 b6 ad fd ac a9 b5 be aa b6 bb f5 b7 b2 bc bf bf bb ee af a9 eb b8 bc a6}
                $a226 = {  b6 89 89 ac fe ad ae b4 bd ab b9 ba f6 b6 b5 bd bc be a4 ef ac a8 ec b9 bf a7}
                $a227 = {  b7 8a 88 93 ff ae af b3 bc a8 b8 b5 f7 b5 b4 ba bd bd a5 f0 ad ab ed be be a4}
                $a228 = {  b0 8b 8b 92 c0 af ac b2 bb a9 bb b4 f8 b4 b7 bb ba bc a6 f1 b2 aa ee bf b9 a5}
                $a229 = {  b1 8c 8a 91 c1 90 ad b1 ba ae ba b7 f9 bb b6 b8 bb bb a7 f2 b3 b5 ef bc b8 a2}
                $a230 = {  b2 8d 8d 90 c2 91 92 b0 b9 af bd b6 fa ba b9 b9 b8 ba a0 f3 b0 b4 f0 bd bb a3}
                $a231 = {  b3 8e 8c 97 c3 92 93 8f b8 ac bc b1 fb b9 b8 b6 b9 b9 a1 f4 b1 b7 f1 a2 ba a0}
                $a232 = {  bc 8f 8f 96 c4 93 90 8e 87 ad bf b0 fc b8 bb b7 b6 b8 a2 f5 b6 b6 f2 a3 a5 a1}
                $a233 = {  bd 80 8e 95 c5 94 91 8d 86 92 be b3 fd bf ba b4 b7 b7 a3 f6 b7 b1 f3 a0 a4 be}
                $a234 = {  be 81 81 94 c6 95 96 8c 85 93 81 b2 fe be bd b5 b4 b6 ac f7 b4 b0 f4 a1 a7 bf}
                $a235 = {  bf 82 80 9b c7 96 97 8b 84 90 80 8d ff bd bc b2 b5 b5 ad f8 b5 b3 f5 a6 a6 bc}
                $a236 = {  b8 83 83 9a c8 97 94 8a 83 91 83 8c c0 bc bf b3 b2 b4 ae f9 ba b2 f6 a7 a1 bd}
                $a237 = {  b9 84 82 99 c9 98 95 89 82 96 82 8f c1 83 be b0 b3 b3 af fa bb bd f7 a4 a0 ba}
                $a238 = {  ba 85 85 98 ca 99 9a 88 81 97 85 8e c2 82 81 b1 b0 b2 a8 fb b8 bc f8 a5 a3 bb}
                $a239 = {  bb 86 84 9f cb 9a 9b 87 80 94 84 89 c3 81 80 8e b1 b1 a9 fc b9 bf f9 aa a2 b8}
                $a240 = {  a4 87 87 9e cc 9b 98 86 8f 95 87 88 c4 80 83 8f 8e b0 aa fd be be fa ab ad b9}
                $a241 = {  a5 98 86 9d cd 9c 99 85 8e 9a 86 8b c5 87 82 8c 8f 8f ab fe bf b9 fb a8 ac b6}
                $a242 = {  a6 99 99 9c ce 9d 9e 84 8d 9b 89 8a c6 86 85 8d 8c 8e 94 ff bc b8 fc a9 af b7}
                $a243 = {  a7 9a 98 83 cf 9e 9f 83 8c 98 88 85 c7 85 84 8a 8d 8d 95 c0 bd bb fd ae ae b4}
                $a244 = {  a0 9b 9b 82 d0 9f 9c 82 8b 99 8b 84 c8 84 87 8b 8a 8c 96 c1 82 ba fe af a9 b5}
                $a245 = {  a1 9c 9a 81 d1 80 9d 81 8a 9e 8a 87 c9 8b 86 88 8b 8b 97 c2 83 85 ff ac a8 b2}
                $a246 = {  a2 9d 9d 80 d2 81 82 80 89 9f 8d 86 ca 8a 89 89 88 8a 90 c3 80 84 c0 ad ab b3}
                $a247 = {  a3 9e 9c 87 d3 82 83 9f 88 9c 8c 81 cb 89 88 86 89 89 91 c4 81 87 c1 92 aa b0}
                $a248 = {  ac 9f 9f 86 d4 83 80 9e 97 9d 8f 80 cc 88 8b 87 86 88 92 c5 86 86 c2 93 95 b1}
                $a249 = {  ad 90 9e 85 d5 84 81 9d 96 82 8e 83 cd 8f 8a 84 87 87 93 c6 87 81 c3 90 94 8e}
                $a250 = {  ae 91 91 84 d6 85 86 9c 95 83 91 82 ce 8e 8d 85 84 86 9c c7 84 80 c4 91 97 8f}
                $a251 = {  af 92 90 8b d7 86 87 9b 94 80 90 9d cf 8d 8c 82 85 85 9d c8 85 83 c5 96 96 8c}
                $a252 = {  a8 93 93 8a d8 87 84 9a 93 81 93 9c d0 8c 8f 83 82 84 9e c9 8a 82 c6 97 91 8d}
                $a253 = {  a9 94 92 89 d9 88 85 99 92 86 92 9f d1 93 8e 80 83 83 9f ca 8b 8d c7 94 90 8a}
                $a254 = {  aa 95 95 88 da 89 8a 98 91 87 95 9e d2 92 91 81 80 82 98 cb 88 8c c8 95 93 8b}
                $a255 = {  ab 96 94 8f db 8a 8b 97 90 84 94 99 d3 91 90 9e 81 81 99 cc 89 8f c9 9a 92 88}
        condition:
                any of them
}

rule XOR_embeded_exefile_xored_with_round_256_bytes_key {
        meta:
                author = "villys777@gmail.com"
                description = "executable encoded with increment or decremented one byte xor key"
                decription = "extension PDF,XLS,DOC,PPT"
                source = "Yara Exchange"
                date = "2012-07"
                byte_encode = true
        strings:
                $inc = {00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f 80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f 90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 10 11 12 13 14 15 16 17}
                $dec = {17 16 15 14 13 12 11 10 0f 0e 0d 0c 0b 0a 09 08 07 06 05 04 03 02 01 00 ff fe fd fc fb fa f9 f8 f7 f6 f5 f4 f3 f2 f1 f0 ef ee ed ec eb ea e9 e8 e7 e6 e5 e4 e3 e2 e1 e0 df de dd dc db da d9 d8 d7 d6 d5 d4 d3 d2 d1 d0 cf ce cd cc cb ca c9 c8 c7 c6 c5 c4 c3 c2 c1 c0 bf be bd bc bb ba b9 b8 b7 b6 b5 b4 b3 b2 b1 b0 af ae ad ac ab aa a9 a8 a7 a6 a5 a4 a3 a2 a1 a0 9f 9e 9d 9c 9b 9a 99 98 97 96 95 94 93 92 91 90 8f 8e 8d 8c 8b 8a 89 88 87 86 85 84 83 82 81 80 7f 7e 7d 7c 7b 7a 79 78 77 76 75 74 73 72 71 70 6f 6e 6d 6c 6b 6a 69 68 67 66 65 64 63 62 61 60 5f 5e 5d 5c 5b 5a 59 58 57 56 55 54 53 52 51 50 4f 4e 4d 4c 4b 4a 49 48 47 46 45 44 43 42 41 40 3f 3e 3d 3c 3b 3a 39 38 37 36 35 34 33 32 31 30 2f 2e 2d 2c 2b 2a 29 28 27 26 25 24 23 22 21 20 1f 1e 1d 1c 1b 1a 19 18 17 16 15 14 13 12 11 10 0f 0e 0d 0c 0b 0a 09 08 07 06 05 04 03 02 01 00}
        condition:
                $inc or $dec
}

rule KERNEL32_dll_xor_exe_key_239 {
        meta:
                author = "sconzo@visiblerisk.com"
                description = "xor encoded executable"
                string = "KERNEL32.dll"
                key = "239"
                byte_encode = true

        strings:
                $a = { a4 aa bd a1 aa a3 dc dd c1 8b 83 83 }
        condition:
                $a
}

rule kernel32_dll_xor_exe_key_167 {
        meta:
                author = "sconzo@visiblerisk.com"
                description = "xor encoded executable"
                string = "kernel32.dll"
                key = "167"
                byte_encode = true

        strings:
                $a = { cc c2 d5 c9 c2 cb 94 95 89 c3 cb cb }
        condition:
                $a
}

rule xor_0xa7_kernel32_dll {
	strings: 
		$a={ cc c2 d5 c9 c2 cb 94 95 89 c3 cb cb } 
	condition: 
		$a 
}	

rule xor_0xa7_This_program {
	strings: 
		$a={ f3 cf ce d4 87 d7 d5 c8 c0 d5 c6 ca } 
	condition: 
		$a 
}																
